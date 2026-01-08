class PomTimerDisplayStateManager {
  PomTimerDisplayStateManager._();
  static final singleton = PomTimerDisplayStateManager._();

  void Function() openPomTimer = () {};
  void Function() closePomTimer = () {};
}
