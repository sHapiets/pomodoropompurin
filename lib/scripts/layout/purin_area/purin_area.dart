import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/cursor_sprite.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/purin_area_home.dart';

class PurinArea extends FlameGame
    with TapCallbacks, PanDetector, DoubleTapCallbacks {
  late PurinAreaHome purinAreaHome;
  final purin = Purin.singleton;
  final purinAreaStateManager = PurinAreaStateManager.singleton;

  late Vector2 newPosition;
  late Vector2 newScale;

  /// Assets paths (from assets/images/->...)
  @override
  Color backgroundColor() => const Color.fromARGB(255, 190, 179, 149);
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
    newScale = Vector2.all(1);
    // Add Background (change Component type?)
    /*     add(
      SpriteComponent(
        sprite: Sprite(Flame.images.fromCache(backgroundAsset)),
        size: Vector2(size.x, size.y),
      ),
    ); */
    // Add HomeArea
    world.add(purinAreaHome);
  }

  void jumpToPosition(Vector2 position) {
    final offsetPosition = Vector2(position.x + 100, position.y - 100);
    newPosition = offsetPosition;
    newScale.x = 1.0;
  }

  void jumpCenterPositionAndScaled(Vector2 position) {
    newPosition = position;
    newScale.x = 1.5;
  }

  @override
  void onTapDown(TapDownEvent event) {
    overlays.removeAll(overlays.activeOverlays);

    cursorSprite.removeFromParent();
    cursorSprite = CursorMovingSprite(
      position: event.canvasPosition,
      priority: 999,
    );
    add(cursorSprite);
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
    cursorSprite = CursorScalingSprite(
      position: event.canvasPosition,
      priority: 999,
    );
    add(cursorSprite);
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
    overlays.removeAll(overlays.activeOverlays);
    if (purinAreaStateManager.state.value == "Moving") {
      cursorSprite.position = info.eventPosition.global;

      final zoom = camera.viewfinder.zoom;
      newPosition -= info.delta.global / zoom;
      /* 
      final minX = 0.0;
      final minY = 0.0;
      final maxX = size.x - purinAreaHome.size.x;
      final maxY = size.y - purinAreaHome.size.y;

      // Clamping from out-of-bounds
      newPosition = Vector2(
        newPosition.x.clamp(minX, maxX),
        newPosition.y.clamp(minY, maxY),
      ); */
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
      purin.updatePetDelta(info.delta.global);
      jumpCenterPositionAndScaled(purinAreaHome.purinEntity.absolutePosition);
    }
  }

  @override
  void onPanEnd(DragEndInfo info) {
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
  }
}
