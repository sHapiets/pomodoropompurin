import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/dialog/script_dialog/script_manager.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/ui/purin_metrics_ui_state.dart';
import 'package:pomodoropompurin/scripts/core/ui/ui_display_state.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/cursor_sprite.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/dotted_background.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/effects/heart_particles.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/purin_area_home.dart';

class PurinArea extends FlameGame
    with TapCallbacks, PanDetector, DoubleTapCallbacks {
  PurinArea._();
  static final gameSingleton = PurinArea._();

  late PurinAreaHome purinAreaHome;
  final purin = Purin.singleton;
  final purinAreaStateManager = PurinAreaStateManager.singleton;
  final scriptManager = ScriptManager.singleton;

  late Vector2 newPosition;
  late Vector2 newScale;

  double heartParticleTimer = 0;

  /// Assets paths (from assets/images/->...)
  ///
  @override
  Color backgroundColor() => const Color.fromARGB(255, 189, 174, 133);
  /* const Color.fromARGB(255, 163, 210, 200) */
  /* const Color.fromARGB(255, 190, 179, 149) */
  SpriteComponent cursorSprite = CursorMovingSprite(
    position: Vector2.zero(),
    priority: -999,
  );

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    purinAreaHome = PurinAreaHome(position: Vector2.zero());
    purinAreaStateManager.jumpToPosition = jumpToPosition;
    purinAreaStateManager.jumpCenterPositionAndScaled =
        jumpCenterPositionAndScaled;

    newPosition = camera.viewfinder.position.clone();
    newScale = Vector2.all(0.4);
    world.add(purinAreaHome);
  }

  void jumpToPosition(Vector2 position, Vector2 offset, double scale) {
    newPosition = position + offset;
    newScale.x = scale;
  }

  void jumpCenterPositionAndScaled(Vector2 position) {
    newPosition = position;
    newScale.x = 1.5;
  }

  @override
  void onTapDown(TapDownEvent event) {
    UIDisplayState.singleton.hide.value = false;
    overlays.removeAll(overlays.activeOverlays);
    scriptManager.removeAllDialogs();

    /* cursorSprite.removeFromParent();
    cursorSprite = CursorMovingSprite(
      position: event.canvasPosition,
      priority: 999,
    );
    add(cursorSprite); */
    purinAreaStateManager.state.value = "Transforming";
  }

  @override
  void onTapUp(TapUpEvent event) {
    if (purinAreaStateManager.state.value != 'Scaling') {
      cursorSprite.removeFromParent();
      purinAreaStateManager.state.value = "Idle";
    }
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    purinAreaStateManager.state.value = 'Moving';
  }

  @override
  void onDoubleTapDown(DoubleTapDownEvent event) {
    cursorSprite.removeFromParent();
    /*
    cursorSprite = CursorScalingSprite(
      position: event.canvasPosition,
      priority: 999,
    );
    add(cursorSprite); */
    purinAreaStateManager.state.value = "Transforming";
  }

  @override
  void onDoubleTapCancel(DoubleTapCancelEvent event) {
    purinAreaStateManager.state.value = 'Scaling';
  }

  @override
  void onDoubleTapUp(DoubleTapEvent event) {
    cursorSprite.removeFromParent();
    purinAreaStateManager.state.value = "Idle";
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    UIDisplayState.singleton.hide.value = false;
    overlays.removeAll(overlays.activeOverlays);
    scriptManager.removeAllDialogs();
    if (purinAreaStateManager.state.value == "Moving") {
      cursorSprite.position = info.eventPosition.global;

      final zoom = camera.viewfinder.zoom;
      newPosition -= info.delta.global / zoom;

      final minX = -size.x;
      final minY = -size.y;
      final maxX = size.x;
      final maxY = size.y;

      newPosition = Vector2(
        newPosition.x.clamp(minX, maxX),
        newPosition.y.clamp(minY, maxY),
      );
    } else if (purinAreaStateManager.state.value == "Scaling") {
      cursorSprite.position.x = info.eventPosition.global.x;
      newScale -= info.delta.global.yy * 0.005;

      final minScale = 0.4;
      final maxScale = 2.2;

      // Clamping from scaling
      newScale = Vector2(
        newScale.x.clamp(minScale, maxScale),
        newScale.y.clamp(minScale, maxScale),
      );
    } else if (purinAreaStateManager.state.value == "Pet") {
      UIDisplayState.singleton.hide.value = true;
      PurinMetricsUIState.singleton.showWidget();

      purin.updatePetDelta(info.delta.global);
      if (heartParticleTimer <= 0.06) {
        return;
      }
      final worldPosition = camera.globalToLocal(info.eventPosition.global);

      world.add(HeartParticle(position: worldPosition));
      heartParticleTimer = 0;
    }
  }

  @override
  void onPanEnd(DragEndInfo info) {
    UIDisplayState.singleton.hide.value = false;
    PurinMetricsUIState.singleton.hideWidget();
    scriptManager.removeAllDialogs();
    cursorSprite.removeFromParent();
    purinAreaStateManager.state.value = "Idle";
  }

  @override
  void update(double dt) {
    super.update(dt);
    camera.viewfinder.position = Vector2(
      lerpDouble(camera.viewfinder.position.x, newPosition.x, 0.1)!,
      lerpDouble(camera.viewfinder.position.y, newPosition.y, 0.1)!,
    );
    camera.viewfinder.zoom = lerpDouble(
      camera.viewfinder.zoom,
      newScale.x,
      0.1,
    )!;

    heartParticleTimer += dt;
  }
}
