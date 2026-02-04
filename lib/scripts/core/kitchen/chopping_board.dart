import 'package:pomodoropompurin/scripts/core/kitchen/kitchen_processor.dart';
import 'package:pomodoropompurin/scripts/foundation/ingridient.dart';

class ChoppingBoard extends KitchenProcessor {
  ChoppingBoard._()
    : super(
        displayName: "chopping",
        ingridientIngridients: {
          Ingridient.pizzaToppings: {
            Ingridient.tomato: 2,
            Ingridient.olives: 2,
          },
        },
        consumableIngridients: {},
      );

  static final singleton = ChoppingBoard._();
}
