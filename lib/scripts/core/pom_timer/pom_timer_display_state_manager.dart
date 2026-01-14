class PomTimerDisplayStateManager {
  PomTimerDisplayStateManager._();
  static final singleton = PomTimerDisplayStateManager._();

  /// Functions set in PomTimerDisplay
  /// Switches between OPEN BUTTON and MAIN WIDGET
  void Function() openPomTimer = () {};
  void Function() closePomTimer = () {};

  /// Functions set in PomTimerMainWidget
  /// Switches between ACTIVE and IDLE
  void Function(String) switchPomTimerMode = (mode) {};

  /// Functions set in PomTimerMainACTIVE
  /// Switches between WORK and BREAK
  /// NOTE: Break and Paused have same states (remove this note if not anymore...)
  void Function() inputPomTimerByActive = () {};
  void Function() playPomTimerByActive = () {};
  void Function() pausePomTimerByActive = () {};

  /// Functions set in PomTimerMainWIDGET
  /// Switches between WORK and BREAK
  /// NOTE: Break and Paused have same states (remove this note if not anymore...)
  void Function() inputPomTimerByMain = () {};
  void Function() playPomTimerByMain = () {};
  void Function() pausePomTimerByMain = () {};
}
