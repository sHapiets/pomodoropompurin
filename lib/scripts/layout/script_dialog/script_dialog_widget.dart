import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/dialog/script_dialog/script_manager.dart';
import 'package:pomodoropompurin/scripts/core/ui/ui_display_state.dart';

class ScriptDialogWidget extends StatefulWidget {
  const ScriptDialogWidget({super.key});

  @override
  State<ScriptDialogWidget> createState() => _ScriptDialogWidgetState();
}

class _ScriptDialogWidgetState extends State<ScriptDialogWidget> {
  final scriptManager = ScriptManager.singleton;
  final uiDisplayState = UIDisplayState.singleton;

  Widget dialog = const SizedBox.shrink();
  bool showBarrier = false;

  @override
  void initState() {
    super.initState();
    scriptManager.addListener(reload);
  }

  void reload() {
    setState(() {
      if (scriptManager.scriptDialog.imagePaths.isEmpty) {
        uiDisplayState.hide.value = false;
        dialog = const SizedBox.shrink();
        showBarrier = false;
      } else {
        uiDisplayState.hide.value = true;
        dialog = scriptManager.scriptDialog;
        if (scriptManager.scriptDialog.isStatic) {
          showBarrier = false;
        } else {
          showBarrier = true;
        }
      }
    });
  }

  @override
  void dispose() {
    scriptManager.removeListener(reload);
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
