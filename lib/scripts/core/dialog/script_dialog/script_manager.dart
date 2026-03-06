import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/dialog/script_dialog/script_dialog.dart';
import 'package:pomodoropompurin/scripts/core/dialog/script_dialog/scripts_map.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin_state_manager.dart';
import 'package:pomodoropompurin/scripts/memory/asset_manager.dart';

class ScriptManager extends ChangeNotifier {
  ScriptManager._();
  static final singleton = ScriptManager._();

  ScriptDialog scriptDialog = ScriptDialog(imagePaths: [], dialogues: []);

  void removeDialog() {
    scriptDialog = ScriptDialog(imagePaths: [], dialogues: []);
    notifyListeners();
  }

  void levelUpDialog(int newLevel) {
    if (ScriptsMap.fromLevelUp.containsKey(newLevel)) {
      scriptDialog = ScriptsMap.fromLevelUp[newLevel]!;
      notifyListeners();
    }
  }

  void purinMenuDialog() {
    scriptDialog = ScriptDialog(
      imagePaths: [AssetManager.singleton.flutterAssetPaths["pP_icon"]!],
      dialogues: [
        {"Purin": "What's up? (^ ω ^ )"},
      ],
      isStatic: true,
    );
    notifyListeners();
  }

  void purinPetDialog() {
    scriptDialog = ScriptDialog(
      imagePaths: [AssetManager.singleton.flutterAssetPaths["pP_icon"]!],
      dialogues: [
        {"Purin": "Pomu ~ Pomu ~~"},
      ],
      isStatic: true,
    );
    notifyListeners();
  }
}
