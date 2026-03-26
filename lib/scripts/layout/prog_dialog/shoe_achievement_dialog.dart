import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/shoe_achievement/shoe_achievement.dart';
import 'package:pomodoropompurin/scripts/layout/pom_timer/pom_timer_display.dart';

class ShoeAchievementDialog extends StatelessWidget {
  const ShoeAchievementDialog({super.key, required this.newShoeAchievement});

  final ShoeAchievement newShoeAchievement;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(26),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 176, 209, 255),
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6D4C41).withOpacity(0.3),
                blurRadius: 25,
                offset: const Offset(0, 12),
              ),
            ],
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Title badge
              const Text(
                "Shoe Achievement Unlocked!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Fredoka',
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Color.fromARGB(255, 40, 54, 116),
                ),
              ),

              const SizedBox(height: 20),

              /// Shoe Image (circle like Purin)
              Container(
                height: 200,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 165, 138, 255),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(newShoeAchievement.flutterAssetPath),
              ),

              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 18,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(153, 132, 75, 246),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  newShoeAchievement.displayName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    shadows: [
                      Shadow(color: Colors.black12, offset: Offset(2, 2)),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                "Purin's got one of your shoes, again....\nYou have surpassed a total focus time of: ",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 79, 51, 102),
                ),
              ),
              const SizedBox(height: 12),

              Text(
                PomTimerExtensions.formatDuration(
                  newShoeAchievement.secondsRequirement,
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Fredoka',
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color.fromARGB(255, 40, 54, 116),
                  shadows: [
                    Shadow(color: Colors.black12, offset: Offset(2, 2)),
                  ],
                ),
              ),

              const SizedBox(height: 12),
              Text(
                "...which made your yellow-furball companion starved for your attention!  ",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 79, 51, 102),
                ),
              ),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 65, 74, 109),
                    foregroundColor: Colors.white,
                    elevation: 8,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "It's in good paws! ... I hope...",
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
