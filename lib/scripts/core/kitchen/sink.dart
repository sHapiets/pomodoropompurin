import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/kitchen/kitchen_processor.dart';
import 'package:pomodoropompurin/scripts/foundation/ingridient.dart';

class Sink extends KitchenProcessor {
  Sink._()
    : super(
        displayName: "sink",
        processIcon: Icons.water_drop_rounded,
        processColor: const Color.fromARGB(255, 169, 225, 255),
        ingridientIngridients: {
          Ingridient.washedRice: {Ingridient.riceGrains: 1},
        },
        consumableIngridients: {},
      );

  static final singleton = Sink._();
}
