import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/cursor_sprite.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/purin_area_home.dart';

class PurinArea extends FlameGame
    with TapCallbacks, PanDetector, DoubleTapCallbacks {
  late PurinAreaHome purinAreaHome;
  final purinAreaStateManager = PurinAreaStateManager.singleton;

  late Vector2 newPosition;
  late Vector2 newScale;

  /// Assets paths (from assets/images/->...)
  final backgroundAsset = 'L7.png';
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
    super.onLoad();
    purinAreaHome = PurinAreaHome(position: size / 2);
    purinAreaStateManager.jumpToPosition = jumpToPosition;
    newPosition = purinAreaHome.position;
    newScale = purinAreaHome.scale;
    // Add Background (change Component type?)
    /*     add(
      SpriteComponent(
        sprite: Sprite(Flame.images.fromCache(backgroundAsset)),
        size: Vector2(size.x, size.y),
      ),
    ); */
    // Add HomeArea
    add(purinAreaHome);
  }

  void jumpToPosition(Vector2 position) {
    final offsetPosition = Vector2(position.x, position.y + 100);
    final center = size / 2;
    newPosition += center - offsetPosition;
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
    purinAreaStateManager.state = "Transforming";
  }

  @override
  void onTapUp(TapUpEvent event) {
    if (purinAreaStateManager.state != 'Scaling') {
      cursorSprite.removeFromParent();
      purinAreaStateManager.state = "Idle";
    }
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    purinAreaStateManager.state = 'Moving';
  }

  @override
  void onDoubleTapDown(DoubleTapDownEvent event) {
    cursorSprite.removeFromParent();
    cursorSprite = CursorScalingSprite(
      position: event.canvasPosition,
      priority: 999,
    );
    add(cursorSprite);
    purinAreaStateManager.state = "Transforming";
  }

  @override
  void onDoubleTapCancel(DoubleTapCancelEvent event) {
    purinAreaStateManager.state = 'Scaling';
  }

  @override
  void onDoubleTapUp(DoubleTapEvent event) {
    cursorSprite.removeFromParent();
    purinAreaStateManager.state = "Idle";
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    overlays.removeAll(overlays.activeOverlays);
    if (purinAreaStateManager.state == "Moving") {
      cursorSprite.position = info.eventPosition.global;
      newPosition += info.delta.global;
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
    } else if (purinAreaStateManager.state == "Scaling") {
      cursorSprite.position.x = info.eventPosition.global.x;
      newScale -= info.delta.global.yy * 0.005;

      final minScale = 0.4;
      final maxScale = 2.2;

      // Clamping from scaling
      newScale = Vector2(
        newScale.x.clamp(minScale, maxScale),
        newScale.y.clamp(minScale, maxScale),
      );
    }
  }

  @override
  void onPanEnd(DragEndInfo info) {
    cursorSprite.removeFromParent();
    purinAreaStateManager.state = "Idle";
  }

  @override
  void update(double dt) {
    super.update(dt);
    purinAreaHome.position.lerp(newPosition, 0.1);
    purinAreaHome.scale.lerp(newScale, 0.1);
  }
}
