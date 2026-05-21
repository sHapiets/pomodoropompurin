import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/event_systems/misc/sanrio_2026_voting.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/purin_var/purin_var.dart';

class Sanrio2026RewardDialog extends StatelessWidget {
  final PurinVar unlockedPurinVar = PurinVar.cheer;

  const Sanrio2026RewardDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Container(
          width: 390,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 244, 228),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: const Color.fromARGB(255, 255, 168, 130),
              width: 4,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFFD08A).withOpacity(0.45),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // --------------------------------------------------
              // Icon Circle
              // --------------------------------------------------
              Container(
                height: 190,
                width: 190,
                padding: const EdgeInsets.all(18),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  unlockedPurinVar.iconAssetPath,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 20),

              // --------------------------------------------------
              // Header
              // --------------------------------------------------
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFAF3),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFD59B).withOpacity(0.55),
                      offset: const Offset(3, 3),
                    ),
                  ],
                ),

                child: const Text(
                  "- NEW PURIN UNLOCKED! -",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontWeight: FontWeight.w900,
                    fontSize: 21,
                    color: Color(0xFF6D4C41),
                  ),
                ),
              ),

              const SizedBox(height: 26),

              // --------------------------------------------------
              // Name
              // --------------------------------------------------
              Text(
                unlockedPurinVar.displayName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Fredoka',
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF6D4C41),
                ),
              ),

              const SizedBox(height: 15),

              Container(
                height: 60,
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFF7FB),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "${Sanrio2026Voting.singleton.votes.value} / 5",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF8D6E63),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // --------------------------------------------------
              // Flavor text
              // --------------------------------------------------
              const Text(
                "Thank you for your votes!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF8D6E63),
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Getting your support means just as much as winning the race! The voting might not be "
                "over yet, so let's keep it up until Sunday!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF8D6E63),
                  height: 1.45,
                ),
              ),

              const SizedBox(height: 28),

              // --------------------------------------------------
              // Confirm button
              // --------------------------------------------------
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 179, 120),
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shadowColor: const Color(0xFFFFD18F),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),

                  child: const Text(
                    "Yay!!",
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
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
