import 'package:flutter/material.dart';

class PomTimerDisplayStateManager {
  PomTimerDisplayStateManager._();
  static final singleton = PomTimerDisplayStateManager._();

  /// Value Notifier of current time
  ValueNotifier<int> timeLeftSeconds = ValueNotifier(0);

  /// ValueNotifer if onBreak
  ValueNotifier<bool> onBreak = ValueNotifier(false);

  /// State Notifier for all PomTimerWidgets (Active, Idle/Input, Pause)
  ValueNotifier<PomTimerStates> pomTimerState = ValueNotifier(
    PomTimerStates.idle,
  );

  /// Functions set in PomTimerDisplay
  /// Switches between OPEN BUTTON and MAIN WIDGET
  void Function() openPomTimer = () {};
  void Function() closePomTimer = () {};
}

enum PomTimerStates { idle, play, pause, onBreak }
