import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/acquirables.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/shoe_achievement/shoe_achievement.dart';
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

  ValueNotifier<int> accTotalTime = ValueNotifier(0);
  Map<ShoeAchievement, bool> acquiredShoeAchievementBool = {
    ShoeAchievement.none: true,
    ShoeAchievement.slippers: false,
    ShoeAchievement.sneakers: false,
  };

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
  ValueNotifier<int> dayTimeSeconds = ValueNotifier(0);

  /* List<String> acquiredItemsIds = [];
  List<String> acquiredHatsIds = [];
  List<String> acquiredTopsIds = [];
  List<String> acquiredBottomsIds = []; */
  Set<PurinVars> acquiredPurinVars = {};

  Set<KotatsuDesigns> acquiredKotatsus = {
    KotatsuDesigns.pudding,
    KotatsuDesigns.aqua,
  };

  Map<Consumable, ValueNotifier<int>> consumableInventory = {
    for (final consumable in Consumable.values) consumable: ValueNotifier(0),
  };

  Map<Ingridient, ValueNotifier<int>> ingridientInventory = {
    for (final ingridient in Ingridient.values) ingridient: ValueNotifier(0),
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

  void addAccTotalTime(int seconds) {
    accTotalTime.value += seconds;
    _databaseManager.userDataSave('accTotalTime', accTotalTime.value);
  }

  void acquireShoeAchievement(ShoeAchievement newShoeAchievement) {
    acquiredShoeAchievementBool[newShoeAchievement] = true;
    _databaseManager.acquireShoeAchievementSave(newShoeAchievement);
  }

  void addDayTimeSeconds(int seconds) {
    dayTimeSeconds.value += seconds;
    _databaseManager.dayTimeSecondsSave(dayTimeSeconds.value);
  }

  void usePomPoints(int points) {
    pomPoints.value -= points;
    _databaseManager.userDataSave('pomPoints', pomPoints.value);
  }

  void useMilkJugs(int jugs) {
    milkJugs.value -= jugs;
    _databaseManager.userDataSave('milkJugs', milkJugs.value);
  }

  void useOshiriPoints(int points) {
    oshiriPoints.value -= points;
    _databaseManager.userDataSave('oshiriPoints', oshiriPoints.value);
  }

  /// Inventory
  void addConsumable(Consumable consumable, int amount) {
    consumableInventory[consumable]!.value =
        consumableInventory[consumable]!.value + amount;
    _databaseManager.consumableInventorySave({
      consumable: consumableInventory[consumable]!.value,
    });
  }

  void addIngridient(Ingridient ingridient, int amount) {
    ingridientInventory[ingridient]!.value =
        ingridientInventory[ingridient]!.value + amount;
    _databaseManager.ingridientInventorySave({
      ingridient: ingridientInventory[ingridient]!.value,
    });
  }

  void useConsumable(Consumable consumable, int amount) {
    consumableInventory[consumable]!.value =
        consumableInventory[consumable]!.value - amount;
    _databaseManager.consumableInventorySave({
      consumable: consumableInventory[consumable]!.value,
    });
  }

  void useIngridient(Ingridient ingridient, int amount) {
    ingridientInventory[ingridient]!.value =
        ingridientInventory[ingridient]!.value - amount;
    _databaseManager.ingridientInventorySave({
      ingridient: ingridientInventory[ingridient]!.value,
    });
  }

  // Reload Data (used for Koupen, mostly in SplashPage...)
  void loadPomPoints(int points) =>
      pomPoints.value = points; // USE ONLY FOR SPLASHSCREEN (initial loading..)
  void loadMilkJugs(int jugs) =>
      milkJugs.value = jugs; // USE ONLY FOR SPLASHSCREEN (initial loading..)
  void loadOshiriPoints(int points) => oshiriPoints.value = points;
  void loadAccTotalTime(int totalTime) => accTotalTime.value = totalTime;
  void loadDayTimeSeconds(int seconds) => dayTimeSeconds.value = seconds;
  void loadDateLogMonth(int year, int month, List<DateLog> logList) {
    if (!dateLogList.containsKey(year)) {
      dateLogList.addAll({year: {}});
    }
    if (!dateLogList[year]!.containsKey(month)) {
      dateLogList[year]!.addAll({month: []});
    }
    dateLogList[year]![month] = logList;
  }

  void loadIngridientInventory(Map<Ingridient, int> amountMap) {
    for (MapEntry<Ingridient, int> amountMapEntry in amountMap.entries) {
      ingridientInventory[amountMapEntry.key]!.value = amountMapEntry.value;
    }
  }

  void loadConsumableInventory(Map<Consumable, int> amountMap) {
    for (MapEntry<Consumable, int> amountMapEntry in amountMap.entries) {
      consumableInventory[amountMapEntry.key]!.value = amountMapEntry.value;
    }
  }

  void loadAcquiredPurinVars(Set<PurinVars> purinVarSet) {
    acquiredPurinVars = purinVarSet;
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
