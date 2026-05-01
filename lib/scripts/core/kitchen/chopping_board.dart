import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/kitchen/kitchen_processor.dart';
import 'package:pomodoropompurin/scripts/foundation/ingridient.dart';

class ChoppingBoard extends KitchenProcessor {
  ChoppingBoard._()
    : super(
        displayName: "chopping",
        ingridientIngridients: {
          Ingridient.choppedOnions: {Ingridient.onion: 1},
          Ingridient.pizzaToppings: {
            Ingridient.tomato: 2,
            Ingridient.olives: 2,
          },
          Ingridient.spaghetti: {Ingridient.dough: 1},
          Ingridient.lasagnaSheets: {Ingridient.dough: 1},
        },
        consumableIngridients: {},
        processColor: const Color.fromARGB(255, 78, 78, 78),
        processIcon: Icons.pie_chart,
      );

  static final singleton = ChoppingBoard._();
}
