import 'package:flutter/widgets.dart';

class TutorialState {
  TutorialState._();
  static final singleton = TutorialState._();

  bool loadTutorial = false;
  ValueNotifier<int> section = ValueNotifier(0);
}
