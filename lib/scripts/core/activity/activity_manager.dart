import 'dart:async';
import 'package:flutter/rendering.dart';

class ActivityManager {
  ActivityManager._();
  static final singleton = ActivityManager._();

  DateTime latestActivityLog = DateTime.now();

  Timer? activityLogger;
  Future<void> Function() databaseLoggerFunction = () async {};
  final Duration activityLoggerInterval = const Duration(minutes: 5);

  void initialize(
    DateTime initLatestActivity,
    Future<void> Function() databaseLogger,
  ) {
    latestActivityLog = initLatestActivity;
    databaseLoggerFunction = databaseLogger;
    logActivity();
    Timer activityLogger = Timer.periodic(activityLoggerInterval, (timer) {
      logActivity();
    });
  }

  void logActivity() {
    databaseLoggerFunction();
  }

  Duration getDurationFromLatestActivity() {
    return DateTime.now().difference(latestActivityLog);
  }
}
