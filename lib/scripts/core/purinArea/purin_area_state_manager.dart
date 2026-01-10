import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

class PurinAreaStateManager {
  PurinAreaStateManager._();
  static final singleton = PurinAreaStateManager._();

  String state = 'Idle';
  bool get isTransforming => (state == 'Idle') ? false : true;

  /// Function set in PurinArea, updates newPosition s.t. position is at center
  void Function(Vector2) jumpToPosition = (Vector2 position) {};
}
