import 'package:pomodoropompurin/scripts/core/event_systems/achievement_events/achievement_types/rewardable_achievement.dart';

class SnackAchievement extends RewardableAchievement {
  SnackAchievement({required super.goal, required super.rewards});

  static SnackAchievement newSnackAchievement(int goalAmount) {
    final pomPointsReward = (goalAmount * 10).floor();
    final oshiriPointsReward = (goalAmount * 30).floor();

    return SnackAchievement(
      goal: goalAmount,
      rewards: {
        RewardType.pomPoints: pomPointsReward,
        RewardType.oshiriPoints: oshiriPointsReward,
      },
    );
  }
}
