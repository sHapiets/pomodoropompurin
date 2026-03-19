import 'dart:async';

import 'package:pomodoropompurin/scripts/core/dialog/script_dialog/script_manager.dart';
import 'package:pomodoropompurin/scripts/core/tutorial/tutorial_state.dart';
import 'package:pomodoropompurin/scripts/memory/database_manager.dart';

class TutorialManager {
  TutorialManager._();
  static final singleton = TutorialManager._();

  final tutorialState = TutorialState.singleton;
  final scriptManager = ScriptManager.singleton;
  final databaseManager = DatabaseManager.singleton;
  late final bool loadTutorial;

  Future<void> initialize() async {
    tutorialState.loadTutorial = await databaseManager.statusLoadTutorialLoad();
  }

  void openTutorial() {
    tutorialState.section.value = 1;
    scriptManager.addTutorialScript(tutorialState.section.value);
  }

  void nextTutorialSection({int delayMs = 100}) {
    tutorialState.section.value += 1;

    scriptManager.removeTutorialScript();
    Timer.periodic(Duration(milliseconds: delayMs), (timer) {
      scriptManager.addTutorialScript(tutorialState.section.value);
      timer.cancel();
    });
  }
}
