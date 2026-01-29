import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_equip_manager.dart';
import 'package:pomodoropompurin/scripts/layout/purin/purin_entity.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/load_animation.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/selectables/blanket.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/selectables/exterior.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/selectables/feedable.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/selectables/floor.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/selectables/futon.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/selectables/interior_wall.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/selectables/kotatsu.dart';

class PurinAreaHome extends PositionComponent with TapCallbacks {
  PurinAreaHome({required Vector2 position}) {
    this.position = position;
    anchor = Anchor.center;
  }

  final purinAreaEquipManager = PurinAreaEquipManager.singleton;

  late Kotatsu kotatsuEntity;
  late Feedable feedableEntity;
  late Blanket blanketEntity;
  late Futon futonEntity;

  late PurinEntity purinEntity;

  late Floor floorEntity;
  late Exterior exteriorEntity;
  late InteriorWall interiorWallEntity;

  late SequenceEffect onLoadAnim;

  @override
  Future<void> onMount() async {
    super.onMount();

    onLoadAnim = LoadAnimation();

    kotatsuEntity = Kotatsu();
    blanketEntity = Blanket();
    futonEntity = Futon();

    purinEntity = PurinEntity();

    floorEntity = Floor();
    exteriorEntity = Exterior();
    interiorWallEntity = InteriorWall();

    await add(floorEntity);
    await add(kotatsuEntity);
    await add(futonEntity);
    await add(blanketEntity);
    await add(purinEntity);
    await add(interiorWallEntity);
    await add(exteriorEntity);

    await add(onLoadAnim);
    await addFeedable();
  }

  Future<void> addFeedable() async {
    feedableEntity = Feedable();
    await add(feedableEntity);
  }

  void removeFeedable() {
    feedableEntity.removeFromParent();
  }
}
