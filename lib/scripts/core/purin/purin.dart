import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin_equip_manager.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin_state_manager.dart';

/// "Conqueror of Nations, Destructor of Worlds"
///
/// "Purin will be regarded as the most feared (and smolest)
/// icon, controlling the minds and hearts of all that witness it.
/// Despite his small stature, don't let it fool you of his cunning brilliance."
///
/// "From his round and squishy belly to his mindless thoughts, Purin
/// encapsulates the very essence of fear: an irresistable desire to love
/// his lazy ahh."
///
/// -------------------------------------------------------------------
/// Purin is a singleton class that compiles all Purin Managers (purin),
/// serving as a main communication for any Purin-related events and activities
class Purin extends ChangeNotifier {
  Purin._();
  static final singleton = Purin._();

  final stateManager = PurinStateManager.singleton;
  final equipManager = PurinEquipManager.singleton;

  void changePosition(PurinPosition position) {
    stateManager.changePostion(position);
    notifyListeners();
  }

  void changeAction(PurinAction action) {
    stateManager.changeAction(action);
    notifyListeners();
  }

  void pet() {
    changeAction(PurinAction.pet);
    notifyListeners();
  }

  void idle() {
    changeAction(PurinAction.idle);
    notifyListeners();
  }
}
