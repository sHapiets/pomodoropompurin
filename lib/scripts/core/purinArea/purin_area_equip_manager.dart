import 'package:flutter/cupertino.dart';
import 'package:pomodoropompurin/scripts/core/acquirables.dart';
import 'package:pomodoropompurin/scripts/foundation/consumable.dart';
import 'package:pomodoropompurin/scripts/foundation/acquirable.dart';

class PurinAreaEquipManager {
  PurinAreaEquipManager._();
  static final singleton = PurinAreaEquipManager._();

  ValueNotifier<RoomDesign> kotatsu = ValueNotifier(
    Acquirables.singleton.kotatsus[KotatsuDesigns.pudding]!,
  );
  ValueNotifier<Consumable?> feedable = ValueNotifier(Consumable.pudding);
  ValueNotifier<RoomDesign> blanket = ValueNotifier(
    Acquirables.singleton.blankets[BlanketDesigns.cyan]!,
  );
  ValueNotifier<RoomDesign> futon = ValueNotifier(
    Acquirables.singleton.futons[FutonDesigns.cyan]!,
  );
  ValueNotifier<RoomDesign> refrigerator = ValueNotifier(
    Acquirables.singleton.refrigerators[RefrigeratorDesigns.silver]!,
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

  void addFeedable(Consumable newFeedable) {
    feedable.value = newFeedable;
  }

  void removeFeedable() {
    feedable.value = null;
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
