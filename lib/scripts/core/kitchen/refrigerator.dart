import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/kitchen/kitchen_processor.dart';
import 'package:pomodoropompurin/scripts/foundation/consumable.dart';
import 'package:pomodoropompurin/scripts/foundation/ingridient.dart';

class Refrigerator extends KitchenProcessor {
  Refrigerator._()
    : super(
        displayName: "refrigerator",
        processIcon: Icons.ac_unit,
        processColor: const Color.fromARGB(255, 106, 185, 205),
        ingridientIngridients: {},
        consumableIngridients: {
          Consumable.pudding: {Ingridient.puddingBatter: 1},
        },
      );

  static final singleton = Refrigerator._();
}
