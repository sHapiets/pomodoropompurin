import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/dialog/script_dialog/script_dialog.dart';
import 'package:pomodoropompurin/scripts/core/dialog/script_dialog/scripts_map.dart';
import 'package:pomodoropompurin/scripts/memory/asset_manager.dart';

class ScriptManager {
  ScriptManager._();
  static final singleton = ScriptManager._();

  final assetManager = AssetManager.singleton;

  ValueNotifier<ScriptDialog> levelUpScriptDialog = ValueNotifier(
    ScriptDialog(imagePaths: [], dialogues: []),
  );
  ValueNotifier<ScriptDialog> purinMenuScriptDialog = ValueNotifier(
    ScriptDialog(imagePaths: [], dialogues: []),
  );
  ValueNotifier<ScriptDialog> feedScriptDialog = ValueNotifier(
    ScriptDialog(imagePaths: [], dialogues: []),
  );
  ValueNotifier<ScriptDialog> petScriptDialog = ValueNotifier(
    ScriptDialog(imagePaths: [], dialogues: []),
  );
  ValueNotifier<ScriptDialog> tutorialScriptDialog = ValueNotifier(
    ScriptDialog(imagePaths: [], dialogues: []),
  );

  void startUpDialog() {}

  void removeAllDialogs() {
    purinMenuScriptDialog.value = ScriptDialog(imagePaths: [], dialogues: []);
    feedScriptDialog.value = ScriptDialog(imagePaths: [], dialogues: []);
    petScriptDialog.value = ScriptDialog(imagePaths: [], dialogues: []);
  }

  void removeLevelUpDialog() {
    levelUpScriptDialog.value = ScriptDialog(imagePaths: [], dialogues: []);
  }

  void addLevelUpDialog(int newLevel) {
    if (ScriptsMap.fromLevelUp.containsKey(newLevel)) {
      levelUpScriptDialog.value = ScriptsMap.fromLevelUp[newLevel]!;
    }
  }

  void removePurinMenuDialog() {
    purinMenuScriptDialog.value = ScriptDialog(imagePaths: [], dialogues: []);
  }

  void addPurinMenuDialog() {
    purinMenuScriptDialog.value = ScriptDialog(
      imagePaths: [assetManager.flutterAssetPaths['curious_purin_icon']!],
      dialogues: [
        {"Purin": "Pom~u! What should we do..."},
      ],
      isStatic: true,
    );
  }

  void removeFeedDialog() {
    feedScriptDialog.value = ScriptDialog(imagePaths: [], dialogues: []);
  }

  final List<String> purinFeedRandomScripts = [
    "That hits the spot ~ !",
    "I'm just warming up, keep it coming!",
    "Anything mama-owner make is delicious!",
    "Maybe I should diet.... never!",
  ];
  final random = Random();

  void addFeedDialog() {
    final index = random.nextInt(purinFeedRandomScripts.length);
    feedScriptDialog.value = ScriptDialog(
      imagePaths: [assetManager.flutterAssetPaths['eating_purin_icon']!],
      dialogues: [
        {"Purin": purinFeedRandomScripts[index]},
      ],
      isStatic: true,
    );
  }

  void removePetDialog() {
    petScriptDialog.value = ScriptDialog(imagePaths: [], dialogues: []);
  }

  void addPetDialog() {
    petScriptDialog.value = ScriptDialog(
      imagePaths: [AssetManager.singleton.flutterAssetPaths["pP_icon"]!],
      dialogues: [
        {"Purin": "Pomu ~ Pomu ~~"},
      ],
      isStatic: true,
    );
  }

  void removeTutorialScript() {
    tutorialScriptDialog.value = ScriptDialog(imagePaths: [], dialogues: []);
  }

  void addTutorialScript(int part) {
    if (ScriptsMap.fromTutorialSections.containsKey(part)) {
      tutorialScriptDialog.value = ScriptsMap.fromTutorialSections[part]!;
    }
  }
}
