import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:pomodoropompurin/scripts/layout/purin/purin_entity.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/selectables/kotatsu.dart';

class PurinAreaHome extends PositionComponent with TapCallbacks {
  PurinAreaHome({required Vector2 position}) {
    this.position = position;
    anchor = Anchor.center;
  }

  final purinAreaStateManager = PurinAreaStateManager.singleton;
  late PurinEntity purinEntity;
  late SequenceEffect onLoadAnim;

  @override
  Future<void> onMount() async {
    super.onMount();
    scale = Vector2.all(0.01);

    addOnLoadAnim();
    // Home Sprite
    add(
      SpriteComponent(
        sprite: Sprite(Flame.images.fromCache('purinAreaHome_floor.png')),
        size: Vector2.all(1200),
        anchor: anchor,
        priority: 10,
      ),
    );
    add(
      SpriteComponent(
        sprite: Sprite(Flame.images.fromCache('purinAreaHome_stairs.png')),
        size: Vector2.all(1200),
        anchor: anchor,
        priority: 11,
      ),
    );
    purinEntity = PurinEntity();
    add(Kotatsu());
    add(purinEntity);
  }

  void addOnLoadAnim() {
    onLoadAnim = SequenceEffect([
      ScaleEffect.to(
        Vector2.all(1.4),
        EffectController(duration: 0.15, curve: Curves.easeOut),
      ),
      ScaleEffect.to(
        Vector2.all(0.6),
        EffectController(duration: 0.15, curve: Curves.easeIn),
      ),
      ScaleEffect.to(
        Vector2.all(1.1),
        EffectController(duration: 0.15, curve: Curves.easeOut),
      ),
      ScaleEffect.to(
        Vector2.all(0.9),
        EffectController(duration: 0.15, curve: Curves.easeIn),
      ),
      ScaleEffect.to(
        Vector2.all(1),
        EffectController(duration: 0.15, curve: Curves.easeOut),
      ),
    ]);
    add(onLoadAnim);
  }
}
