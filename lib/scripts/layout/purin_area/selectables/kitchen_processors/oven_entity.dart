import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/src/events/messages/tap_down_event.dart';
import 'package:pomodoropompurin/scripts/core/ui/ui_display_state.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/purin_area_selectable.dart';

class OvenEntity extends PurinAreaSelectable {
  OvenEntity()
    : super(
        position: Vector2(260, 58),
        hitbox: PolygonHitbox(
          [Vector2(90, 50), Vector2(90, 110), Vector2(0, 70), Vector2(0, 10)],
          anchor: Anchor.center,
          position: Vector2(0, -0),
        ),
        priority: 50,
      );

  @override
  void onMount() {
    // IMPORTANT: Edit for every changeable RoomDesign (imagepath and size)
    sprite = SpriteComponent(
      sprite: Sprite(
        Flame.images.fromCache("kitchen_processors_sprites/oven.png"),
      ),
      size: Vector2.all(130),
      anchor: anchor,
    );

    super.onMount();
  }

  @override
  void onLongTapDown(TapDownEvent event) {
    UIDisplayState.singleton.hide.value = true;
    game.overlays.removeAll(game.overlays.activeOverlays);
    purinAreaStateManager.jumpToPosition(
      absolutePosition,
      Vector2(0, -100),
      2.0,
    );
    game.overlays.add("ovenMenu");
  }
}
