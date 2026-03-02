import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_equip_manager.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/purin_area_selectable.dart';

class RefrigeratorEntity extends PurinAreaSelectable {
  RefrigeratorEntity()
    : super(
        //TODO change hitbox and position
        position: Vector2(-30, 65),
        hitbox: PolygonHitbox(
          [
            Vector2(0, 100),
            Vector2(60, 70),
            Vector2(60, -80),
            Vector2(0, -100),
            Vector2(-60, -70),
            Vector2(-60, 80),
          ],
          anchor: Anchor.center,
          position: Vector2(0, -15),
        ),
        priority: 50,
      );

  final purinAreaEquipManager = PurinAreaEquipManager.singleton;

  @override
  void onMount() {
    // IMPORTANT: Edit for every changeable RoomDesign (imagepath and size)
    sprite = SpriteComponent(
      sprite: Sprite(
        Flame.images.fromCache("refrigerator_sprites/default.png"),
      ),
      size: Vector2.all(300),
      anchor: anchor,
    );

    purinAreaEquipManager.refrigerator.addListener(updateRefrigeratorDesign);

    super.onMount();
  }

  void updateRefrigeratorDesign() {
    super.changeDesign(purinAreaEquipManager.refrigerator.value);
  }

  @override
  void onLongTapDown(TapDownEvent event) {
    game.overlays.removeAll(game.overlays.activeOverlays);
    purinAreaStateManager.jumpToPosition(
      absolutePosition,
      Vector2(0, -100),
      2.0,
    );
    game.overlays.add("refrigeratorMenu");
  }
}
