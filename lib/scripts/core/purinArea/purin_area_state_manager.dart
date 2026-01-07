import 'package:flutter/foundation.dart';

class PurinAreaStateManager {
  PurinAreaStateManager._();
  static final singleton = PurinAreaStateManager._();

  String state = 'Idle';
  bool get isTransforming => (state == 'Idle') ? false : true;
}
