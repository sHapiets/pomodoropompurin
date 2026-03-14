import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/dialog/script_dialog/script_manager.dart';
import 'package:pomodoropompurin/scripts/core/ui/ui_display_state.dart';

class FeedScriptWidget extends StatefulWidget {
  const FeedScriptWidget({super.key});

  @override
  State<FeedScriptWidget> createState() => _FeedScriptWidgetState();
}

class _FeedScriptWidgetState extends State<FeedScriptWidget> {
  final feedScriptDialog = ScriptManager.singleton.feedScriptDialog;
  final uiDisplayState = UIDisplayState.singleton;

  Widget dialog = const SizedBox.shrink();
  bool showBarrier = false;

  @override
  void initState() {
    super.initState();
    feedScriptDialog.addListener(reload);
  }

  void reload() {
    setState(() {
      if (feedScriptDialog.value.imagePaths.isEmpty) {
        dialog = const SizedBox.shrink();
        showBarrier = false;
      } else {
        dialog = feedScriptDialog.value;
        if (feedScriptDialog.value.isStatic) {
          showBarrier = false;
        } else {
          showBarrier = true;
        }
      }
    });
  }

  @override
  void dispose() {
    feedScriptDialog.removeListener(reload);
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
