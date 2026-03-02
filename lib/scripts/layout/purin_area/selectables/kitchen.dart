import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/src/events/messages/tap_down_event.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_equip_manager.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/purin_area_selectable.dart';

class Kitchen extends PurinAreaSelectable {
  Kitchen()
    : super(
        position: Vector2(190, 30),
        hitbox: PolygonHitbox([Vector2(1, 1), Vector2(0, 1), Vector2(0, 0)]),
        priority: 40,
      );

  final purinAreaEquipManager = PurinAreaEquipManager.singleton;

  @override
  void onMount() {
    // IMPORTANT: Edit for every changeable RoomDesign (imagepath and size)
    sprite = SpriteComponent(
      sprite: Sprite(Flame.images.fromCache("kitchen_sprites/default.png")),
      size: Vector2.all(400),
      anchor: anchor,
    );

    super.onMount();
  }

  @override
  void onLongTapDown(TapDownEvent event) {
    game.overlays.removeAll(game.overlays.activeOverlays);
    purinAreaStateManager.jumpToPosition(absolutePosition, Vector2(0, 0), 2.0);
    game.overlays.add('kitchenMenu');
  }
}
