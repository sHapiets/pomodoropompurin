import 'package:flutter/cupertino.dart';
import 'package:pomodoropompurin/scripts/core/acquirables.dart';
import 'package:pomodoropompurin/scripts/core/prog_system.dart';
import 'package:pomodoropompurin/scripts/foundation/acquirable.dart';

class PurinAreaEquipManager {
  PurinAreaEquipManager._();
  static final singleton = PurinAreaEquipManager._();

  ValueNotifier<RoomDesign> kotatsu = ValueNotifier(
    Acquirables.singleton.kotatsus[KotatsuDesigns.pudding]!,
  );

  void changeKotatsu(RoomDesign newKotatsu) {
    kotatsu.value = newKotatsu;
  }
}
