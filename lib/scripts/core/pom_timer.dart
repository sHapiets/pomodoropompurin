import 'dart:async';
import 'dart:ui';
import 'package:pomodoropompurin/scripts/layout/custom_dialogs.dart';
import 'package:pomodoropompurin/scripts/core/prog_system.dart';

/// Logic class for the Pomodoro Timer and its events
class PomTimer {
  PomTimer._(); // singleton-ing
  static final PomTimer singleton = PomTimer._();

  final _progSystem = ProgSystem.singleton;
  final _customDialogs = CustomDialogs.singleton;

  Timer timer = Timer.periodic(const Duration(seconds: 0), (timer) {});
  int loopsSet = 3;
  int timeSetWorkSeconds = 0; // The initialized values
  int timeSetBreakSeconds = 0;
  late DateTime dateSet;

  int timeTotalSeconds =
      0; // Total time for rewards (max is loopsSet * timeSetWork)
  int timeLeftSeconds = 0; // A counter for time left
  int timeDisplayedSeconds = 0; // Placeholder for what is put in Text

  bool restart =
      true; // true if the current timer is starting from initial input time
  bool isPlaying = false;
  bool onBreak = false;

  VoidCallback updatePomTimerCount = () {};
  VoidCallback updatePomTimerGauge = () {};

  void playTimer() {
    if (isPlaying) {
      // already playing...
    } else {
      isPlaying = true;

      if (restart) {
        // Not a 'resume', set INITIAL INPUT times
        if (onBreak) {
          // Set time to initial BREAK time
          timeLeftSeconds = timeSetBreakSeconds;
        } else {
          // Set time to initial WORK time
          timeLeftSeconds = timeSetWorkSeconds;
        }

        restart = false;
      } else {
        // if restart is false, just resume...
      }

      updatePomTimerDisplay();

      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        timeLeftSeconds--;

        //// LOOPSSET: Break-Work Switching (or end if no more loops)
        if (timeLeftSeconds < 0) {
          if (onBreak == false) {
            // loops is decreased only when a worktime is complete
            ///////  ADD EVENT TRIGGER ///
            /// Like purin being like, "BREAK TIME!!" or sum shz

            loopsSet--;
            timeLeftSeconds = timeSetBreakSeconds;
            timeTotalSeconds += timeSetWorkSeconds; // add to totalSeconds
            onBreak = true; // switch to break
            if (loopsSet <= 0) {
              // if no, more loops, end and award...
              timeLeftSeconds = timeSetWorkSeconds;
              endTimer(); // Award Maximum Points
              timer.cancel();
            }
          } else {
            // onBreak, switch to worktime
            ///////  ADD EVENT TRIGGER ///
            /// Like purin being like, "Let's do our best again" or sum shz

            timeLeftSeconds = timeSetWorkSeconds;
            onBreak = false;
          }
        }

        updatePomTimerDisplay();
      });
    }
  }

  void pauseTimer() {
    if (isPlaying) {
      isPlaying = false;
      timer.cancel();
    }
  }

  void endTimer() {
    // impossible to end the timer if the timer hadn't started
    if (restart) {
      return;
    }

    if (onBreak) {
    } else {
      timeTotalSeconds += (timeSetWorkSeconds - timeLeftSeconds);
    }

    int rewardPomPoints =
        timeTotalSeconds; //!! CHANGE CONVERSION RATE (1s = 1point???)

    restart = true; // restart to initial value
    isPlaying = false; // pause (stop) timer
    onBreak = false; // switch to work timer for next play.
    timeLeftSeconds = timeSetWorkSeconds;
    timeTotalSeconds = 0; //
    timer.cancel();

    _customDialogs.showRewardsEndTimeDialog(rewardPomPoints);

    // Update outside
    _progSystem.addPomPoints(rewardPomPoints);
    updatePomTimerDisplay();
  }

  void updatePomTimerDisplay() {
    updatePomTimerCount();
    updatePomTimerGauge();
  }
}
