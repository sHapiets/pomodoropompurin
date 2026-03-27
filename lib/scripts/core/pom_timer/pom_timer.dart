import 'dart:async';
import 'dart:math';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/main.dart';
import 'package:pomodoropompurin/scripts/core/audio/background_music.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer_display_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:pomodoropompurin/scripts/foundation/rewards_conversion.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/prog_system.dart';
import 'package:pomodoropompurin/scripts/layout/pom_timer/dialogs/end_pom_timer_dialog.dart';
import 'package:pomodoropompurin/scripts/memory/database_manager.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

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
  PomTimer._();
  static final PomTimer singleton = PomTimer._();

  final purin = Purin.singleton;
  final purinAreaStateManager = PurinAreaStateManager.singleton;
  final _progSystem = ProgSystem.singleton;
  final _databaseManager = DatabaseManager.singleton;

  final pomTimerDisplayStateManager = PomTimerDisplayStateManager.singleton;

  Timer timer = Timer.periodic(const Duration(seconds: 0), (timer) {});
  DateTime playStartDateTime = DateTime.now();
  int loopsSet = 3;
  int timeSetWorkSeconds = 0; // The initialized values
  int timeSetBreakSeconds = 0;

  int totalSessionTimeSeconds = 0;

  int timeTotalSeconds =
      0; // Total time for rewards (max is loopsSet * timeSetWork)
  double multiplierTotal = 0;
  int timeLeftSeconds = 0; // A counter for time left
  int loopsLeft = 0;

  bool restart =
      true; // true if the current timer is starting from initial input time
  bool isPlaying = false;
  bool onBreak = false;

  double initVolume = 1.0;

  void playTimer() {
    WakelockPlus.enable();
    if (isPlaying) {
      // already playing...
    } else {
      isPlaying = true;
      pomTimerDisplayStateManager.pomTimerState.value = onBreak
          ? PomTimerStates.onBreak
          : PomTimerStates.play;
      purin.changePosition(PurinPosition.study);
      purinAreaStateManager.jumpToPosition(
        purin.purinPositionVect2,
        Vector2(0, 50),
        2.0,
      );

      initVolume = BackgroundMusic().volume;
      BackgroundMusic().fadeTo(targetVolume: 0.05, duration: 2.0);

      if (restart) {
        onBreak = false;
        timeLeftSeconds = timeSetWorkSeconds;
        loopsLeft = loopsSet;

        /// Save latest PomTimerConfig to database
        _databaseManager.userConfigTimerSave(
          timeSetWorkSeconds,
          timeSetBreakSeconds,
          loopsSet,
        );

        restart = false;
      } else {
        // if restart is false, just resume...
      }

      /// Update initial Display via ValueNotifier
      pomTimerDisplayStateManager.timeLeftSeconds.value = timeLeftSeconds;

      int wasActiveTimeSaverStep = 0;
      int saverStepsCount = 1200;

      DateTime recordedDateTime = DateTime.now();
      int recordedTimeLeftSeconds = timeLeftSeconds;
      int recordedDeltaMilli = 0;

      timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
        final currenDateTime = DateTime.now();
        final deltaMilli = currenDateTime
            .difference(recordedDateTime)
            .inMilliseconds;
        recordedDateTime = currenDateTime;
        recordedDeltaMilli += deltaMilli;

        int deltaSeconds = (recordedDeltaMilli / 1000).floor();
        timeLeftSeconds -= deltaSeconds;
        recordedDeltaMilli -= deltaSeconds * 1000;

        if (timeLeftSeconds < -1) {
          timeLeftSeconds = -1;
          deltaSeconds = recordedTimeLeftSeconds;
        }

        /// Adding to timeTotal and multiplerFromEnergy
        if (!onBreak && deltaSeconds >= 1) {
          multiplierTotal +=
              PointMultiplier.fromEnergy(purin.stateManager.energy.value) *
              deltaSeconds;
          timeTotalSeconds += deltaSeconds;
        }

        recordedTimeLeftSeconds = timeLeftSeconds;

        //// LOOPSSET: Break-Work Switching (or end if no more loops)
        if (timeLeftSeconds < 0) {
          if (onBreak == false) {
            // loops is decreased only when a worktime is complete

            loopsLeft--;
            timeLeftSeconds = timeSetBreakSeconds;
            onBreak = true; // switch to break
            pomTimerDisplayStateManager.pomTimerState.value =
                PomTimerStates.onBreak;
            pomTimerDisplayStateManager.onBreak.value = true;
            if (loopsLeft <= 0) {
              // if no, more loops, end and award...
              timeLeftSeconds = timeSetWorkSeconds;
              endTimer(); // Award Maximum Points
              timer.cancel();
              return;
            }
          } else {
            // onBreak, switch to worktime

            timeLeftSeconds = timeSetWorkSeconds;
            onBreak = false;
            pomTimerDisplayStateManager.pomTimerState.value =
                PomTimerStates.play;
            pomTimerDisplayStateManager.onBreak.value = false;
          }
        }

        /// Update Koupen of current TimeTotalSeconds every saverStepsCount
        wasActiveTimeSaverStep += 1;
        if (wasActiveTimeSaverStep >= saverStepsCount) {
          wasActiveTimeSaverStep = 0;
          _databaseManager.statusPomTimerSave(
            wasActive: true,
            wasTimeTotalSeconds: timeTotalSeconds,
            wasMultiplierTotal: multiplierTotal,
          );
        }

        /// Periodical Updates to update PomTimerDisplay
        if (deltaSeconds > 0) {
          pomTimerDisplayStateManager.timeLeftSeconds.value = timeLeftSeconds;
        }
      });
    }
  }

  void pauseTimer() {
    if (isPlaying) {
      isPlaying = false;
      BackgroundMusic().fadeIn(targetVolume: initVolume, duration: 2.0);
      timer.cancel();
    }

    if (!onBreak) {
      pomTimerDisplayStateManager.pomTimerState.value = PomTimerStates.pause;
    }

    final random = Random();
    final randomPurinPosition =
        PurinPosition.values[random.nextInt(PurinPosition.values.length)];
    final purin = Purin.singleton;
    purin.changePosition(randomPurinPosition);
    PurinAreaStateManager.singleton.jumpToPosition(
      purin.purinPositionVect2,
      Vector2.zero(),
      1.2,
    );
  }

  void skipBreak() {
    if (onBreak) {
      timeLeftSeconds = -1;
      onBreak = true;
      playTimer();
    }
  }

  Future<void> endTimer() async {
    if (restart) {
      return;
    }

    double multiplierAverage = timeTotalSeconds > 0
        ? multiplierTotal / timeTotalSeconds
        : 0;
    int rewardPomPoints = PomPointsConversion.fromSeconds(
      timeTotalSeconds,
      multiplierAverage,
    );
    int rewardOshiriPoints = OshiriPointsConversion.fromSeconds(
      timeTotalSeconds,
      multiplierAverage,
    );

    pomTimerDisplayStateManager.closePomTimer();
    pomTimerDisplayStateManager.pomTimerState.value = PomTimerStates.exit;

    /// Tell Koupen that the timer was stopped before connection is severed;
    /// and rewards was already awarded...
    _databaseManager.statusPomTimerSave(
      wasActive: false,
      wasTimeTotalSeconds: 0,
      wasMultiplierTotal: 0.0,
    );

    BackgroundMusic().fadeIn(targetVolume: initVolume, duration: 2.0);
    timer.cancel();

    // Update outside
    _progSystem.addDayTimeSeconds(timeTotalSeconds);
    _progSystem.addAccTotalTime(timeTotalSeconds);
    _progSystem.addPomPoints(rewardPomPoints);
    _progSystem.addOshiriPoints(rewardOshiriPoints);
    pomTimerDisplayStateManager.timeLeftSeconds.value = timeLeftSeconds;

    await showGeneralDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) {
        return EndPomTimerDialog(
          seconds: timeTotalSeconds,
          pomPoints: rewardPomPoints,
          oshiriPoints: rewardOshiriPoints,
          onClose: () => Navigator.pop(context),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOutBack,
          reverseCurve: Curves.easeInOutBack,
        );

        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.7, end: 1).animate(curved),
            child: child,
          ),
        );
      },
    );

    restart = true;
    isPlaying = false;
    onBreak = false;
    pomTimerDisplayStateManager.onBreak.value = false;
    multiplierTotal = 0;
    timeLeftSeconds = 0;
    timeTotalSeconds = 0;
  }
}
