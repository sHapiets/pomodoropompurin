import 'dart:async' as async_lib;
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/acquirables.dart';
import 'package:pomodoropompurin/scripts/core/dialog/script_dialog/script_manager.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/prog_system.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin_equip_manager.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_equip_manager.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/ui/purin_metrics_ui_state.dart';
import 'package:pomodoropompurin/scripts/core/ui/ui_display_state.dart';
import 'package:pomodoropompurin/scripts/foundation/acquirable.dart';
import 'package:pomodoropompurin/scripts/foundation/consumable.dart';
import 'package:pomodoropompurin/scripts/memory/database_manager.dart';

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
  Purin._() {
    initializeHungerTimer();
    initializeEnergyDepletionLoop();
  }
  static final singleton = Purin._();

  final stateManager = PurinStateManager.singleton;
  final equipManager = PurinEquipManager.singleton;
  final purinAreaEquipManager = PurinAreaEquipManager.singleton;
  final purinAreaStateManager = PurinAreaStateManager.singleton;
  final acquirables = Acquirables.singleton;
  final databaseManager = DatabaseManager.singleton;
  final progSystem = ProgSystem.singleton;

  void changeAction(PurinAction action) {
    stateManager.changeAction(action);
    notifyListeners();
  }

  /// POSITION LOGIC
  /// Purin's position in [PurinAreaHome] is set by setting the Vector2 position
  /// variable of [PurinEntity].
  /// (*) In order to change it, this class's changePosition
  /// should be called by passing a [PurinPosition] argument,
  /// an enum class defined in the StateManager,which provides a limited possible
  /// variations of positions where Purin could be placed.
  /// (*) Given a certain [PurinPosition], you can define what Vector2 it
  /// corresponds to by adding a case in the switch block inside the
  /// purinPositionVect2 function below, in which [PurinEntity] automatically
  /// updates from (via this class's ChangeNotifier).
  void changePosition(PurinPosition position) {
    stateManager.changePostion(position);
    notifyListeners();
  }

  Vector2 get purinPositionVect2 {
    switch (stateManager.position) {
      case PurinPosition.kotatsuLeft:
        return purinAreaEquipManager
            .kotatsu
            .value
            .purinPositionVectors[PurinPosition.kotatsuLeft]!;
      case PurinPosition.kotatsuRight:
        return purinAreaEquipManager
            .kotatsu
            .value
            .purinPositionVectors[PurinPosition.kotatsuRight]!;
      case PurinPosition.futon:
        return purinAreaEquipManager
            .futon
            .value
            .purinPositionVectors[PurinPosition.futon]!;
      case PurinPosition.study:
        return purinAreaEquipManager
            .studyTable
            .value
            .purinPositionVectors[PurinPosition.study]!;
    }
  }

  int get purinPriority {
    switch (stateManager.position) {
      case PurinPosition.kotatsuLeft:
        return 40;
      case PurinPosition.kotatsuRight:
        return 40;
      case PurinPosition.futon:
        return 40;
      case PurinPosition.study:
        return 90;
    }
  }

  /// EQUIP LOGIC
  ///
  ///
  Future<void> equip(PurinVars purinVars) async {
    final purinVar = acquirables.purinVars[purinVars]!;
    equipManager.equip(purinVar);
    databaseManager.configPurinVarSave(purinVars);
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
  /// (3) In every petting gesture, pet() is called, which notifies sprite
  /// changes, and starts a cooldown timer before going back to idle
  double petDeltaX = 0;
  double petDeltaY = 0;
  final random = Random();
  async_lib.Timer petCooldown = async_lib.Timer.periodic(
    Duration(milliseconds: 700),
    (timer) {
      PurinStateManager.singleton.action = PurinAction.idle;
      timer.cancel();
    },
  );
  void pet() {
    final bool energyFromPet = random.nextBoolean(odds: 0.05);
    int energy = energyFromPet ? 1 : 0;
    addEnergyPoints(energy: energy);

    stateManager.action = PurinAction.pet;
    purinAreaStateManager.jumpToPosition(
      purinPositionVect2,
      Vector2.zero(),
      2.0,
    );
    petCooldown.cancel();
    petCooldown = async_lib.Timer.periodic(Duration(milliseconds: 700), (
      timer,
    ) {
      PurinStateManager.singleton.action = PurinAction.idle;
      notifyListeners();
      timer.cancel();
    });
    notifyListeners();
  }

  void updatePetDelta(Vector2 delta) {
    if ((delta.x > 0 && petDeltaX <= 0) || (delta.x < 0 && petDeltaX >= 0)) {
      petDeltaX = delta.x;
      pet();
    }
    if ((delta.y > 0 && petDeltaY <= 0) || (delta.y < 0 && petDeltaY >= 0)) {
      petDeltaY = delta.y;
      pet();
    }
  }

  /// FEEDING LOGIC
  /// Feeding is a state for both [Purin] and [PurinArea].
  /// (For context), just like for Petting, [PurinArea] needs to identify that the
  /// current gesture/action is feeding. This is set by tapping the [Feedable] component
  /// in [PurinAreaHome] (See Feedable class for more info...)
  /// Once set, [PurinEntity] will recieve the OnTap to activate the feed() function
  /// below.
  /// Just like in petting, a timer is engaged to switch the state back to idle.
  ///
  async_lib.Timer feedCooldown = async_lib.Timer.periodic(
    Duration(milliseconds: 2500),
    (timer) {
      PurinStateManager.singleton.action = PurinAction.idle;
      timer.cancel();
    },
  );

  void feed() {}

  void feedFeedable() {
    final reward = purinAreaEquipManager.feedable.value.oshiriPointsPerBite;
    progSystem.addOshiriPoints(reward);

    final hungerPoints =
        purinAreaEquipManager.feedable.value.hungerPointsPerBite;
    addHungerPoints(hunger: hungerPoints);

    stateManager.changeAction(PurinAction.feed);
    stateManager.changePostion(PurinPosition.kotatsuLeft);
    purinAreaStateManager.jumpToPosition(
      purinPositionVect2,
      Vector2(25, 0),
      1.8,
    );
    ScriptManager.singleton.removeFeedDialog();
    ScriptManager.singleton.addFeedDialog();
    PurinMetricsUIState.singleton.showWidget();
    UIDisplayState.singleton.hide.value = true;
    feedCooldown.cancel();
    feedCooldown = async_lib.Timer.periodic(Duration(milliseconds: 2500), (
      timer,
    ) {
      PurinMetricsUIState.singleton.hideWidget();
      ScriptManager.singleton.removeFeedDialog();
      PurinStateManager.singleton.action = PurinAction.idle;
      notifyListeners();
      timer.cancel();
    });
    notifyListeners();
  }

  void feedSnack(Consumable snack) {
    final oshiriPoints = snack.biteSpritesFlamePath;
  }

  /// HUNGER LOGIC
  ///
  ///
  ///
  Duration hungerTimerDelta = const Duration(minutes: 2);
  late async_lib.Timer? hungerTimer;
  void initializeHungerTimer() {
    hungerTimer = async_lib.Timer.periodic(hungerTimerDelta, (timer) {
      depleteHungerPoints(hunger: 1);
    });
  }

  void addHungerPoints({int hunger = 1}) {
    final newHunger = (stateManager.hunger.value + hunger).clamp(0, 100);
    stateManager.hunger.value = newHunger;
  }

  void depleteHungerPoints({int hunger = 1}) {
    final newHunger = (stateManager.hunger.value - hunger).clamp(0, 100);
    stateManager.hunger.value = newHunger;
  }

  /// ENERGY LOGIC
  ///
  ///
  bool _energyLoopActive = false;

  void addEnergyPoints({int energy = 1}) {
    final newEnergy = (stateManager.energy.value + energy).clamp(0, 100);
    stateManager.energy.value = newEnergy;
  }

  void depleteEnergyPoints({int energy = 1}) {
    final newEnergy = (stateManager.energy.value - energy).clamp(0, 100);
    stateManager.energy.value = newEnergy;
  }

  void initializeEnergyDepletionLoop() {
    if (_energyLoopActive) return;
    _energyLoopActive = true;

    _energyDepletionLoop();
  }

  Future<void> _energyDepletionLoop() async {
    while (_energyLoopActive) {
      final delay = energyDepletionDeltaFromHunger();
      await Future.delayed(delay);

      depleteEnergyPoints(energy: 1);
    }
  }

  Duration energyDepletionDeltaFromHunger() {
    final hunger = stateManager.hunger.value.clamp(0, 100);
    const minSeconds = 75;
    const maxSeconds = 120;
    final t = hunger / 100;
    final seconds = minSeconds + ((maxSeconds - minSeconds) * t);

    return Duration(seconds: seconds.round());
  }

  void idle() {
    changeAction(PurinAction.idle);
  }
}
