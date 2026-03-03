import 'package:flutter/foundation.dart';

class UIDisplayState {
  UIDisplayState._();
  static final singleton = UIDisplayState._();

  ValueNotifier<bool> hide = ValueNotifier(false);
}
