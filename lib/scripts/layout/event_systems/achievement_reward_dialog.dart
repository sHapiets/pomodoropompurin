import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pomodoropompurin/scripts/memory/asset_manager.dart';

class AchievementRewardDialog extends StatelessWidget {
  final int pomPoints;
  final int oshiriPoints;
  final VoidCallback onClose;

  final assetManager = AssetManager.singleton;

  AchievementRewardDialog({
    super.key,
    required this.pomPoints,
    required this.oshiriPoints,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Center(
        child: Container(
          width: 250,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(0, 180, 184, 179),
            borderRadius: BorderRadius.circular(24),
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 18),

              /// REWARD BOX (reused style)
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 18,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(153, 161, 246, 75),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    /// PomPoints
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '+ ${NumberFormat('#,##0').format(pomPoints)}  ',
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

                        SizedBox(
                          height: 28,
                          width: 28,
                          child: Image.asset(
                            assetManager.flutterAssetPaths['pP_icon']!,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    /// OshiriPoints
                    Text(
                      "+ $oshiriPoints  *",
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
                  ],
                ),
              ),

              const SizedBox(height: 22),

              /// BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onClose,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    foregroundColor: Colors.white,
                    elevation: 6,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    "Nice!",
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
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
