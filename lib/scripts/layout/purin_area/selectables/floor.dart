import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_equip_manager.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/purin_area_selectable.dart';

class Floor extends PurinAreaSelectable {
  Floor()
    : super(
        position: Vector2(0, 0),

        /// TODO: CHANGE FLOOR HITBOX
        hitbox: PolygonHitbox(
          [
            Vector2(0, 75),
            Vector2(90, 30),
            Vector2(70, 10),
            Vector2(0, -30),
            Vector2(-70, 10),
            Vector2(-90, 30),
          ],
          anchor: Anchor.center,
          position: Vector2(0, -10),
        ),
        priority: 20,
      );

  final purinAreaEquipManager = PurinAreaEquipManager.singleton;

  @override
  void onMount() {
    // IMPORTANT: Edit for every changeable RoomDesign (imagepath and size)
    sprite = SpriteComponent(
      sprite: Sprite(
        Flame.images.fromCache(
          purinAreaEquipManager.floor.value.spriteFlamePath,
        ),
      ),
      size: Vector2.all(1200),
      anchor: anchor,
    );

    // IMPORTANT: Edit for every changeable RoomDesign
    purinAreaEquipManager.floor.addListener(updateFloorDesign);

    super.onMount();
  }

  void updateFloorDesign() {
    // IMPORTANT: Edit for every changeable RoomDesign
    super.changeDesign(purinAreaEquipManager.floor.value);
  }

  @override
  void onLongTapDown(TapDownEvent event) {
    super.onLongTapDown(event);
    // IMPORTANT: Edit for every changeable RoomDesign
    game.overlays.add('kotatsuMenu');
  }
}
