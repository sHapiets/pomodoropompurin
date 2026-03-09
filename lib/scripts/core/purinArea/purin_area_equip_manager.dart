import 'package:flutter/cupertino.dart';
import 'package:pomodoropompurin/scripts/core/acquirables.dart';
import 'package:pomodoropompurin/scripts/foundation/consumable.dart';
import 'package:pomodoropompurin/scripts/foundation/acquirable.dart';
import 'package:pomodoropompurin/scripts/memory/database_manager.dart';

/// A manager class that contains all RoomDesign objects for all selectables
/// in [PurinAreaHome]
///
/// It is the bridge for user customization of owned designs. The logic
/// in changing equipment is simple:
/// (1) A [PurinAreaSelectable] has a overlay menu whenever OnLongTapDown
/// (2) An [EquipTile] is opened in the grid for every owned acuirable, defined
///     in [ProgSystem]
/// (3) When an equip button is pressed, a change function is called in this class
///     of the respective selectable.
/// (4) [PurinAreaSelectable] is updated via listener (ValueNotifier)
///
/// This is a visualization:
/// [EquipTile] -> [PurinAreaEquipManager] -> [PurinAreaSelectable]
class PurinAreaEquipManager {
  PurinAreaEquipManager._();
  static final singleton = PurinAreaEquipManager._();

  final databaseManager = DatabaseManager.singleton;

  ValueNotifier<RoomDesign> kotatsu = ValueNotifier(
    Acquirables.singleton.kotatsus[KotatsuDesigns.pudding]!,
  );
  ValueNotifier<Consumable> feedable = ValueNotifier(Consumable.pizza);
  VoidCallback addFeedableEntity = () {};
  ValueNotifier<int> feedableBitesLeft = ValueNotifier(0);
  ValueNotifier<RoomDesign> blanket = ValueNotifier(
    Acquirables.singleton.blankets[BlanketDesigns.cyan]!,
  );
  ValueNotifier<RoomDesign> futon = ValueNotifier(
    Acquirables.singleton.futons[FutonDesigns.cyan]!,
  );
  ValueNotifier<RoomDesign> refrigerator = ValueNotifier(
    Acquirables.singleton.refrigerators[RefrigeratorDesigns.silver]!,
  );
  ValueNotifier<RoomDesign> studyTable = ValueNotifier(
    Acquirables.singleton.studyTables[StudyTableDesigns.wooden]!,
  );

  ValueNotifier<RoomDesign> floor = ValueNotifier(
    Acquirables.singleton.floors[FloorDesigns.smooth]!,
  );
  ValueNotifier<RoomDesign> interiorWall = ValueNotifier(
    Acquirables.singleton.interiorWalls[InteriorWallDesigns.smooth]!,
  );
  ValueNotifier<RoomDesign> exterior = ValueNotifier(
    Acquirables.singleton.exteriors[ExteriorDesigns.plain]!,
  );

  void changeKotatsu(RoomDesign newKotatsu) {
    kotatsu.value = newKotatsu;
  }

  void biteFeedable(int bitesLeft) {
    feedableBitesLeft.value = bitesLeft;
    databaseManager.configFeedableSave(feedable.value, bitesLeft);
  }

  void addFeedable(Consumable newFeedable, int bitesLeft) {
    feedableBitesLeft.value = bitesLeft;
    feedable.value = newFeedable;
    databaseManager.configFeedableSave(feedable.value, bitesLeft);
    addFeedableEntity();
  }

  void changeBlanket(RoomDesign newBlanket) {
    blanket.value = newBlanket;
  }

  void changeFuton(RoomDesign newFuton) {
    futon.value = newFuton;
  }

  void changeRefrigerator(RoomDesign newRefrigerator) {
    refrigerator.value = newRefrigerator;
  }

  void changeFloor(RoomDesign newFloor) {
    floor.value = newFloor;
  }

  void changeInteriorWall(RoomDesign newInteriorWall) {
    interiorWall.value = newInteriorWall;
  }

  void changeExterior(RoomDesign newExterior) {
    exterior.value = newExterior;
  }
}
