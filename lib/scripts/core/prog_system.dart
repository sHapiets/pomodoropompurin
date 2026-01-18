import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/foundation/date_log.dart';
import 'package:pomodoropompurin/scripts/memory/database_manager.dart';

/// A core singleton that contains all userData
///
class ProgSystem {
  ProgSystem._();
  static final singleton = ProgSystem._();

  final _databaseManager = DatabaseManager.singleton;

  ValueNotifier<int> pomPoints = ValueNotifier<int>(0);
  ValueNotifier<int> milkJugs = ValueNotifier<int>(0);
  ValueNotifier<int> exPoints = ValueNotifier<int>(0);

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

  List<String> acquiredItemsIds = [];
  List<String> acquiredHatsIds = [];
  List<String> acquiredTopsIds = [];
  List<String> acquiredBottomsIds = [];
  List<String> acquiredKotatsuIds = [];

  // Functions to be used by PomTimer, RewardEvents etc...
  void addPomPoints(int points) {
    pomPoints.value += points;
    _databaseManager.userDataSave('pomPoints', pomPoints.value);
  }

  void addMilkJugs(int jugs) {
    milkJugs.value += jugs;
    _databaseManager.userDataSave('milkJugs', milkJugs.value);
  }

  // Functions to be used to reload data
  void loadPomPoints(int points) =>
      pomPoints.value = points; // USE ONLY FOR SPLASHSCREEN (initial loading..)
  void loadMilkJugs(int jugs) =>
      milkJugs.value = jugs; // USE ONLY FOR SPLASHSCREEN (initial loading..)
  void loadDateLogMonth(int year, int month, List<DateLog> logList) {
    if (!dateLogList.containsKey(year)) {
      dateLogList.addAll({year: {}});
    }
    if (!dateLogList[year]!.containsKey(month)) {
      dateLogList[year]!.addAll({month: []});
    }
    dateLogList[year]![month] = logList;
  }
}
