import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pomodoropompurin/scripts/memory/asset_manager.dart';

class EndPomTimerDialog extends StatelessWidget {
  final int seconds;
  final int pomPoints;
  final int oshiriPoints;
  final VoidCallback onClose;

  final assetManager = AssetManager.singleton;

  EndPomTimerDialog({
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
      child: FittedBox(
        fit: BoxFit.contain,
        child: Container(
          width: 400,
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
              Container(
                height: 200,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFE08A),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  assetManager.flutterAssetPaths['pumped_purin_icon']!,
                ),
              ),

              const SizedBox(height: 18),

              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6D4C41).withOpacity(0.3),
                      offset: const Offset(3, 3),
                    ),
                  ],
                ),
                child: const Text(
                  "- SESSION ENDED -",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF6D4C41),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                "Nothing beats a productive session!\nTake a short break with Purin. You've earned it!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF8D6E63),
                ),
              ),

              const SizedBox(height: 28),

              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 18,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(153, 246, 178, 75),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Time Display
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFD166),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF6D4C41).withOpacity(0.3),
                            offset: const Offset(3, 3),
                          ),
                        ],
                      ),
                      child: Text(
                        "Focus Time: $formattedTime",
                        style: const TextStyle(
                          fontFamily: 'Fredoka',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF5D4037),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),
                    // Points Display
                    Column(
                      children: [
                        /// PomPoints
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '+ ${NumberFormat('#,##0', 'en_US').format(pomPoints)}  ',
                              style: const TextStyle(
                                fontFamily: 'Fredoka',
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    color: Colors.black12,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: Image.asset(
                                  assetManager.flutterAssetPaths['pP_icon']!,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 6),

                        Text(
                          "+ $oshiriPoints  *",
                          style: const TextStyle(
                            fontFamily: 'Fredoka',
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black12,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
