import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/foundation/date_log.dart';

/// A core singleton that contains all userData
///
class ProgSystem {
  ProgSystem._();
  static final singleton = ProgSystem._();

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
  void addPomPoints(int points) => pomPoints.value += points;
  void addMilkJugs(int jugs) => milkJugs.value += jugs;

  // Functions to be used by database manager
  void loadPomPoints(int points) => pomPoints.value = points;
  void loadMilkJugs(int jugs) => milkJugs.value = jugs;
  void loadDateLogList(List<DateLog> logList) => dateLogList = logList;
}
