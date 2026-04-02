import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/prog_system.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/shoe_achievement/shoe_achievement.dart';
import 'package:pomodoropompurin/scripts/layout/pom_timer/pom_timer_display.dart';

class ShoeAchievementMenu extends StatelessWidget {
  const ShoeAchievementMenu({super.key});

  @override
  Widget build(BuildContext context) {
    const sky = Color.fromARGB(214, 240, 248, 255);
    const ocean = Color(0xFF5DADE2);
    const softBlue = Color(0xFFAED6F1);

    final shoeList = ShoeAchievement.values;

    return Center(
      child: Transform.translate(
        offset: const Offset(50, -50),
        child: Container(
          width: 260,
          height: 320,
          padding: const EdgeInsets.all(14),

          child: Column(
            children: [
              _header('shoe achievements', Icons.emoji_events_rounded, ocean),

              const SizedBox(height: 8),

              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                      255,
                      202,
                      234,
                      255,
                    ).withOpacity(0.80),
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: shoeList.isEmpty
                      ? const Center(
                          child: Text(
                            "No shoes yet...",
                            style: TextStyle(
                              fontFamily: 'Fredoka',
                              fontSize: 14,
                              color: Colors.blueGrey,
                            ),
                          ),
                        )
                      : ListView.separated(
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 10),
                          itemCount: shoeList.length,
                          itemBuilder: (context, index) {
                            final achievement = shoeList[index];
                            final isUnlocked =
                                ProgSystem
                                    .singleton
                                    .acquiredShoeAchievementBool[achievement] ??
                                false;

                            return _shoeTile(
                              achievement: achievement,
                              isUnlocked: isUnlocked,
                              sky: sky,
                              softBlue: softBlue,
                            );
                          },
                        ),
                ),
              ),

              const SizedBox(height: 4),

              accTotalTime(color: const Color.fromARGB(255, 76, 140, 192)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(String menuTitle, IconData menuIcon, Color menuColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: menuColor.withOpacity(0.2).darken(0.3),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(spreadRadius: 4, color: menuColor.withOpacity(0.2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(shape: BoxShape.circle, color: menuColor),
            child: Icon(menuIcon, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              menuTitle,
              style: const TextStyle(
                fontFamily: 'Fredoka',
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.white,
                shadows: [Shadow(color: Colors.black38, offset: Offset(2, 2))],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget accTotalTime({
    required Color color,
    EdgeInsets padding = const EdgeInsets.symmetric(
      vertical: 3,
      horizontal: 10,
    ),
  }) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color.withOpacity(0.40),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.60)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.alarm, color: Colors.white),
          SizedBox(width: 4),
          Text(
            PomTimerExtensions.formatDuration(
              ProgSystem.singleton.accTotalTime.value,
            ),
            style: TextStyle(
              fontFamily: 'Fredoka',
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _shoeTile({
    required ShoeAchievement achievement,
    required bool isUnlocked,
    required Color sky,
    required Color softBlue,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isUnlocked
            ? softBlue.withOpacity(0.7)
            : Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isUnlocked
              ? softBlue.darken(0.3)
              : Colors.grey.withOpacity(0.4),
        ),
      ),
      child: Row(
        children: [
          /// Icon
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: sky,
              borderRadius: BorderRadius.circular(10),
            ),
            width: 45,
            child: Opacity(
              opacity: isUnlocked ? 1 : 0.4,
              child: Image.asset(achievement.flutterAssetPath),
            ),
          ),

          const SizedBox(width: 10),

          /// Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  achievement.displayName,
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                    color: isUnlocked ? Colors.blueGrey[800] : Colors.grey,
                  ),
                ),
                Text(
                  "Achieve ${PomTimerExtensions.formatDuration(achievement.secondsRequirement)}",
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: 10,
                    color: isUnlocked ? Colors.blueGrey[600] : Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          /// Status icon
          Icon(
            isUnlocked ? Icons.emoji_events : Icons.lock,
            color: isUnlocked ? Colors.lightBlue : Colors.grey,
            size: 16,
          ),
        ],
      ),
    );
  }
}
