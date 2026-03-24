import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/dialog/script_dialog/script_dialog.dart';
import 'package:pomodoropompurin/scripts/core/dialog/script_dialog/script_manager.dart';
import 'package:pomodoropompurin/scripts/core/tutorial/tutorial_manager.dart';
import 'package:pomodoropompurin/scripts/core/tutorial/tutorial_state.dart';
import 'package:pomodoropompurin/scripts/core/ui/ui_display_state.dart';

class TutorialScriptWidget extends StatefulWidget {
  const TutorialScriptWidget({super.key});

  @override
  State<TutorialScriptWidget> createState() => _TutorialScriptWidgetState();
}

class _TutorialScriptWidgetState extends State<TutorialScriptWidget> {
  final tutorialScriptDialog = ScriptManager.singleton.tutorialScriptDialog;
  final uiDisplayState = UIDisplayState.singleton;

  final tutorialManager = TutorialManager.singleton;
  final tutorialState = TutorialState.singleton;

  Widget dialog = const SizedBox.shrink();
  bool showBarrier = false;

  @override
  void initState() {
    super.initState();
    tutorialScriptDialog.addListener(reload);

    if (tutorialState.loadTutorial == true) {
      tutorialManager.openTutorial();
    }
  }

  void reload() {
    setState(() {
      if (tutorialScriptDialog.value.imagePaths.isEmpty) {
        dialog = const SizedBox.shrink();
        showBarrier = false;
      } else {
        if (tutorialScriptDialog.value.hideUIonBegin) {
          uiDisplayState.hide.value = true;
        }
        dialog = tutorialScriptDialog.value;
        if (tutorialScriptDialog.value.isStatic) {
          showBarrier = false;
        } else {
          showBarrier = true;
        }
      }
    });
  }

  @override
  void dispose() {
    tutorialScriptDialog.removeListener(reload);
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
