import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/dialog/script_dialog/script_manager.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/prog_system.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:pomodoropompurin/scripts/layout/prog_dialog/level_up_dialog.dart';
import 'package:pomodoropompurin/scripts/memory/database_manager.dart';

class LevelUpManager extends ChangeNotifier {
  LevelUpManager._() {
    initialize();
  }
  static final singleton = LevelUpManager._();

  final progSystem = ProgSystem.singleton;
  final databaseManager = DatabaseManager.singleton;
  final scriptManager = ScriptManager.singleton;
  Widget levelUpDialog = LevelUpDialog(newLevel: 0, levelRewards: []);

  final purinAreaStateManager = PurinAreaStateManager.singleton;
  final purin = Purin.singleton;

  int currentLevel = 0;

  Future<void> initialize() async {
    currentLevel = await databaseManager.userDataLoad('oshiriPoints');
    currentLevel = progSystem.oshiriLevel.value;
    progSystem.oshiriLevel.addListener(unlockFromNewLevel);
  }

  void unlockFromNewLevel() {
    currentLevel = progSystem.oshiriLevel.value;

    scriptManager.addLevelUpDialog(currentLevel);
    purinAreaStateManager.jumpToPosition(
      purin.purinPositionVect2,
      Vector2.zero(),
      1.8,
    );

    switch (currentLevel) {
      case 2:
        levelUpDialog = LevelUpDialog(
          newLevel: 2,
          levelRewards: [
            ["Sword", "izza nice Sword", Icons.abc],
          ],
        );

      /// NOTE: depend on UnlocksFromLevel when a purchasable is available
      case 3:
        levelUpDialog = LevelUpDialog(newLevel: 3, levelRewards: []);
      case 4:
        levelUpDialog = LevelUpDialog(newLevel: 4, levelRewards: []);
    }

    notifyListeners();
  }
}
