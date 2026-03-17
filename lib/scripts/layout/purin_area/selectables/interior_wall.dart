import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_equip_manager.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/purin_area_selectable.dart';

class InteriorWall extends PurinAreaSelectable {
  InteriorWall()
    : super(
        position: Vector2(0, 0),
        // TODO: Change Hitbox
        hitbox: PolygonHitbox([Vector2(1, 1), Vector2(0, 1), Vector2(0, 0)]),
        priority: 10,
      );

  final purinAreaEquipManager = PurinAreaEquipManager.singleton;

  @override
  void onMount() {
    // IMPORTANT: Edit for every changeable RoomDesign (imagepath and size)
    sprite = SpriteComponent(
      sprite: Sprite(
        Flame.images.fromCache(
          purinAreaEquipManager.interiorWall.value.spriteFlamePath,
        ),
      ),
      size: Vector2.all(1200),
      anchor: anchor,
    );

    // IMPORTANT: Edit for every changeable RoomDesign
    purinAreaEquipManager.interiorWall.addListener(updateInteriorWallDesign);

    super.onMount();
  }

  void updateInteriorWallDesign() {
    // IMPORTANT: Edit for every changeable RoomDesign
    super.changeDesign(purinAreaEquipManager.interiorWall.value);
  }

  @override
  void onLongTapDown(TapDownEvent event) {
    super.onLongTapDown(event);
    // TODO: Add overlay for equip?
  }
}
