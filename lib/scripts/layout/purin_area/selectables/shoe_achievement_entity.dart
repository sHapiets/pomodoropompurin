import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_equip_manager.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/purin_area_selectable.dart';

class ShoeAchievementEntity extends PurinAreaSelectable {
  ShoeAchievementEntity()
    : super(
        position: Vector2(180, 220),
        hitbox: PolygonHitbox(
          [
            Vector2(0, 90),
            Vector2(105, 25),
            Vector2(90, 0),
            Vector2(0, -50),
            Vector2(-90, 0),
            Vector2(-105, 25),
          ],
          anchor: Anchor.center,
          position: Vector2(0, -10),
        ),
        priority: 50,
      );

  final purinAreaEquipManager = PurinAreaEquipManager.singleton;

  @override
  void onMount() {
    // IMPORTANT: Edit for every changeable RoomDesign (imagepath and size)
    sprite = SpriteComponent(
      sprite: Sprite(
        Flame.images.fromCache(
          purinAreaEquipManager.kotatsu.value.spriteFlamePath,
        ),
      ),
      size: Vector2.all(320),
      anchor: anchor,
    );

    // IMPORTANT: Edit for every changeable RoomDesign
    purinAreaEquipManager.kotatsu.addListener(updateShoeAchievementOnDisplay);

    super.onMount();
  }

  void updateShoeAchievementOnDisplay() {}
}
