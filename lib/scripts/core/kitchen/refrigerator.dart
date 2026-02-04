import 'package:pomodoropompurin/scripts/core/kitchen/kitchen_processor.dart';
import 'package:pomodoropompurin/scripts/foundation/consumable.dart';
import 'package:pomodoropompurin/scripts/foundation/ingridient.dart';

class Refrigerator extends KitchenProcessor {
  Refrigerator._()
    : super(
        displayName: "refrigerator",
        ingridientIngridients: {},
        consumableIngridients: {
          Consumable.pudding: {Ingridient.puddingBatter: 1},
        },
      );

  static final singleton = Refrigerator._();
}
