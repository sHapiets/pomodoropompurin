import 'package:flutter/widgets.dart';
import 'package:pomodoropompurin/scripts/core/prog_system.dart';
import 'package:pomodoropompurin/scripts/memory/database_manager.dart';

class UnlockManager {
  UnlockManager._() {
    initialize();
  }
  static final singleton = UnlockManager._();

  final progSystem = ProgSystem.singleton;
  final databaseManager = DatabaseManager.singleton;

  int currentLevel = 0;

  Future<void> initialize() async {
    currentLevel = progSystem.oshiriLevel.value;
    currentLevel = await databaseManager.userDataLoad('oshiriPoints');
    progSystem.oshiriLevel.addListener(unlockFromLevel);
  }

  void unlockFromLevel() {
    if (currentLevel == progSystem.oshiriLevel.value) {
      return;
    }

    currentLevel = progSystem.oshiriLevel.value;
    switch (currentLevel) {
      case 2:
        debugPrint('hello');
      case 3:
        debugPrint('nice');
      case 4:
        debugPrint('nice');
    }
  }
}
