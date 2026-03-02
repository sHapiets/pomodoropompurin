import 'dart:ui';

import 'package:flutter/material.dart';
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
        processColor: const Color.fromARGB(255, 78, 78, 78),
        processIcon: Icons.pie_chart,
      );

  static final singleton = ChoppingBoard._();
}
