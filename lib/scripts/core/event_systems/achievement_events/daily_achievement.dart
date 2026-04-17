import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pomodoropompurin/scripts/core/event_systems/achievement_events/achievement_types/focus_time_achievement.dart';
import 'package:pomodoropompurin/scripts/core/event_systems/achievement_events/achievement_types/pet_achievement.dart';
import 'package:pomodoropompurin/scripts/memory/database_manager.dart';

class DailyAchievement {
  DailyAchievement._();
  static final singleton = DailyAchievement._();

  DateTime latestRefresh = DateTime.now();
  DateTime get refreshDeadline => latestRefresh.add(const Duration(days: 1));
  int get refreshCountdownSeconds {
    final ret = refreshDeadline.difference(DateTime.now()).inSeconds;
    if (ret <= 0) return 0;
    return ret;
  }

  FocusTimeAchievement focusTimeAchievement =
      FocusTimeAchievement.newFocusTimeAchievement(0);
  PetAchievement petAchievement = PetAchievement.newPetAchievement(0);

  final databaseManager = DatabaseManager.singleton;

  void initialize(DocumentSnapshot dailyAchievementDoc) {
    final Timestamp latestRefreshTimestamp =
        dailyAchievementDoc['latestRefresh'];
    latestRefresh = latestRefreshTimestamp.toDate();

    if (refreshCountdownSeconds <= 0) {
      latestRefresh = DateTime.now();
      refresh();
      DatabaseManager.singleton.statusDailyAchievementLatestRefreshSave(
        DateTime.now(),
      );
    } else {
      loadAchievementStatus(dailyAchievementDoc);
    }
  }

  void loadAchievementStatus(DocumentSnapshot dailyAchievementDoc) {
    Map<String, dynamic> focusTimeAchievementStatus =
        dailyAchievementDoc['focusTime'];
    focusTimeAchievement = FocusTimeAchievement.newFocusTimeAchievement(
      focusTimeAchievementStatus['goalSeconds'],
    );
    focusTimeAchievement.progress = focusTimeAchievementStatus['progress'];
    focusTimeAchievement.claimed = focusTimeAchievementStatus['claimed'];

    Map<String, dynamic> petEnergyAchievementStatus =
        dailyAchievementDoc['petEnergy'];
    petAchievement = PetAchievement.newPetAchievement(
      petEnergyAchievementStatus['goalEnergy'],
    );
    petAchievement.progress = petEnergyAchievementStatus['progress'];
    petAchievement.claimed = petEnergyAchievementStatus['claimed'];
  }

  void refresh() {
    final rand = Random();

    final List<int> goalSecondsPool = [3600, 5400, 7200];
    final randGoalSeconds =
        goalSecondsPool[rand.nextInt(goalSecondsPool.length)];
    focusTimeAchievement = FocusTimeAchievement.newFocusTimeAchievement(
      randGoalSeconds,
    );
    databaseManager.statusDailyAchievementFocusTimeSave(focusTimeAchievement);

    final List<int> petEnergyPool = [10, 15, 20];
    final randPetEnergy = petEnergyPool[rand.nextInt(petEnergyPool.length)];
    petAchievement = PetAchievement.newPetAchievement(randPetEnergy);
    databaseManager.statusDailyAchievementPetSave(petAchievement);
  }

  void addFocusTimeProgress(int progress) {
    focusTimeAchievement.addProgress(progress);
    databaseManager.statusDailyAchievementFocusTimeSave(focusTimeAchievement);
  }

  void addPetProgress(int progress) {
    petAchievement.addProgress(progress);
    databaseManager.statusDailyAchievementPetSave(petAchievement);
  }

  void claimFocusTimeRewards() {
    focusTimeAchievement.claimRewards();
    databaseManager.statusDailyAchievementFocusTimeSave(focusTimeAchievement);
  }

  void claimPetRewards() {
    petAchievement.claimRewards();
    databaseManager.statusDailyAchievementPetSave(petAchievement);
  }
}
