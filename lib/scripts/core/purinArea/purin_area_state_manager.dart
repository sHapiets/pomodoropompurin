import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

class PurinAreaStateManager {
  PurinAreaStateManager._();
  static final singleton = PurinAreaStateManager._();

  ValueNotifier<String> state = ValueNotifier('Idle');

  /// Function set in PurinArea, updates newPosition s.t. position is at center
  void Function(Vector2, Vector2, double) jumpToPosition =
      (Vector2 position, Vector2 offset, double scale) {};
  void Function(Vector2) jumpCenterPositionAndScaled = (Vector2 position) {};
}
