import 'dart:async';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/main.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer_display_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:pomodoropompurin/scripts/foundation/rewards_conversion.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/prog_system.dart';
import 'package:pomodoropompurin/scripts/layout/pom_timer/dialogs/end_pom_timer_dialog.dart';
import 'package:pomodoropompurin/scripts/memory/database_manager.dart';

/// Logic class for the Pomodoro Timer and its events
///
/// Handles most of the actual states of things, which might not be the most
/// optimal way of handling such complexity. But regardless, comments
/// were added for everyone's convinience, especially mine.
///
/// A brief rundown of its functions:
/// - control of the PomTimerDisplay widgets via state manager
/// - updating Koupen of rewards and DateLog data
/// -
class PomTimer {
  PomTimer._(); // singleton-ing
  static final PomTimer singleton = PomTimer._();

  final purin = Purin.singleton;
  final purinAreaStateManager = PurinAreaStateManager.singleton;
  final _progSystem = ProgSystem.singleton;
  final _databaseManager = DatabaseManager.singleton;

  final pomTimerDisplayStateManager = PomTimerDisplayStateManager.singleton;

  Timer timer = Timer.periodic(const Duration(seconds: 0), (timer) {});
  int loopsSet = 3;
  int timeSetWorkSeconds = 0; // The initialized values
  int timeSetBreakSeconds = 0;

  int timeTotalSeconds =
      0; // Total time for rewards (max is loopsSet * timeSetWork)
  int timeLeftSeconds = 0; // A counter for time left
  int loopsLeft = 0;

  bool restart =
      true; // true if the current timer is starting from initial input time
  bool isPlaying = false;
  bool onBreak = false;

  void playTimer() {
    if (isPlaying) {
      // already playing...
    } else {
      isPlaying = true;
      pomTimerDisplayStateManager.pomTimerState.value = PomTimerStates.play;
      purin.changePosition(PurinPosition.study);
      purinAreaStateManager.jumpToPosition(
        purin.purinPositionVect2,
        Vector2(0, 50),
        2.0,
      );

      if (restart) {
        // Not a 'resume', set INITIAL INPUT times
        if (onBreak) {
          // Set time to initial BREAK time
          timeLeftSeconds = timeSetBreakSeconds;
        } else {
          // Set time to initial WORK time
          timeLeftSeconds = timeSetWorkSeconds;
        }

        loopsLeft = loopsSet;

        /// Save latest PomTimerInput to database
        _databaseManager.userConfigTimerSave(
          timeSetWorkSeconds,
          timeSetBreakSeconds,
          loopsSet,
        );

        /// Note that PomTimer is active in case of disconnection
        _databaseManager.statusPomTimerSave('wasActive', true);
        restart = false;
      } else {
        // if restart is false, just resume...
      }

      /// Update initial Display via ValueNotifier
      pomTimerDisplayStateManager.timeLeftSeconds.value = timeLeftSeconds;

      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        timeLeftSeconds--;

        //// LOOPSSET: Break-Work Switching (or end if no more loops)
        if (timeLeftSeconds < 0) {
          if (onBreak == false) {
            // loops is decreased only when a worktime is complete
            ///////  ADD EVENT TRIGGER ///
            /// Like purin being like, "BREAK TIME!!" or sum shz

            loopsLeft--;
            timeLeftSeconds = timeSetBreakSeconds;
            timeTotalSeconds += timeSetWorkSeconds; // add to totalSeconds
            onBreak = true; // switch to break
            pomTimerDisplayStateManager.pomTimerState.value =
                PomTimerStates.onBreak;
            pomTimerDisplayStateManager.onBreak.value = true;
            if (loopsLeft <= 0) {
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
            pomTimerDisplayStateManager.pomTimerState.value =
                PomTimerStates.play;
            pomTimerDisplayStateManager.onBreak.value = false;
          }
        }

        /// Update Koupen of current TimeTotalSeconds
        if (onBreak) {
          _databaseManager.statusPomTimerSave(
            'wasTimeTotalSeconds',
            timeTotalSeconds,
          );
        } else {
          _databaseManager.statusPomTimerSave(
            'wasTimeTotalSeconds',
            timeTotalSeconds + (timeSetWorkSeconds - timeLeftSeconds),
          );
        }

        /// Periodical Updates to update PomTimerDisplay
        pomTimerDisplayStateManager.timeLeftSeconds.value = timeLeftSeconds;
      });
    }
  }

  void pauseTimer() {
    if (isPlaying) {
      isPlaying = false;
      timer.cancel();
      pomTimerDisplayStateManager.pomTimerState.value = PomTimerStates.pause;
    }
  }

  Future<void> endTimer() async {
    if (restart) {
      return;
    }

    if (onBreak) {
    } else {
      timeTotalSeconds += (timeSetWorkSeconds - timeLeftSeconds);
    }

    int rewardPomPoints = PomPointsConversion.fromSeconds(timeTotalSeconds);
    int rewardOshiriPoints = OshiriPointsConversion.fromSeconds(
      timeTotalSeconds,
    );

    pomTimerDisplayStateManager.closePomTimer();
    pomTimerDisplayStateManager.pomTimerState.value = PomTimerStates.exit;

    /// Tell Koupen that the timer was stopped before connection is severed;
    /// and rewards was already awarded...
    _databaseManager.statusPomTimerSave('wasActive', false);
    _databaseManager.statusPomTimerSave('wasTimeTotalSeconds', 0);

    timer.cancel();

    // Update outside
    _progSystem.addDayTimeSeconds(timeTotalSeconds);
    _progSystem.addAccTotalTime(timeTotalSeconds);
    _progSystem.addPomPoints(rewardPomPoints);
    pomTimerDisplayStateManager.timeLeftSeconds.value = timeLeftSeconds;

    await showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) {
        return EndPomTimerDialog(
          seconds: timeTotalSeconds,
          pomPoints: rewardPomPoints,
          oshiriPoints: rewardOshiriPoints,
          onClose: () => Navigator.pop(context),
        );
      },
    );

    restart = true;
    isPlaying = false;
    onBreak = false;
    pomTimerDisplayStateManager.onBreak.value = false;
    timeLeftSeconds = 0;
    timeTotalSeconds = 0;
  }
}
