import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_equip_manager.dart';
import 'package:pomodoropompurin/scripts/foundation/acquirable.dart';
import 'package:pomodoropompurin/scripts/layout/purinArea/purin_area_selectable.dart';

/// A selectable object for PurinArea, creating a comfy and customizeable kotatsu inside
///  Purin's home.
///
/// This class was actually constructed before the super selectable class,
/// PurinAreaSelectable. It was made to make my life a bit easier, creating a general
/// format in constructing all the other selectables.
/// Kindly refer to the super class for a concise understanding of selectables, since
/// it will also recommend to use this class as a guide to construct another selectable
/// class.
class Kotatsu extends PurinAreaSelectable {
  /// Both position and the hitbox component is initialized. A manual construction of these
  /// properties is necessity for each selectable
  Kotatsu()
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
        priority: 50,
      );

  final purinAreaEquipManager = PurinAreaEquipManager.singleton;

  @override
  void onMount() {
    // IMPORTANT: Edit for every changeable RoomDesign (imagepath and size)
    sprite = SpriteComponent(
      sprite: Sprite(
        Flame.images.fromCache(purinAreaEquipManager.kotatsu.iconAssetPath),
      ),
      size: Vector2.all(250),
      anchor: anchor,
    );

    // IMPORTANT: Edit for every changeable RoomDesign
    purinAreaEquipManager.changeKotatsu = changeDesign;

    super.onMount();
  }

  @override
  void changeDesign(RoomDesign newRoomDesign) {
    super.changeDesign(newRoomDesign);
    // IMPORTANT: Edit for every changeable RoomDesign
    purinAreaEquipManager.kotatsu = newRoomDesign;
  }

  @override
  void onLongTapDown(TapDownEvent event) {
    super.onLongTapDown(event);
    // IMPORTANT: Edit for every changeable RoomDesign
    game.overlays.add('kotatsuMenu');
  }
}
