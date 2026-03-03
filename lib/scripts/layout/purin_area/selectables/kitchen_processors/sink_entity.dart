import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:pomodoropompurin/scripts/core/ui/ui_display_state.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/purin_area_selectable.dart';

class SinkEntity extends PurinAreaSelectable {
  SinkEntity()
    : super(
        position: Vector2(90, -25),
        hitbox: PolygonHitbox(
          [Vector2(15, 60), Vector2(80, 30), Vector2(30, 10), Vector2(-30, 40)],
          anchor: Anchor.center,
          position: Vector2(0, 5),
        ),
        priority: 50,
      );

  @override
  void onMount() {
    // IMPORTANT: Edit for every changeable RoomDesign (imagepath and size)
    sprite = SpriteComponent(
      sprite: Sprite(
        Flame.images.fromCache("kitchen_processors_sprites/sink.png"),
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
    game.overlays.add("sinkMenu");
  }
}
