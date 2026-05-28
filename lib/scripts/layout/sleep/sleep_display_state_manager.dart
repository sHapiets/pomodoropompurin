import 'package:flutter/material.dart';

class SleepDisplayStateManager {
  SleepDisplayStateManager._();
  static final singleton = SleepDisplayStateManager._();

  ValueNotifier<SleepDisplayState> state = ValueNotifier(
    SleepDisplayState.close,
  );
}

enum SleepDisplayState { open, close, sleep }
