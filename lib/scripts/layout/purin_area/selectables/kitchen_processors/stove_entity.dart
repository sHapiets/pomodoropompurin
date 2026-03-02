import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/src/events/messages/tap_down_event.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/purin_area_selectable.dart';

class StoveEntity extends PurinAreaSelectable {
  StoveEntity()
    : super(
        position: Vector2(320, 5),
        hitbox: PolygonHitbox(
          [
            Vector2(0, 10),
            Vector2(45, -8),
            Vector2(45, -20),
            Vector2(0, -45),
            Vector2(-50, -20),
            Vector2(-50, -8),
          ],
          anchor: Anchor.center,
          position: Vector2(0, -5),
        ),
        priority: 50,
      );

  @override
  void onMount() {
    // IMPORTANT: Edit for every changeable RoomDesign (imagepath and size)
    sprite = SpriteComponent(
      sprite: Sprite(
        Flame.images.fromCache("kitchen_processors_sprites/stove.png"),
      ),
      size: Vector2.all(130),
      anchor: anchor,
    );

    super.onMount();
  }

  @override
  void onLongTapDown(TapDownEvent event) {
    game.overlays.removeAll(game.overlays.activeOverlays);
    purinAreaStateManager.jumpToPosition(
      absolutePosition,
      Vector2(0, -100),
      2.0,
    );
    game.overlays.add("stoveMenu");
  }
}
