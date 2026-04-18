import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/event_systems/achievement_events/achievement_types/rewardable_achievement.dart';
import 'package:pomodoropompurin/scripts/core/event_systems/achievement_events/daily_achievement.dart';
import 'package:pomodoropompurin/scripts/layout/event_systems/achievement_reward_dialog.dart';
import 'package:pomodoropompurin/scripts/layout/pom_timer/pom_timer_display.dart';

class DailyAchievementDisplay extends StatefulWidget {
  const DailyAchievementDisplay({super.key});

  @override
  State<DailyAchievementDisplay> createState() =>
      _DailyAchievementDisplayState();
}

class _DailyAchievementDisplayState extends State<DailyAchievementDisplay> {
  final daily = DailyAchievement.singleton;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String formatDuration(int totalSeconds) {
    final int hours = (totalSeconds ~/ 3600) % 24;
    final int minutes = (totalSeconds ~/ 60) % 60;
    final int seconds = totalSeconds % 60;

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr';
  }

  String formatTime(int seconds) {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    final s = seconds % 60;

    return '${h.toString().padLeft(2, '0')}:'
        '${m.toString().padLeft(2, '0')}:'
        '${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final focus = daily.focusTimeAchievement;
    final pet = daily.petAchievement;

    return Center(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Container(
          height: 400,
          width: 400,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(107, 255, 255, 255),
              width: 3,
            ),
            color: Color.fromARGB(213, 145, 205, 243),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),

          child: Column(
            children: [
              /// TOP BAR
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 30),

                  Text(
                    'daily achievements',
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      shadows: [
                        Shadow(color: Colors.black38, offset: Offset(2, 2)),
                      ],
                    ),
                  ),

                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.expand_more),
                    color: Colors.white,
                  ),
                ],
              ),

              const SizedBox(height: 8),

              /// INNER PANEL
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    /// Countdown
                    Center(
                      child: Text(
                        "refresh in ${formatTime(daily.refreshCountdownSeconds)}",
                        style: TextStyle(
                          fontFamily: 'Fredoka',
                          fontSize: 13,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    _achievementBar(
                      icon: Icons.timer,
                      title: "focus time",
                      progress: focus.progress,
                      goal: focus.goal,
                      claimed: focus.claimed,
                      onClaim: focus.achieved && !focus.claimed
                          ? () {
                              setState(() {
                                daily.claimFocusTimeRewards();
                                final rewards =
                                    daily.focusTimeAchievement.rewards;

                                showDialog(
                                  context: context,
                                  builder: (dialContext) =>
                                      AchievementRewardDialog(
                                        pomPoints:
                                            rewards[RewardType.pomPoints] ?? 0,
                                        oshiriPoints:
                                            rewards[RewardType.oshiriPoints] ??
                                            0,
                                        onClose: () =>
                                            Navigator.pop(dialContext),
                                      ),
                                );
                              });
                            }
                          : null,
                      color: const Color.fromARGB(255, 158, 197, 68),
                      isDurationFormat: true,
                    ),

                    const SizedBox(height: 14),

                    _achievementBar(
                      icon: Icons.favorite,
                      title: "energy from petting",
                      progress: pet.progress,
                      goal: pet.goal,
                      claimed: pet.claimed,
                      onClaim: pet.achieved && !pet.claimed
                          ? () {
                              setState(() {
                                daily.claimPetRewards();
                                final rewards = daily.petAchievement.rewards;

                                showDialog(
                                  context: context,
                                  builder: (dialContext) =>
                                      AchievementRewardDialog(
                                        pomPoints:
                                            rewards[RewardType.pomPoints] ?? 0,
                                        oshiriPoints:
                                            rewards[RewardType.oshiriPoints] ??
                                            0,
                                        onClose: () =>
                                            Navigator.pop(dialContext),
                                      ),
                                );
                              });
                            }
                          : null,
                      color: const Color.fromARGB(255, 158, 197, 68),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _achievementBar({
    required IconData icon,
    required String title,
    required int progress,
    required int goal,
    required bool claimed,
    required VoidCallback? onClaim,
    required Color color,
    bool isDurationFormat = false,
  }) {
    final percent = goal == 0 ? 0.0 : progress / goal;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(55, 116, 204, 194),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20),
              SizedBox(width: 5),
              Text(
                title,
                style: const TextStyle(fontFamily: 'Fredoka', fontSize: 14),
              ),
            ],
          ),

          const SizedBox(height: 6),

          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: percent.clamp(0.0, 1.0),
              minHeight: 10,
              backgroundColor: Colors.grey[300],
              color: color,
            ),
          ),

          Text(
            (isDurationFormat)
                ? "(${formatDuration(progress)} / ${formatDuration(goal)})"
                : "($progress / $goal)",
            style: const TextStyle(fontFamily: 'Fredoka', fontSize: 12),
          ),

          const SizedBox(height: 8),

          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: onClaim,
              style: ElevatedButton.styleFrom(
                backgroundColor: claimed
                    ? Colors.grey
                    : (percent >= 1 ? color : Colors.grey[400]),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                claimed
                    ? "claimed"
                    : percent >= 1
                    ? "claim"
                    : "locked",
                style: const TextStyle(
                  fontFamily: 'Fredoka',
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
