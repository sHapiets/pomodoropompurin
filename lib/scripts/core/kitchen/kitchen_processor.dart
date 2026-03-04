import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/prog_system.dart';
import 'package:pomodoropompurin/scripts/foundation/consumable.dart';
import 'package:pomodoropompurin/scripts/foundation/ingridient.dart';

abstract class KitchenProcessor {
  KitchenProcessor({
    required this.displayName,
    required this.processIcon,
    required this.processColor,
    required this.ingridientIngridients,
    required this.consumableIngridients,
  });

  final String displayName;
  final IconData processIcon;
  final Color processColor;
  final Map<Ingridient, Map<Ingridient, int>> ingridientIngridients;
  final Map<Consumable, Map<Ingridient, int>> consumableIngridients;

  final progSystem = ProgSystem.singleton;

  void processIngridient(Ingridient ingridient, int amount) {
    progSystem.addIngridient(ingridient, amount);
    ingridientIngridients[ingridient]!.map((
      ingridientIngridient,
      ingridientAmount,
    ) {
      progSystem.useIngridient(ingridientIngridient, ingridientAmount * amount);
      throw '';
    });
  }

  void processConsumable(Consumable consumable, int amount) {
    progSystem.addConsumable(consumable, amount);
    consumableIngridients[consumable]!.map((
      consumableIngridient,
      ingridientAmount,
    ) {
      progSystem.useIngridient(consumableIngridient, ingridientAmount * amount);
      throw '';
    });
  }
}

enum KitchenProcessors { stove, oven, choppingBoard, mixer, refrigerator, sink }
