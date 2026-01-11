import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A singleton class that manages the state of PurinEntity
class PurinStateManager {
  PurinStateManager._();
  static final singleton = PurinStateManager._();

  String state = 'Idle';
}
