import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:pomodoropompurin/scripts/layout/purinArea/purin_area_home.dart';

class PurinArea extends FlameGame
    with TapCallbacks, PanDetector, DoubleTapCallbacks {
  late PurinAreaHome purinAreaHome;
  final purinAreaStateManager = PurinAreaStateManager.singleton;

  late Vector2 newPosition;
  late Vector2 newScale;

  /// Assets paths (from assets/images/->...)
  final backgroundAsset = 'L7.png';

  @override
  FutureOr<void> onLoad() async {
    purinAreaHome = PurinAreaHome(position: Vector2(0, 0));
    newPosition = purinAreaHome.position;
    newScale = purinAreaHome.scale;
    // Add Background (change Component type?)
    add(
      SpriteComponent(
        sprite: Sprite(Flame.images.fromCache('L7.png')),
        size: Vector2(500, 500),
      ),
    );
    // Add HomeArea
    add(purinAreaHome);
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    purinAreaStateManager.state = 'Moving';
  }

  @override
  void onDoubleTapCancel(DoubleTapCancelEvent event) {
    purinAreaStateManager.state = 'Scaling';
    debugPrint(purinAreaStateManager.state);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    if (purinAreaStateManager.state == "Moving") {
      newPosition += info.delta.global;

      final minX = 0.0;
      final minY = 0.0;
      final maxX = size.x - purinAreaHome.size.x;
      final maxY = size.y - purinAreaHome.size.y;

      // Clamping from out-of-bounds
      newPosition = Vector2(
        newPosition.x.clamp(minX, maxX),
        newPosition.y.clamp(minY, maxY),
      );
    } else if (purinAreaStateManager.state == "Scaling") {
      newScale -= info.delta.global.yy * 0.005;

      final minScale = 0.2;
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
    purinAreaStateManager.state = "Idle";
    debugPrint(purinAreaStateManager.state);
  }

  @override
  void update(double dt) {
    super.update(dt);
    purinAreaHome.position.lerp(newPosition, 0.1);
    purinAreaHome.scale.lerp(newScale, 0.1);
  }
}
