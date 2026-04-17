import 'package:pomodoropompurin/scripts/core/event_systems/achievement_events/achievement_types/rewardable_achievement.dart';

class StreakAchievement extends RewardableAchievement {
  final int streak;

  StreakAchievement({
    required this.streak,
    required int goal,
    required Map<RewardType, int> rewards,
  }) : super(goal: goal, rewards: rewards);

  static StreakAchievement newStreakAchievement(int streak) {
    int pomPointsReward = streak * 75;
    int oshiriPointsReward = streak * 40;
    return StreakAchievement(
      streak: streak,
      goal: streak,
      rewards: {
        RewardType.pomPoints: pomPointsReward,
        RewardType.oshiriPoints: oshiriPointsReward,
      },
    );
  }
}
