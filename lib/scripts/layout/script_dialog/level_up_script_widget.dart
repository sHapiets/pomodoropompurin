import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/dialog/script_dialog/script_manager.dart';
import 'package:pomodoropompurin/scripts/core/ui/ui_display_state.dart';

class LevelUpScriptWidget extends StatefulWidget {
  const LevelUpScriptWidget({super.key});

  @override
  State<LevelUpScriptWidget> createState() => _LevelUpScriptWidget();
}

class _LevelUpScriptWidget extends State<LevelUpScriptWidget> {
  final levelUpScriptDialog = ScriptManager.singleton.levelUpScriptDialog;
  final uiDisplayState = UIDisplayState.singleton;

  Widget dialog = const SizedBox.shrink();
  bool showBarrier = false;

  @override
  void initState() {
    super.initState();
    levelUpScriptDialog.addListener(reload);
  }

  void reload() {
    setState(() {
      if (levelUpScriptDialog.value.imagePaths.isEmpty) {
        uiDisplayState.hide.value = false;
        dialog = const SizedBox.shrink();
        showBarrier = false;
      } else {
        uiDisplayState.hide.value = true;
        dialog = levelUpScriptDialog.value;
        if (levelUpScriptDialog.value.isStatic) {
          showBarrier = false;
        } else {
          showBarrier = true;
        }
      }
    });
  }

  @override
  void dispose() {
    levelUpScriptDialog.removeListener(reload);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (showBarrier)
          const ModalBarrier(dismissible: false, color: Colors.transparent),

        dialog,
      ],
    );
  }
}
