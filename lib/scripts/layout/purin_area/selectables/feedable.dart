import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/src/events/messages/tap_down_event.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_equip_manager.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/purin_area_selectable.dart';

class Feedable extends PurinAreaSelectable {
  Feedable()
    : super(
        position: Vector2(180, 220),
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
        priority: 60,
      );

  final purinAreaEquipManager = PurinAreaEquipManager.singleton;
  final purinAreaStateManager = PurinAreaStateManager.singleton;

  final feedable = PurinAreaEquipManager.singleton.feedable.value!;
  int bitesLeft = 0;
  int get biteIndex {
    return bitesLeft - 1;
  }

  @override
  void onMount() {
    bitesLeft = feedable.totalBites;
    sprite = SpriteComponent(
      sprite: Sprite(
        Flame.images.fromCache(feedable.biteSpritesFlamePath[biteIndex]),
      ),
      size: Vector2.all(40),
      anchor: anchor,
    );

    super.onMount();
  }

  void updateBiteSprite() {
    bitesLeft--;
    feedable.biteSpritesFlamePath[biteIndex];
  }

  @override
  void onTapDown(TapDownEvent event) {
    purinAreaStateManager.state.value = 'Feed';
  }

  @override
  void onLongTapDown(TapDownEvent event) {}
}
