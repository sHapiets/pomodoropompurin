import 'package:pomodoropompurin/scripts/core/acquirables.dart';
import 'package:pomodoropompurin/scripts/core/prog_system.dart';
import 'package:pomodoropompurin/scripts/foundation/acquirable.dart';

class PurinAreaEquipManager {
  PurinAreaEquipManager._();
  static final singleton = PurinAreaEquipManager._();

  RoomDesign kotatsu = Acquirables.singleton.acquirableRoomDesign['default']!;

  void Function(RoomDesign) changeKotatsu = (kotatsu) {};
}
