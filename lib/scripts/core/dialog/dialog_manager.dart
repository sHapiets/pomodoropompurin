import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DialogManager extends ChangeNotifier {
  DialogManager._();
  static final singleton = DialogManager._();

  void Function() removeCurrentDialog = () {};
}
