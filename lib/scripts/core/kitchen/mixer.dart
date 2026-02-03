import 'package:pomodoropompurin/scripts/core/kitchen/kitchen_processor.dart';
import 'package:pomodoropompurin/scripts/foundation/ingridient.dart';

class Mixer extends KitchenProcessor {
  Mixer._()
    : super(
        ingridientIngridients: {
          Ingridient.puddingCream: {Ingridient.eggs: 1, Ingridient.milk: 1},
          Ingridient.dough: {Ingridient.flour: 1, Ingridient.yeast: 1},
          Ingridient.patty: {
            Ingridient.choppedOnions: 1,
            Ingridient.groundPork: 1,
          },
        },
        consumableIngridients: {},
      );
  static final singleton = Mixer._();
}
