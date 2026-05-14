import 'package:flutter/foundation.dart';
import 'package:pomodoropompurin/scripts/foundation/purin_attributes.dart';

class PurinAttributesManager {
  PurinAttributesManager._();
  static final singleton = PurinAttributesManager._();

  ValueNotifier<int> focus = ValueNotifier(40);
  ValueNotifier<int> diligence = ValueNotifier(40);

  ValueNotifier<int> comfort = ValueNotifier(40);
  ValueNotifier<int> endurance = ValueNotifier(40);
  ValueNotifier<int> metabolism = ValueNotifier(40);

  ValueNotifier<int> nutrition = ValueNotifier(40);
  ValueNotifier<int> palate = ValueNotifier(40);

  ValueNotifier<int> bargaining = ValueNotifier(40);

  void initialize() {
    for (int i = 0; i < PurinAttributes.values.length; i++) {
      final PurinAttributes attribute = PurinAttributes.values[i];
      updateAttributeValue(attribute);
    }
  }

  ValueNotifier<int> _getAttributeNotifier(PurinAttributes attribute) {
    switch (attribute) {
      case PurinAttributes.focus:
        return focus;

      case PurinAttributes.diligence:
        return diligence;

      case PurinAttributes.comfort:
        return comfort;

      case PurinAttributes.endurance:
        return endurance;

      case PurinAttributes.metabolism:
        return metabolism;

      case PurinAttributes.nutrition:
        return nutrition;

      case PurinAttributes.palate:
        return palate;

      case PurinAttributes.bargaining:
        return bargaining;
    }
  }

  int getAttributeValue(PurinAttributes attribute) {
    return _getAttributeNotifier(attribute).value;
  }

  void updateAttributeValue(PurinAttributes attribute) {}
}
