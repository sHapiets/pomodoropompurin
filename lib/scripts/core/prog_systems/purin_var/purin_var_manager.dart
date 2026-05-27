import 'package:pomodoropompurin/scripts/core/prog_systems/purin_var/purin_var.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin_attributes/purin_attributes.dart';

class PurinVarManager {
  PurinVarManager._();
  static final singleton = PurinVarManager._();

  void savePurinVarProgress(PurinVar purinVar, Map<String, int> progress) {}

  int getPurinVarLevel() {
    return 0;
  }

  int getPassiveAttributeBoost(PurinAttributes attribute) {
    int boost = 0;
    /* 
    for (final purinVar in PurinVar.values) {
      boost += purinVar.passiveAttributeBoost();
    } */

    return boost;
  }
}
