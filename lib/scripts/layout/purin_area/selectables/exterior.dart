import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_equip_manager.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/purin_area_selectable.dart';

class Exterior extends PurinAreaSelectable {
  Exterior()
    : super(
        position: Vector2(0, 0),
        //TODO: Change Hitbox
        hitbox: PolygonHitbox([Vector2(1, 1), Vector2(0, 1), Vector2(0, 0)]),
        priority: 100,
      );

  final purinAreaEquipManager = PurinAreaEquipManager.singleton;

  @override
  void onMount() {
    // IMPORTANT: Edit for every changeable RoomDesign (imagepath and size)
    sprite = SpriteComponent(
      sprite: Sprite(
        Flame.images.fromCache(
          purinAreaEquipManager.exterior.value.spriteFlamePath,
        ),
      ),
      size: Vector2.all(1200),
      anchor: anchor,
    );

    // IMPORTANT: Edit for every changeable RoomDesign
    purinAreaEquipManager.exterior.addListener(updateExteriorDesign);

    super.onMount();
  }

  void updateExteriorDesign() {
    // IMPORTANT: Edit for every changeable RoomDesign
    super.changeDesign(purinAreaEquipManager.exterior.value);
  }

  @override
  void onLongTapDown(TapDownEvent event) {
    super.onLongTapDown(event);
    // TODO: Add overlay equip menu
    game.overlays.add('');
  }
}
