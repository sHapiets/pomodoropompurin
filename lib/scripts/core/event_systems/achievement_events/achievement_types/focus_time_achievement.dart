import 'package:pomodoropompurin/scripts/core/event_systems/achievement_events/achievement_types/rewardable_achievement.dart';

class FocusTimeAchievement extends RewardableAchievement {
  FocusTimeAchievement({
    required int goal,
    required Map<RewardType, int> rewards,
  }) : super(goal: goal, rewards: rewards);

  static FocusTimeAchievement newFocusTimeAchievement(int goalSeconds) {
    final pomPointsReward = (goalSeconds / 18).floor();
    final oshiriPointsReward = (goalSeconds / 30).floor();

    return FocusTimeAchievement(
      goal: goalSeconds,
      rewards: {
        RewardType.pomPoints: pomPointsReward,
        RewardType.oshiriPoints: oshiriPointsReward,
      },
    );
  }
}
