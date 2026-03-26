import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/prog_system.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/shoe_achievement/shoe_achievement.dart';
import 'package:pomodoropompurin/scripts/layout/pom_timer/pom_timer_display.dart';

class ShoeAchievementMenu extends StatelessWidget {
  const ShoeAchievementMenu({super.key});

  @override
  Widget build(BuildContext context) {
    const sky = Color(0xFFF0F8FF); // soft white-blue
    const ocean = Color(0xFF5DADE2); // main blue
    const softBlue = Color(0xFFAED6F1); // pastel accent

    final shoeList = ShoeAchievement.values;

    return Center(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Transform.translate(
          offset: const Offset(50, -50),
          child: Container(
            width: 260,
            height: 320,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: sky,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: ocean.withOpacity(.25),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),

            child: Column(
              children: [
                /// Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.emoji_events, color: ocean),
                    SizedBox(width: 8),
                    Text(
                      "Shoe Achievements",
                      style: TextStyle(
                        fontFamily: 'Fredoka',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: ocean,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                const Text(
                  "....here lies your lost shoes....\n ....rest in pudding....",
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: 14,
                    color: Colors.blueGrey,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),

                /// List
                Expanded(
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
                              const SizedBox(height: 12),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 🔹 Tile builder
  Widget _shoeTile({
    required ShoeAchievement achievement,
    required bool isUnlocked,
    required Color sky,
    required Color softBlue,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isUnlocked
            ? softBlue.withOpacity(0.7)
            : Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
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
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: sky,
              borderRadius: BorderRadius.circular(12),
            ),
            width: 50,
            child: Opacity(
              opacity: isUnlocked ? 1 : 0.4,
              child: Image.asset(achievement.flutterAssetPath),
            ),
          ),

          const SizedBox(width: 12),

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
                    fontSize: 12,
                    color: isUnlocked ? Colors.blueGrey[800] : Colors.grey,
                  ),
                ),
                Text(
                  "Achieve ${PomTimerExtensions.formatDuration(achievement.secondsRequirement)}",
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: 12,
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
            size: 18,
          ),
        ],
      ),
    );
  }
}
