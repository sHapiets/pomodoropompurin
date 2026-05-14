import 'package:pomodoropompurin/scripts/core/acquirables.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/purin_var/purin_var.dart';
import 'package:pomodoropompurin/scripts/foundation/purin_attributes.dart';

class PurinVarManager {
  PurinVarManager._();
  static final singleton = PurinVarManager._();

  void savePurinVarProgress(PurinVar purinVar, Map<String, int> progress) {}

  int getAttributeBoost(PurinAttributes attribute) {}
}
