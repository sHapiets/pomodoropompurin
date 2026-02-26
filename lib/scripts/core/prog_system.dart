import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/acquirables.dart';
import 'package:pomodoropompurin/scripts/foundation/consumable.dart';
import 'package:pomodoropompurin/scripts/foundation/date_log.dart';
import 'package:pomodoropompurin/scripts/foundation/ingridient.dart';
import 'package:pomodoropompurin/scripts/memory/database_manager.dart';

/// A core singleton that contains all userData
///
class ProgSystem {
  ProgSystem._();
  static final singleton = ProgSystem._();

  final _databaseManager = DatabaseManager.singleton;

  ValueNotifier<int> pomPoints = ValueNotifier<int>(0);
  ValueNotifier<int> milkJugs = ValueNotifier<int>(0);
  ValueNotifier<int> oshiriPoints = ValueNotifier<int>(0);

  Map<int, Map<int, List<DateLog>>> dateLogList = {};
  List<DateLog> dateLogfromMonth(int year, int month) {
    if (dateLogList[year]?[month] != null) {
      return dateLogList[year]![month]!;
    } else {
      return [];
    }
  }

  String get pomPointsString => pomPoints.value.toString();
  String get milkJugsString => milkJugs.value.toString();
  ValueNotifier<int> oshiriLevel = ValueNotifier(0);
  ValueNotifier<int> oshiriRemainder = ValueNotifier(0);

  /* List<String> acquiredItemsIds = [];
  List<String> acquiredHatsIds = [];
  List<String> acquiredTopsIds = [];
  List<String> acquiredBottomsIds = []; */
  Set<PurinVars> acquiredPurinVars = {
    PurinVars.boku,
    PurinVars.shrimp,
    PurinVars.pumpkin,
  };
  Set<KotatsuDesigns> acquiredKotatsus = {
    KotatsuDesigns.pudding,
    KotatsuDesigns.aqua,
  };
  Map<Consumable, ValueNotifier<int>> consumableInventory = {
    Consumable.pudding: ValueNotifier(0),
    Consumable.pizza: ValueNotifier(0),
    Consumable.pancake: ValueNotifier(0),
    Consumable.hamburgSteak: ValueNotifier(0),
  };
  Map<Ingridient, ValueNotifier<int>> ingridientInventory = {
    Ingridient.milk: ValueNotifier(0),
    Ingridient.eggs: ValueNotifier(0),
    Ingridient.butter: ValueNotifier(0),
    Ingridient.flour: ValueNotifier(0),
    Ingridient.onion: ValueNotifier(0),
    Ingridient.olives: ValueNotifier(0),
    Ingridient.tomato: ValueNotifier(0),
    Ingridient.groundPork: ValueNotifier(0),
    Ingridient.yeast: ValueNotifier(0),
    Ingridient.riceGrains: ValueNotifier(0),

    Ingridient.puddingCream: ValueNotifier(0),
    Ingridient.puddingBatter: ValueNotifier(0),
    Ingridient.pancakeBatter: ValueNotifier(2),
    Ingridient.washedRice: ValueNotifier(0),
    Ingridient.cookedRice: ValueNotifier(0),
    Ingridient.patty: ValueNotifier(0),
  };

  /// Point Systems
  void addPomPoints(int points) {
    pomPoints.value += points;
    _databaseManager.userDataSave('pomPoints', pomPoints.value);
  }

  void addMilkJugs(int jugs) {
    milkJugs.value += jugs;
    _databaseManager.userDataSave('milkJugs', milkJugs.value);
  }

  void addOshiriPoints(int points) {
    oshiriPoints.value += points;
    _databaseManager.userDataSave('oshiriPoints', oshiriPoints.value);
  }

  /// Inventory
  void addConsumable(Consumable consumable, int amount) {
    consumableInventory[consumable]!.value =
        consumableInventory[consumable]!.value + 1;
  }

  void addIngridient(Ingridient ingridient, int amount) {
    ingridientInventory[ingridient]!.value =
        ingridientInventory[ingridient]!.value + amount;
  }

  void useConsumable(Consumable consumable, int amount) {
    consumableInventory[consumable]!.value =
        consumableInventory[consumable]!.value - amount;
  }

  void useIngridient(Ingridient ingridient, int amount) {
    ingridientInventory[ingridient]!.value =
        ingridientInventory[ingridient]!.value - amount;
  }

  // Reload Data (used for Koupen, mostly in SplashPage...)
  void loadPomPoints(int points) =>
      pomPoints.value = points; // USE ONLY FOR SPLASHSCREEN (initial loading..)
  void loadMilkJugs(int jugs) =>
      milkJugs.value = jugs; // USE ONLY FOR SPLASHSCREEN (initial loading..)
  void loadOshiriPoints(int points) => oshiriPoints.value = points;
  void loadDateLogMonth(int year, int month, List<DateLog> logList) {
    if (!dateLogList.containsKey(year)) {
      dateLogList.addAll({year: {}});
    }
    if (!dateLogList[year]!.containsKey(month)) {
      dateLogList[year]!.addAll({month: []});
    }
    dateLogList[year]![month] = logList;
  }

  void updateLevelSystem() {
    var low = 0;
    var high = oshiriPointsFromLevel.length;

    while (low < high) {
      final mid = low + ((high - low) >> 1);
      if (oshiriPointsFromLevel[mid] <= oshiriPoints.value) {
        low = mid + 1;
      } else {
        high = mid;
      }
    }

    oshiriLevel.value = low;
    oshiriRemainder.value = (low == 0)
        ? oshiriPoints.value
        : oshiriPoints.value - oshiriPointsFromLevel[low - 1];
  }

  List<int> oshiriPointsFromLevel = List<int>.generate(1000, (int index) {
    return (index == 0) ? 0 : (100 * pow(index, 2).toInt());
  }, growable: true);
}
