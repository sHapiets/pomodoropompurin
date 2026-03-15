import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/shoe_achievement/shoe_achievement.dart';

class ShoeAchievementDialog extends StatelessWidget {
  const ShoeAchievementDialog({super.key, required this.newShoeAchievement});

  final ShoeAchievement newShoeAchievement;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxHeight: 450, minWidth: 300),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                const Text(
                  "NEW SHOE OR SUM SHZ!",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  "You have obtained a new shoe: ${newShoeAchievement.displayName}",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const SizedBox(height: 20),

            /// Close button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Awesome!"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
