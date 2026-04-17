import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/event_systems/achievement_events/streak_system.dart';
import 'package:pomodoropompurin/scripts/layout/event_systems/achievement_reward_dialog.dart';

class StreakDisplay extends StatelessWidget {
  const StreakDisplay({super.key});
  String getStreakTimer(StreakSystem streak) {
    final now = DateTime.now();

    DateTime toDateOnly(DateTime dt) {
      return DateTime(dt.year, dt.month, dt.day);
    }

    final today = toDateOnly(now);
    final lastDay = toDateOnly(streak.latestCompletion);

    final difference = today.difference(lastDay).inDays;

    final nextMidnight = today.add(const Duration(days: 1));
    final remaining = nextMidnight.difference(now);

    if (difference == 0) {
      return "next streak in ${formatDuration(remaining.inSeconds)}";
    } else {
      return "expires in ${formatDuration(remaining.inSeconds)}";
    }
  }

  String formatDuration(int totalSeconds) {
    final int hours = (totalSeconds ~/ 3600) % 24;
    final int minutes = (totalSeconds ~/ 60) % 60;
    final int seconds = totalSeconds % 60;

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');
    String ret = '$hoursStr:$minutesStr:$secondsStr';

    if (hours == 0) {
      ret = '$minutesStr:$secondsStr';
    }

    return ret;
  }

  @override
  Widget build(BuildContext context) {
    final streak = StreakSystem.singleton;

    final percent = (streak.focusTime / StreakSystem.minSessionSeconds).clamp(
      0.0,
      1.0,
    );

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Center(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color.fromARGB(206, 255, 218, 176),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6D4C41).withOpacity(0.25),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// TITLE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 30), // balances the close button

                  const Text(
                    "daily streak",
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      shadows: [
                        Shadow(color: Colors.black38, offset: Offset(2, 2)),
                      ],
                    ),
                  ),

                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    color: const Color(0xFF6D4C41),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Column(
                children: [
                  const Icon(
                    Icons.local_fire_department,
                    color: Colors.orange,
                    size: 40,
                    shadows: [
                      Shadow(
                        color: Color.fromARGB(139, 214, 83, 43),
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${streak.current}",
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
                ],
              ),
              const SizedBox(height: 6),

              Text(
                getStreakTimer(streak),
                style: TextStyle(
                  fontFamily: 'Fredoka',
                  fontSize: 12,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 16),

              /// PROGRESS BAR
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "daily focus time",
                    style: TextStyle(fontFamily: 'Fredoka', fontSize: 13),
                  ),

                  const SizedBox(height: 6),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: percent,
                      minHeight: 10,
                      backgroundColor: Colors.grey[300],
                      color: Colors.orange,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "${formatDuration(streak.focusTime)} / ${formatDuration(StreakSystem.minSessionSeconds)}",
                    style: const TextStyle(fontFamily: 'Fredoka', fontSize: 12),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              /// CLAIM BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (!streak.claimed && percent >= 1)
                      ? () {
                          streak.claimRewards();
                          Navigator.pop(context);
                          final int pomPointsRewards = streak.current * 60;
                          final int oshiriPointsRewards = streak.current * 50;

                          showDialog(
                            context: context,
                            builder: (_) => AchievementRewardDialog(
                              pomPoints: pomPointsRewards,
                              oshiriPoints: oshiriPointsRewards,
                              onClose: () => Navigator.pop(context),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (!streak.claimed && percent >= 1)
                        ? Colors.orange
                        : Colors.grey,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    streak.claimed
                        ? "claimed"
                        : percent >= 1
                        ? "claim rewards"
                        : "-accompish to claim rewards-",
                    style: const TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
