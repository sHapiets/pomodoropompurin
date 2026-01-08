import 'package:flutter/foundation.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin_state_manager.dart';

/// Handles and manages all the states of the entire app. Mostly
/// created to communicate core and layout/design states.
///
class GlobalStateManager {
  GlobalStateManager._();
  static final singleton = GlobalStateManager._();

  final _pomTimer = PomTimer.singleton;
  final _purinStateManager = PurinStateManager.singleton;

  String get _pomTimerState => _pomTimer.pomTimerState;
  String get _purinState => _purinStateManager.state;
}
