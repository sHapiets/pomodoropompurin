import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_equip_manager.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/purin_area_selectable.dart';

class SofaEntity extends PurinAreaSelectable {
  SofaEntity()
    : super(
        //TODO change hitbox and position
        position: Vector2(-315, 285),
        hitbox: PolygonHitbox([Vector2(1, 1), Vector2(0, 1), Vector2(0, 0)]),
        priority: 80,
      );

  final purinAreaEquipManager = PurinAreaEquipManager.singleton;

  @override
  void onMount() {
    // IMPORTANT: Edit for every changeable RoomDesign (imagepath and size)
    sprite = SpriteComponent(
      sprite: Sprite(Flame.images.fromCache('sofa_sprites/default.png')),
      size: Vector2.all(250),
      anchor: anchor,
      scale: Vector2.all(1.2),
    );

    super.onMount();
  }

  @override
  void onLongTapDown(TapDownEvent event) {
    /* super.onLongTapDown(event);
    // add equip menu
    game.overlays.add(''); */
  }
}
