import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/src/events/messages/tap_down_event.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/purin_area_selectable.dart';

class StoveEntity extends PurinAreaSelectable {
  StoveEntity()
    : super(
        position: Vector2(300, 100),
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

  @override
  void onMount() {
    // IMPORTANT: Edit for every changeable RoomDesign (imagepath and size)
    sprite = SpriteComponent(
      sprite: Sprite(
        Flame.images.fromCache("kitchen_processors_sprites/stove.png"),
      ),
      size: Vector2.all(100),
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
