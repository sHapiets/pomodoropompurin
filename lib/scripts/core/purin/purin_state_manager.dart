import 'package:flutter/material.dart';

/// A singleton class that manages the state of PurinEntity
class PurinStateManager {
  PurinStateManager._();
  static final singleton = PurinStateManager._();

  PurinAction action = PurinAction.idle;
  PurinPosition position = PurinPosition.kotatsuLeft;

  PurinMood mood = PurinMood.stable;
  ValueNotifier<int> energy = ValueNotifier(40);
  ValueNotifier<int> hunger = ValueNotifier(10);

  void changeAction(PurinAction action) {
    this.action = action;
  }

  void changePostion(PurinPosition position) {
    this.position = position;
  }
}

enum PurinAction { idle, pet, feed }

enum PurinPosition {
  kotatsuLeft,
  kotatsuRight,
  futon,
  study,
  sofaSitLeft,
  sofaSitRight,
  sofaRest,
}

enum PurinMood { down, stable }
