import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/prog_system.dart';

abstract class RewardableAchievement {
  RewardableAchievement({required this.goal, required this.rewards});

  final int goal;
  int progress = 0;
  bool claimed = false;
  Map<RewardType, int> rewards;

  bool get achieved => progress >= goal;

  void setProgress(int progress) {
    this.progress = progress;
  }

  void addProgress(int progress) {
    this.progress += progress;
    if (this.progress > goal) {
      this.progress = goal;
    }
  }

  void claimRewards() {
    claimed = true;
    rewards.forEach((type, value) {
      switch (type) {
        case RewardType.pomPoints:
          ProgSystem.singleton.addPomPoints(value);
        case RewardType.oshiriPoints:
          ProgSystem.singleton.addOshiriPoints(value);
      }
    });
  }
}

enum AchievementType { focusTime, feed, snack, pet }

enum RewardType { pomPoints, oshiriPoints }
