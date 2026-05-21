import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin_state/purin_mood.dart';

/// A singleton class that manages the state of PurinEntity
class PurinStateManager {
  PurinStateManager._();
  static final singleton = PurinStateManager._();

  PurinAction action = PurinAction.idle;
  PurinPosition position = PurinPosition.kotatsuLeft;

  final int lowHungerThreshold = 40;
  final int lowEnergyThreshold = 40;

  ValueNotifier<PurinMood> mood = ValueNotifier(PurinMood.neutral);
  ValueNotifier<int> energy = ValueNotifier(40);
  ValueNotifier<int> hunger = ValueNotifier(10);
  ValueNotifier<int> hygiene = ValueNotifier(40);

  void changeAction(PurinAction action) {
    this.action = action;
  }

  void changePostion(PurinPosition position) {
    this.position = position;
  }
}

enum PurinAction { idle, down, pet, feed }

enum PurinPosition {
  kotatsuLeft(flipSprite: false),
  kotatsuRight(flipSprite: true),
  futon(flipSprite: true),
  study(flipSprite: true),
  sofaSitLeft(flipSprite: false),
  sofaSitRight(flipSprite: true),
  sofaRest(flipSprite: true);

  const PurinPosition({required this.flipSprite});

  final bool flipSprite;
}
