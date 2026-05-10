import 'package:pomodoropompurin/scripts/foundation/achievement.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/prog_system.dart';

abstract class RewardableAchievement extends Achievement {
  RewardableAchievement({required super.goal, required this.rewards});

  bool claimed = false;
  Map<RewardType, int> rewards;

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
