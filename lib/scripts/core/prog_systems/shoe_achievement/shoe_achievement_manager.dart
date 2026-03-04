import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/prog_system.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/shoe_achievement/shoe_achievement.dart';
import 'package:pomodoropompurin/scripts/layout/prog_dialog/level_up_dialog.dart';
import 'package:pomodoropompurin/scripts/layout/prog_dialog/shoe_achievement_dialog.dart';
import 'package:pomodoropompurin/scripts/memory/database_manager.dart';

class ShoeAchievementManager extends ChangeNotifier {
  ShoeAchievementManager._() {
    initialize();
  }
  static final singleton = ShoeAchievementManager._();

  final progSystem = ProgSystem.singleton;
  final databaseManager = DatabaseManager.singleton;
  Widget shoeAchievementDialog = ShoeAchievementDialog(
    newShoeAchievement: ShoeAchievement.none,
  );

  int accTotalTime = 0;

  Future<void> initialize() async {
    accTotalTime = progSystem.accTotalTime.value;
    accTotalTime = await databaseManager.userDataLoad('accTotalTime');
    progSystem.accTotalTime.addListener(shoeAchievementFromTotalTime);
  }

  void shoeAchievementFromTotalTime() {
    accTotalTime = progSystem.accTotalTime.value;
    ShoeAchievement newShoeAchievement = ShoeAchievement.values.lastWhere((sA) {
      return accTotalTime >= sA.secondsRequirement;
    });

    if (progSystem.acquiredShoeAchievementBool[newShoeAchievement]!) {
      return;
    }

    progSystem.acquireShoeAchievement(newShoeAchievement);
    shoeAchievementDialog = ShoeAchievementDialog(
      newShoeAchievement: newShoeAchievement,
    );
    notifyListeners();
  }
}
