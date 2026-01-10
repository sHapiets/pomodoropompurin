import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';

class Kotatsu extends PositionComponent with TapCallbacks, GestureHitboxes {
  Kotatsu() {
    anchor = Anchor.center;
    priority = 50;
  }

  final purinAreaStateManager = PurinAreaStateManager.singleton;

  late SpriteComponent kotatsuSprite;
  final kotatsuHitbox = PolygonHitbox(
    [
      Vector2(0, 85),
      Vector2(100, 30),
      Vector2(80, 10),
      Vector2(0, -30),
      Vector2(-80, 10),
      Vector2(-100, 30),
    ],
    anchor: Anchor.center,
    position: Vector2(190, 210),
  );

  @override
  void onMount() {
    super.onMount();

    kotatsuSprite = SpriteComponent(
      sprite: Sprite(Flame.images.fromCache("purinAreaHome_kotatsu.png")),
      size: Vector2.all(1200),
      anchor: anchor,
    );

    kotatsuHitbox.paint.color = const Color.fromARGB(124, 68, 137, 255);
    //kotatsuHitbox.renderShape = true;
    add(kotatsuSprite);
    add(kotatsuHitbox);
  }

  @override
  void onLongTapDown(TapDownEvent event) {
    purinAreaStateManager.jumpToPosition(event.canvasPosition);
  }
}
