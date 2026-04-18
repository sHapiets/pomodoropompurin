import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/prog_system.dart';
import 'package:pomodoropompurin/scripts/memory/database_manager.dart';

class StreakSystem {
  StreakSystem._();
  static final singleton = StreakSystem._();

  static const int minSessionSeconds = 900;

  final databaseManager = DatabaseManager.singleton;

  DateTime latestCompletion = DateTime.now();

  int current = 0;
  int focusTime = 0;
  bool claimed = false;
  ValueNotifier<bool> claimable = ValueNotifier(false);

  DateTime toDateOnly(DateTime dt) {
    return DateTime(dt.year, dt.month, dt.day);
  }

  void initialize(DocumentSnapshot streakDoc) {
    claimed = streakDoc['claimed'];
    claimable.value = !claimed;
    current = streakDoc['current'];

    final Timestamp latestCompletionTimestamp = streakDoc['latestCompletion'];
    latestCompletion = latestCompletionTimestamp.toDate();

    focusTime = streakDoc['focusTime'];

    final today = toDateOnly(DateTime.now());
    final lastDay = toDateOnly(latestCompletion);

    final difference = today.difference(lastDay).inDays;

    if (difference >= 2) {
      resetStreak();
    } else if (difference == 1) {
      focusTime = 0;
      claimed = false;
      claimable.value = false;
      databaseSave();
    }
  }

  void registerFocusSession(int sessionSeconds) {
    final now = DateTime.now();
    focusTime = (focusTime + sessionSeconds).clamp(0, minSessionSeconds);

    final today = toDateOnly(now);
    final lastDay = toDateOnly(latestCompletion);

    final difference = today.difference(lastDay).inDays;

    if (difference >= 1) {
      if (focusTime >= minSessionSeconds) {
        latestCompletion = now;
        current += 1;
        claimed = false;
        claimable.value = true;

        databaseSave();
        return;
      }
    }

    databaseSave();
  }

  void resetStreak() {
    current = 0;
    focusTime = 0;
    claimed = false;
    claimable.value = false;
    databaseSave();
  }

  void claimRewards() {
    if (claimed) return;

    claimed = true;
    claimable.value = false;

    final int pomPointsRewards = current * 60;
    final int oshiriPointsRewards = current * 50;

    ProgSystem.singleton.addPomPoints(pomPointsRewards);
    ProgSystem.singleton.addOshiriPoints(oshiriPointsRewards);

    databaseSave();
  }

  void databaseSave() {
    databaseManager.statusStreakSave(
      claimed,
      current,
      focusTime,
      latestCompletion,
    );
  }
}
