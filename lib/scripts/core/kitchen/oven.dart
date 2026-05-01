import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/kitchen/kitchen_processor.dart';
import 'package:pomodoropompurin/scripts/foundation/consumable.dart';
import 'package:pomodoropompurin/scripts/foundation/ingridient.dart';

class Oven extends KitchenProcessor {
  Oven._()
    : super(
        displayName: "oven",
        ingridientIngridients: {},
        consumableIngridients: {
          Consumable.pizza: {Ingridient.dough: 1, Ingridient.pizzaToppings: 1},
          Consumable.hamburger: {Ingridient.dough: 1, Ingridient.patty: 1},
          Consumable.lasagna: {
            Ingridient.lasagnaSauce: 1,
            Ingridient.lasagnaSheets: 1,
          },
        },
        processColor: const Color.fromARGB(255, 192, 59, 29),
        processIcon: Icons.microwave,
      );

  static final singleton = Oven._();
}
