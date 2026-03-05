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
import 'package:pomodoropompurin/scripts/layout/purin_area/selectables/kitchen.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/selectables/kitchen_processors/chopping_board_entity.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/selectables/kitchen_processors/mixer_entity.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/selectables/kitchen_processors/oven_entity.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/selectables/kitchen_processors/sink_entity.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/selectables/kitchen_processors/stove_entity.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/selectables/kotatsu.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/selectables/kitchen_processors/refrigerator_entity.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/selectables/shop/shop_entity.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/selectables/study_chair.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/selectables/study_table.dart';

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
  late StudyTable studyTableEntity;
  late StudyChair studyChairEntity;

  late ShopEntity shopEntity;

  late Kitchen kitchenEntity;
  late RefrigeratorEntity refrigeratorEntity;
  late StoveEntity stoveEntity;
  late SinkEntity sinkEntity;
  late OvenEntity ovenEntity;
  late MixerEntity mixerEntity;
  late ChoppingBoardEntity choppingBoardEntity;

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
    feedableEntity = Feedable();
    blanketEntity = Blanket();
    futonEntity = Futon();
    studyTableEntity = StudyTable();
    studyChairEntity = StudyChair();

    shopEntity = ShopEntity();

    kitchenEntity = Kitchen();
    refrigeratorEntity = RefrigeratorEntity();
    stoveEntity = StoveEntity();
    sinkEntity = SinkEntity();
    ovenEntity = OvenEntity();
    mixerEntity = MixerEntity();
    choppingBoardEntity = ChoppingBoardEntity();

    purinEntity = PurinEntity();

    floorEntity = Floor();
    exteriorEntity = Exterior();
    interiorWallEntity = InteriorWall();

    await add(floorEntity);
    await add(kotatsuEntity);
    await add(futonEntity);
    await add(blanketEntity);
    await add(refrigeratorEntity);
    await add(studyTableEntity);
    await add(studyChairEntity);
    await add(shopEntity);
    await add(kitchenEntity);
    await add(stoveEntity);
    await add(sinkEntity);
    await add(ovenEntity);
    await add(mixerEntity);
    await add(choppingBoardEntity);

    await add(purinEntity);
    await add(interiorWallEntity);
    await add(exteriorEntity);

    await add(onLoadAnim);

    await addFeedable();
    purinAreaEquipManager.addFeedableEntity = addFeedable;
  }

  Future<void> addFeedable() async {
    if (purinAreaEquipManager.feedableBitesLeft.value == 0) {
      return;
    }
    await add(feedableEntity);
  }
}
