import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/dialog/script_dialog/script_manager.dart';
import 'package:pomodoropompurin/scripts/core/ui/ui_display_state.dart';

class PurinMenuScriptWidget extends StatefulWidget {
  const PurinMenuScriptWidget({super.key});

  @override
  State<PurinMenuScriptWidget> createState() => _PurinMenuScriptWidgetState();
}

class _PurinMenuScriptWidgetState extends State<PurinMenuScriptWidget> {
  final purinMenuScriptDialog = ScriptManager.singleton.purinMenuScriptDialog;
  final uiDisplayState = UIDisplayState.singleton;

  Widget dialog = const SizedBox.shrink();
  bool showBarrier = false;

  @override
  void initState() {
    super.initState();
    purinMenuScriptDialog.addListener(reload);
  }

  void reload() {
    setState(() {
      if (purinMenuScriptDialog.value.imagePaths.isEmpty) {
        dialog = const SizedBox.shrink();
        showBarrier = false;
      } else {
        uiDisplayState.hide.value = true;
        dialog = purinMenuScriptDialog.value;
        if (purinMenuScriptDialog.value.isStatic) {
          showBarrier = false;
        } else {
          showBarrier = true;
        }
      }
    });
  }

  @override
  void dispose() {
    purinMenuScriptDialog.removeListener(reload);
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
