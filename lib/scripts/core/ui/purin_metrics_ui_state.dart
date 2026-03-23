import 'package:flutter/material.dart';

class PurinMetricsUIState {
  PurinMetricsUIState._();
  static final singleton = PurinMetricsUIState._();

  ValueNotifier<bool> hide = ValueNotifier(true);

  void showWidget() => hide.value = false;
  void hideWidget() => hide.value = true;
}
