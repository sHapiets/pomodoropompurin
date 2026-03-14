import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/dialog/script_dialog/script_manager.dart';
import 'package:pomodoropompurin/scripts/core/ui/ui_display_state.dart';

class PetScriptWidget extends StatefulWidget {
  const PetScriptWidget({super.key});

  @override
  State<PetScriptWidget> createState() => _PetScriptWidgetState();
}

class _PetScriptWidgetState extends State<PetScriptWidget> {
  final petScriptDialog = ScriptManager.singleton.petScriptDialog;
  final uiDisplayState = UIDisplayState.singleton;

  Widget dialog = const SizedBox.shrink();
  bool showBarrier = false;

  @override
  void initState() {
    super.initState();
    petScriptDialog.addListener(reload);
  }

  void reload() {
    setState(() {
      if (petScriptDialog.value.imagePaths.isEmpty) {
        dialog = const SizedBox.shrink();
        showBarrier = false;
      } else {
        uiDisplayState.hide.value = true;
        dialog = petScriptDialog.value;
        if (petScriptDialog.value.isStatic) {
          showBarrier = false;
        } else {
          showBarrier = true;
        }
      }
    });
  }

  @override
  void dispose() {
    petScriptDialog.removeListener(reload);
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
