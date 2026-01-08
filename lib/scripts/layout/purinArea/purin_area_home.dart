import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:pomodoropompurin/scripts/layout/purin/purin_entity.dart';

class PurinAreaHome extends PositionComponent with TapCallbacks {
  PurinAreaHome({required Vector2 position}) {
    this.position = position;
    anchor = Anchor.center;
  }

  final purinAreaStateManager = PurinAreaStateManager.singleton;

  late PurinEntity purinEntity;

  @override
  Future<void> onLoad() async {
    add(
      SpriteComponent(
        sprite: Sprite(Flame.images.fromCache('SamplePurinArea.png')),
        anchor: anchor,
      ),
    );
    purinEntity = PurinEntity(position: Vector2(0, 0), anchor: anchor);
    add(purinEntity);
  }
}
