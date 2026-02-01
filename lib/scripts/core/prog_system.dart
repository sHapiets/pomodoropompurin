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
  Map<Consumable, int> consumableInventory = {Consumable.pudding: 0};
  Map<Ingridient, int> ingridientInventory = {
    Ingridient.milk: 0,
    Ingridient.eggs: 0,
  };

  // Functions to be used by PomTimer, RewardEvents etc...
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

  /// Consumable Inventory (Public) Functions
  void addConsumable(Consumable consumable, int count) {
    consumableInventory[consumable] = consumableInventory[consumable]! + 1;
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
