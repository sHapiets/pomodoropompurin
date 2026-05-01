import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/kitchen/kitchen_processor.dart';
import 'package:pomodoropompurin/scripts/foundation/consumable.dart';
import 'package:pomodoropompurin/scripts/foundation/ingridient.dart';

class Stove extends KitchenProcessor {
  Stove._()
    : super(
        displayName: "stove",
        processIcon: Icons.fireplace_rounded,
        processColor: Colors.amber,
        ingridientIngridients: {
          Ingridient.puddingBatter: {
            Ingridient.puddingCream: 1,
            Ingridient.butter: 1,
          },
          Ingridient.cookedRice: {Ingridient.washedRice: 1},
          Ingridient.omelette: {Ingridient.eggs: 2, Ingridient.butter: 1},
          Ingridient.lasagnaSauce: {
            Ingridient.creamySauce: 1,
            Ingridient.tomatoSauce: 1,
          },
        },
        consumableIngridients: {
          Consumable.pancake: {
            Ingridient.pancakeBatter: 1,
            Ingridient.butter: 1,
          },
          Consumable.hamburgSteak: {
            Ingridient.patty: 1,
            Ingridient.cookedRice: 1,
          },
          Consumable.omurice: {
            Ingridient.omelette: 1,
            Ingridient.cookedRice: 1,
          },
          Consumable.pomodoro: {
            Ingridient.tomatoSauce: 1,
            Ingridient.spaghetti: 1,
          },
          Consumable.bechamel: {
            Ingridient.creamySauce: 1,
            Ingridient.spaghetti: 1,
          },
        },
      );

  static final singleton = Stove._();
}
