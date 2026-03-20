import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomodoropompurin/main.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/prog_system.dart';
import 'package:pomodoropompurin/scripts/foundation/rewards_conversion.dart';
import 'package:pomodoropompurin/scripts/layout/pom_timer/dialogs/interrupted_pom_timer_dialog.dart';
import 'package:pomodoropompurin/scripts/memory/database_manager.dart';

class PomTimerInterruptedManager {
  PomTimerInterruptedManager._();
  static final singleton = PomTimerInterruptedManager._();

  bool wasActive = false;
  int wasTimeTotalSeconds = 0;

  final databaseManager = DatabaseManager.singleton;
  final progSystem = ProgSystem.singleton;

  void rewardInterruptedTime() {
    if (wasActive == false) {
      return;
    }

    int rewardPomPoints = PomPointsConversion.fromSeconds(wasTimeTotalSeconds);
    int rewardOshiriPoints = OshiriPointsConversion.fromSeconds(
      wasTimeTotalSeconds,
    );

    databaseManager.statusPomTimerSave('wasActive', false);
    databaseManager.statusPomTimerSave('wasTimeTotalSeconds', 0);

    progSystem.addDayTimeSeconds(wasTimeTotalSeconds);
    progSystem.addAccTotalTime(wasTimeTotalSeconds);
    progSystem.addPomPoints(rewardPomPoints);
    progSystem.addOshiriPoints(rewardOshiriPoints);

    int timeTotalTemp = wasTimeTotalSeconds;

    Timer.periodic(Duration(seconds: 1), (timer) {
      if (navigatorKey.currentContext == null) {
        return;
      }
      showGeneralDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        barrierColor: Colors.black54,
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation, secondaryAnimation) {
          return InterruptedPomTimerDialog(
            seconds: timeTotalTemp,
            pomPoints: rewardPomPoints,
            oshiriPoints: rewardOshiriPoints,
            onClose: () => Navigator.pop(context),
          );
        },
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOutBack,
            reverseCurve: Curves.easeInOutBack,
          );

          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.7, end: 1).animate(curved),
              child: child,
            ),
          );
        },
      );
      timer.cancel();
    });

    wasActive = false;
    wasTimeTotalSeconds = 0;
  }
}
