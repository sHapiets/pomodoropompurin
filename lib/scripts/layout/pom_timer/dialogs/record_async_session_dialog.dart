import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/memory/asset_manager.dart';

class RecordAsyncSessionDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final int timeTotalSeconds;

  final assetManager = AssetManager.singleton;

  RecordAsyncSessionDialog({
    Key? key,
    required this.timeTotalSeconds,
    required this.onConfirm,
    required this.onCancel,
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
    return Dialog(
      backgroundColor: Colors.transparent,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(26),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 69, 69, 69),
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 182, 103, 77).withOpacity(0.3),
                blurRadius: 25,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Koupen icon
              Container(
                height: 200,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 226, 226, 226),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  assetManager.flutterAssetPaths['detective_koupen_icon']!,
                ),
              ),

              const SizedBox(height: 18),

              // Title
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(
                        255,
                        214,
                        214,
                        214,
                      ).withOpacity(0.3),
                      offset: const Offset(3, 3),
                    ),
                  ],
                ),
                child: const Text(
                  "- INSTANT RECORD -",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 65, 65, 65),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Message
              const Text(
                "You are now attempting to log a focus session\nwithout using the PomTimer...",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                "But don't worry, Koupen always trusts you!\nKoupen-chan just likes to play detective sometimes.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                "You really did your best, right?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              // Soft info box
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(153, 225, 225, 225),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Focus Time: ${_formatTime(timeTotalSeconds)}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 60, 60, 60),
                  ),
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                "Standard rewards will be granted",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 28),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onCancel();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          201,
                          100,
                          100,
                        ),
                        foregroundColor: const Color.fromARGB(255, 45, 45, 45),
                        elevation: 4,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        "I-I misclicked...",
                        style: TextStyle(
                          fontFamily: 'Fredoka',
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onConfirm();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          215,
                          215,
                          215,
                        ),
                        foregroundColor: Colors.black,
                        elevation: 8,
                        shadowColor: const Color.fromARGB(
                          255,
                          101,
                          83,
                          94,
                        ).withOpacity(0.5),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        "I did my best!",
                        style: TextStyle(
                          fontFamily: 'Fredoka',
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
