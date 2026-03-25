import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_equip_manager.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
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
import 'package:pomodoropompurin/scripts/layout/purin_area/selectables/shop/snack_shop_entity.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/selectables/sofa_entity.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/selectables/study_chair.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/selectables/study_table.dart';

class PurinAreaHome extends PositionComponent with TapCallbacks {
  PurinAreaHome({required Vector2 position}) {
    this.position = position;
    anchor = Anchor.center;
  }

  final purinAreaEquipManager = PurinAreaEquipManager.singleton;
  late SequenceEffect onLoadAnim;

  @override
  Future<void> onMount() async {
    super.onMount();
    addSequentialEntities();
    purinAreaEquipManager.addFeedableEntity = addFeedable;
  }

  Future<void> addSequentialEntities() async {
    final List<Future<void> Function()> entitiesAdder = [
      () async => add(Floor()),
      () async => add(Kotatsu()),

      () async {
        add(Futon());
        add(Blanket());
      },

      () async => add(RefrigeratorEntity()),
      () async => add(SnackShopEntity()),
      () async => add(StudyTable()),
      () async => add(SofaEntity()),
      () async => add(StudyChair()),
      () async => add(ShopEntity()),
      () async => add(Kitchen()),
      () async => add(StoveEntity()),
      () async => add(SinkEntity()),
      () async => add(OvenEntity()),
      () async => add(MixerEntity()),
      () async => add(ChoppingBoardEntity()),

      () async {
        add(InteriorWall());
        add(Exterior());
      },

      () async {
        await addFeedable();
      },

      () async {
        await Future.delayed(Duration(seconds: 1));
        add(PurinEntity());
      },
    ];

    for (final adderFunction in entitiesAdder) {
      await adderFunction();
      await Future.delayed(Duration(milliseconds: 30));
    }
  }

  Future<void> addFeedable() async {
    if (purinAreaEquipManager.feedableBitesLeft.value == 0) {
      return;
    }
    await add(Feedable());
  }
}
