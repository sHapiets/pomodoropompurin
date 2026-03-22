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
  late SequenceEffect onLoadAnim;

  @override
  Future<void> onMount() async {
    super.onMount();
    _addNextBatch();
  }

  Future<void> _addNextBatch() async {
    final components = [
      Floor(),
      Kotatsu(),
      Futon(),
      Blanket(),
      RefrigeratorEntity(),
      StudyTable(),
      StudyChair(),
      ShopEntity(),
      Kitchen(),
      StoveEntity(),
      SinkEntity(),
      OvenEntity(),
      MixerEntity(),
      ChoppingBoardEntity(),
      PurinEntity(),
      InteriorWall(),
      Exterior(),
    ];

    for (final c in components) {
      add(c);
      await Future.delayed(Duration(milliseconds: 2));
    }

    await addFeedable();
  }

  Future<void> addFeedable() async {
    if (purinAreaEquipManager.feedableBitesLeft.value == 0) {
      return;
    }
    await add(Feedable());
  }
}
