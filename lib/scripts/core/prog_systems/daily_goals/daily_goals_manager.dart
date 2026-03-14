import 'package:flutter/material.dart';

class DailyGoalsManager {
  DailyGoalsManager._() {
    initialize();
  }
  static final singleton = DailyGoalsManager._();

  int goalTimeSeconds = 0;

  void initialize() {}
}
