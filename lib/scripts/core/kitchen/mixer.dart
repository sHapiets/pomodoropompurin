import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/kitchen/kitchen_processor.dart';
import 'package:pomodoropompurin/scripts/foundation/ingridient.dart';

class Mixer extends KitchenProcessor {
  Mixer._()
    : super(
        displayName: "mixer",
        ingridientIngridients: {
          Ingridient.puddingCream: {Ingridient.eggs: 1, Ingridient.milk: 1},
          Ingridient.dough: {Ingridient.flour: 1, Ingridient.yeast: 1},
          Ingridient.patty: {
            Ingridient.choppedOnions: 1,
            Ingridient.groundPork: 1,
          },
        },
        consumableIngridients: {},
        processColor: const Color.fromARGB(255, 176, 211, 102),
        processIcon: Icons.blender_rounded,
      );
  static final singleton = Mixer._();
}
