import 'package:pomodoropompurin/scripts/core/event_systems/achievement_events/achievement_types/rewardable_achievement.dart';

class PetAchievement extends RewardableAchievement {
  PetAchievement({required int goal, required Map<RewardType, int> rewards})
    : super(goal: goal, rewards: rewards);

  static PetAchievement newPetAchievement(int goalEnergy) {
    final pomPointsReward = (goalEnergy * 3).floor();
    final oshiriPointsReward = (goalEnergy * 2).floor();

    return PetAchievement(
      goal: goalEnergy,
      rewards: {
        RewardType.pomPoints: pomPointsReward,
        RewardType.oshiriPoints: oshiriPointsReward,
      },
    );
  }
}
