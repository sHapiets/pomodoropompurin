import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/src/events/messages/tap_down_event.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_equip_manager.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/purin_area_selectable.dart';

class Feedable extends PurinAreaSelectable {
  Feedable()
    : super(
        //TODO change hitbox and position
        position: Vector2(180, 190),
        hitbox: PolygonHitbox(
          [
            Vector2(-20, 20),
            Vector2(20, 20),
            Vector2(20, -20),
            Vector2(-20, -20),
          ],
          anchor: Anchor.center,
          position: Vector2.zero(),
        ),
        priority: 60,
      );

  final purinAreaEquipManager = PurinAreaEquipManager.singleton;
  final purin = Purin.singleton;

  int bitesLeft = 0;
  final feedable = PurinAreaEquipManager.singleton.feedable.value!;
  int get biteIndex {
    return bitesLeft - 1;
  }

  @override
  void onMount() {
    bitesLeft = purinAreaEquipManager.feedableBitesLeft.value;
    sprite = SpriteComponent(
      sprite: Sprite(
        Flame.images.fromCache(feedable.biteSpritesFlamePath[biteIndex]),
      ),
      size: Vector2.all(40),
      anchor: anchor,
    );
    hitbox.renderShape = true;

    purin.addListener(bite);

    super.onMount();
  }

  void bite() {
    if (purin.stateManager.action == PurinAction.feed) {
      bitesLeft--;
      purinAreaEquipManager.biteFeedable(bitesLeft);
      if (bitesLeft == 0) {
        removeFromParent();
      } else {
        sprite.sprite = Sprite(
          Flame.images.fromCache(feedable.biteSpritesFlamePath[biteIndex]),
        );
      }
    }
  }

  @override
  void removeFromParent() {
    purin.removeListener(bite);
    super.removeFromParent();
  }

  @override
  void onTapDown(TapDownEvent event) {
    purinAreaStateManager.state.value = 'Feed';
  }

  @override
  void onLongTapDown(TapDownEvent event) {}
}
