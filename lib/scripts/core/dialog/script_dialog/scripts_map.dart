import 'package:pomodoropompurin/scripts/core/dialog/script_dialog/script_dialog.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin_state_manager.dart';
import 'package:pomodoropompurin/scripts/memory/asset_manager.dart';

class ScriptsMap {
  static Map<PurinAction, ScriptDialog> fromPurinAction = {
    PurinAction.pet: ScriptDialog(
      imagePaths: [AssetManager.singleton.flutterAssetPaths["pP_icon"]!],
      dialogues: [
        {"Purin": "~ Kyuuun!"},
      ],
    ),
    PurinAction.feed: ScriptDialog(
      imagePaths: [AssetManager.singleton.flutterAssetPaths["pP_icon"]!],
      dialogues: [
        {"Purin": "Delicious!"},
      ],
    ),
  };

  static Map<int, ScriptDialog> fromLevelUp = {
    3: ScriptDialog(
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths["pP_icon"]!,
        AssetManager.singleton.flutterAssetPaths["pP_icon"]!,
      ],
      dialogues: [
        {"Purin": "Hi nice to meet you"},
        {"Purin": "3"},
      ],
    ),
    4: ScriptDialog(
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths["pP_icon"]!,
        AssetManager.singleton.flutterAssetPaths["pP_icon"]!,
      ],
      dialogues: [
        {"Purin": "Hi nice to meet you"},
        {"Purin": "4"},
      ],
    ),
    10: ScriptDialog(
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths["pP_icon"]!,
        AssetManager.singleton.flutterAssetPaths["pP_icon"]!,
      ],
      dialogues: [
        {"Purin": "Hi nice to meet you"},
        {"Purin": "10"},
      ],
    ),
    22: ScriptDialog(
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths["pP_icon"]!,
        AssetManager.singleton.flutterAssetPaths["pP_icon"]!,
      ],
      dialogues: [
        {"Purin": "Hi nice to meet you"},
        {"Purin": "22"},
      ],
    ),
  };
}
