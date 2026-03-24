import 'dart:async';
import 'package:flutter/rendering.dart';

class ActivityManager {
  ActivityManager._();
  static final singleton = ActivityManager._();

  DateTime latestActivityLog = DateTime.now();

  Timer? activityLogger;
  final Duration activityLoggerInterval = const Duration(minutes: 5);

  void initialize(
    DateTime initLatestActivity,
    Future<void> Function() databaseLogger,
  ) {
    latestActivityLog = initLatestActivity;
    Timer activityLogger = Timer.periodic(activityLoggerInterval, (timer) {
      final now = DateTime.now();
      latestActivityLog = now;
      databaseLogger();
    });
  }

  Duration getDurationFromLatestActivity() {
    return DateTime.now().difference(latestActivityLog);
  }
}
