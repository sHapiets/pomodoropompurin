import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:pomodoropompurin/scripts/layout/purin/purin_anim.dart';

class PurinEntity extends PositionComponent with TapCallbacks, GestureHitboxes {
  PurinEntity() {
    anchor = Anchor.center;
    priority = 20;
  }

  final purinAreaStateManager = PurinAreaStateManager.singleton;

  late PurinAnim purinAnim;
  late SpriteComponent purinSprite;
  late PolygonHitbox purinHitbox;

  @override
  void onMount() {
    super.onMount();
    position = Vector2(130, 160);

    purinAnim = PurinAnim();
    purinSprite = SpriteComponent(
      sprite: Sprite(Flame.images.fromCache('purinEntity.png')),
      size: Vector2.all(70),
      position: Vector2(0, 0),
      anchor: Anchor.center,
    );

    /// just a scalingAnim (breathing..)
    add(purinAnim);
    add(purinSprite);

    //sample hitbox, to put in center first!
    final hitbox = CircleHitbox(
      radius: 25,
      anchor: Anchor.center, // <-- remember this
    );
    hitbox.paint.color = const Color.fromARGB(135, 68, 137, 255);
    //hitbox.renderShape = true;
    add(hitbox);
  }

  @override
  void onLongTapDown(TapDownEvent event) {
    purinAreaStateManager.jumpToPosition(absolutePosition);
    debugPrint("$absolutePosition");
    // ... open menu and stuff
  }
}
