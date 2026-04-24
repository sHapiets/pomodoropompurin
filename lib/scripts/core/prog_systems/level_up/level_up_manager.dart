import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/acquirables.dart';
import 'package:pomodoropompurin/scripts/core/dialog/script_dialog/script_manager.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/level_up/unlocks_from_level.dart';
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
  final acquirables = Acquirables.singleton;
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

    final List<List<dynamic>> unlockedPurchasables = [];

    if (UnlocksFromLevel.acquiredPurinVars[currentLevel] != null) {
      unlockedPurchasables.addAll(
        UnlocksFromLevel.acquiredPurinVars[currentLevel]!.map((purinVar) {
          final newPurin = acquirables.purinVars[purinVar]!;
          return [
            newPurin.displayName,
            "New Purin Collected!",
            newPurin.iconAssetPath,
          ];
        }).toList(),
      );
    }

    if (UnlocksFromLevel.purchaseableSnack[currentLevel] != null) {
      unlockedPurchasables.addAll(
        UnlocksFromLevel.purchaseableSnack[currentLevel]!.map((snack) {
          return [
            snack.displayName,
            "New Purchasable Snack!",
            snack.iconFlutterPath,
          ];
        }).toList(),
      );
    }

    if (UnlocksFromLevel.purchasableIngridients[currentLevel] != null) {
      unlockedPurchasables.addAll(
        UnlocksFromLevel.purchasableIngridients[currentLevel]!.map((
          ingridient,
        ) {
          return [
            ingridient.displayName,
            "New Purchasable Ingridient!",
            ingridient.spriteFlutterPath,
          ];
        }).toList(),
      );
    }

    levelUpDialog = LevelUpDialog(
      newLevel: currentLevel,
      levelRewards: unlockedPurchasables,
    );
    notifyListeners();
  }
}
