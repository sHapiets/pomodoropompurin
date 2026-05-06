import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/prog_system.dart';
import 'package:pomodoropompurin/scripts/foundation/ingridient.dart';
import 'package:pomodoropompurin/scripts/memory/asset_manager.dart';

class PurchaseTile extends StatelessWidget {
  const PurchaseTile({
    super.key,
    required this.ingridient,
    required this.onTap,
  });

  final Ingridient ingridient;
  final VoidCallback onTap;

  final double iconSize = 60;
  final double buttonSize = 45;

  final displayCountTextStyle = const TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Color.fromARGB(255, 0, 0, 0),
  );

  @override
  Widget build(BuildContext context) {
    final assetManager = AssetManager.singleton;
    final progSystem = ProgSystem.singleton;

    final bool insufficient = progSystem.pomPoints.value < ingridient.price;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: const Color.fromARGB(126, 255, 255, 255),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// ICON
            SizedBox(
              width: iconSize - 22,
              height: iconSize - 22,
              child: Stack(
                children: [
                  Image.asset(ingridient.spriteFlutterPath),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Transform.translate(
                      offset: const Offset(-10, -5),
                      child: Text(
                        "${progSystem.ingridientInventory[ingridient]!.value}",
                        style: displayCountTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 4),

            /// PRICE (compact)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                  width: 10,
                  child: Image.asset(
                    assetManager.flutterAssetPaths['pP_icon']!,
                  ),
                ),
                const SizedBox(width: 2),
                Text(
                  '${ingridient.price}',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: insufficient ? Colors.red : Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
