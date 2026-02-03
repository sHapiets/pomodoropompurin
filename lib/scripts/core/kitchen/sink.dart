import 'package:pomodoropompurin/scripts/core/kitchen/kitchen_processor.dart';
import 'package:pomodoropompurin/scripts/foundation/ingridient.dart';

class Sink extends KitchenProcessor {
  Sink._()
    : super(
        ingridientIngridients: {
          Ingridient.washedRice: {Ingridient.riceGrains: 1},
        },
        consumableIngridients: {},
      );

  static final singleton = Sink._();
}
