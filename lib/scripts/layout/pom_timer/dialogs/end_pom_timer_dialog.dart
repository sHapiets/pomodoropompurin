import 'package:flutter/material.dart';

class EndPomTimerDialog extends StatelessWidget {
  final int seconds;
  final int pomPoints;
  final int oshiriPoints;
  final VoidCallback onClose;

  const EndPomTimerDialog({
    Key? key,
    required this.seconds,
    required this.pomPoints,
    required this.oshiriPoints,
    required this.onClose,
  }) : super(key: key);

  String _formatTime(int totalSeconds) {
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final secs = totalSeconds % 60;

    String twoDigits(int n) => n.toString().padLeft(2, '0');

    if (hours > 0) {
      return "${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(secs)}";
    } else {
      return "${twoDigits(minutes)}:${twoDigits(secs)}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedTime = _formatTime(seconds);

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(26),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF3B0), // pudding yellow
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
            // Celebration emoji bubble
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFFFFE08A),
                shape: BoxShape.circle,
              ),
              child: const Text("🎉", style: TextStyle(fontSize: 40)),
            ),

            const SizedBox(height: 18),

            const Text(
              "Session Complete!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Color(0xFF6D4C41),
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              "Nothing beats a good cooking session!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFF8D6E63),
              ),
            ),

            const SizedBox(height: 20),

            // Time Display
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFD166),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                "Focus Time: $formattedTime",
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF5D4037),
                ),
              ),
            ),

            const SizedBox(height: 12),
            // Points Display
            Column(
              children: [
                Text(
                  "+ $pomPoints Pom Points",
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF6D4C41),
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "+ $oshiriPoints Oshiri Points",
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF8D6E63),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // Close Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onClose,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6D4C41),
                  foregroundColor: Colors.white,
                  elevation: 8,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Alright!",
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
