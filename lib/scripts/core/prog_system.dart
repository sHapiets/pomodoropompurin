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

  List<DateLog> dateLogList = [];

  String get pomPointsString => pomPoints.value.toString();
  String get milkJugsString => milkJugs.value.toString();

  List<String> acquiredItemsIds = [];
  List<String> acquiredHatsIds = [];
  List<String> acquiredTopsIds = [];
  List<String> acquiredBottomsIds = [];

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
  void loadDateLogList(List<DateLog> logList) => dateLogList = logList;
}
