import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_equip_manager.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/purin_area_selectable.dart';

class Blanket extends PurinAreaSelectable {
  Blanket()
    : super(
        position: Vector2(-15, 380),
        hitbox: PolygonHitbox([Vector2(1, 1), Vector2(0, 1), Vector2(0, 0)]),
        priority: 50,
      );

  final purinAreaEquipManager = PurinAreaEquipManager.singleton;

  @override
  void onMount() {
    // IMPORTANT: Edit for every changeable RoomDesign (imagepath and size)
    sprite = SpriteComponent(
      sprite: Sprite(
        Flame.images.fromCache(
          purinAreaEquipManager.blanket.value.spriteFlamePath,
        ),
      ),
      size: Vector2.all(250),
      anchor: anchor,
    );

    // IMPORTANT: Edit for every changeable RoomDesign
    //purinAreaEquipManager.blanket.addListener(updateBlanketDesign);

    super.onMount();
  }

  void updateBlanketDesign() {
    // IMPORTANT: Edit for every changeable RoomDesign
    super.changeDesign(purinAreaEquipManager.blanket.value);
  }

  @override
  void onLongTapDown(TapDownEvent event) {
    super.onLongTapDown(event);
    // TODO: Overlay , should be the same as Futon!
  }
}
