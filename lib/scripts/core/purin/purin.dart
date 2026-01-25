import 'package:flame/components.dart';
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
/// [Purin] is a logic class that compiles all Purin Managers (purin),
/// serving as a main communication for any Purin-related events and activities
///
/// In order to resolve changes, components that need Purin logic, such
/// as [PurinEntity] with its sprite and position, are to use
/// Purin.singleton.addListener(function), and pass a function that
/// needs changes within their respecitve scopes
///
/// For instance, I have added a listener in [PurinEntity] called
/// updateSprite(), which changes the link of the sprite whenever notified.
///
///
/// In the same way, any Widget or Component that needs to change
/// [Purin], like [PurinEquipMenu], should call a Purin function
/// to allow such changes
///
/// Putting simply, the changes undergo this process:
/// Widget (Input) -> Purin -> Managers -> Display (Output)
///
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

  /// PET LOGIC
  /// In order to register a petting action, a sequence of two
  /// user inputs is handled.
  /// --> an initial tap on [PurinEntity]...
  /// --> ...followed by a PanUpdate ()
  /// (1) [PurinEntity] registers OnTapDown, and sets the [Purin]'s state to "Pet",
  /// which registers any panning as a 'petting action' in [PurinArea].
  /// (2) [PurinArea] then calls the updatePetDelta() function, to register if
  /// a pan registers a petting gesture
  /// (3) In a petting gesture, pet() is called, which notifies sprite
  /// changes
  double petDeltaX = 0;
  double petDeltaY = 0;
  void Function() restartPetTimer = () {};
  void pet() {
    changeAction(PurinAction.pet);
    notifyListeners();
  }

  void updatePetDelta(Vector2 delta) {
    if ((delta.x > 0 && petDeltaX <= 0) || (delta.x < 0 && petDeltaX >= 0)) {
      petDeltaX = delta.x;
      pet();
      restartPetTimer();
    }
    if ((delta.y > 0 && petDeltaY <= 0) || delta.y < 0 && petDeltaY >= 0) {
      petDeltaY = delta.y;
      pet();
      restartPetTimer();
    }
  }

  void idle() {
    stateManager.action = PurinAction.idle;
    notifyListeners();
  }

  ///
}
