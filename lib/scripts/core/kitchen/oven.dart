import 'package:pomodoropompurin/scripts/core/kitchen/kitchen_processor.dart';
import 'package:pomodoropompurin/scripts/foundation/consumable.dart';
import 'package:pomodoropompurin/scripts/foundation/ingridient.dart';

class Oven extends KitchenProcessor {
  Oven._()
    : super(
        displayName: "oven",
        ingridientIngridients: {},
        consumableIngridients: {
          Consumable.pizza: {Ingridient.dough: 3, Ingridient.pizzaToppings: 1},
        },
      );

  static final singleton = Oven._();
}
