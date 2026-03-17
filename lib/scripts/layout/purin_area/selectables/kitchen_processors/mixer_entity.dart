import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:pomodoropompurin/scripts/core/ui/ui_display_state.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/purin_area_selectable.dart';

class MixerEntity extends PurinAreaSelectable {
  MixerEntity()
    : super(
        position: Vector2(140, -55),
        hitbox: PolygonHitbox(
          [
            Vector2(-10, -50),
            Vector2(20, -30),
            Vector2(20, 0),
            Vector2(0, 10),
            Vector2(-30, 0),
            Vector2(-30, -40),
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
        Flame.images.fromCache("kitchen_processors_sprites/mixer.png"),
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
    game.overlays.add("mixerMenu");
    addOnLoadAnim();
  }
}
