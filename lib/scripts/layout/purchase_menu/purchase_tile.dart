import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/prog_system.dart';
import 'package:pomodoropompurin/scripts/foundation/ingridient.dart';
import 'package:pomodoropompurin/scripts/memory/asset_manager.dart';

class PurchaseTile extends StatelessWidget {
  const PurchaseTile({
    super.key,
    required this.ingridient,
    required this.onTap,
    required this.purchasable,
  });

  final Ingridient ingridient;
  final VoidCallback onTap;
  final bool purchasable;

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
      onTap: purchasable ? onTap : () {},
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: purchasable
              ? const Color.fromARGB(126, 255, 255, 255)
              : const Color.fromARGB(125, 132, 132, 132),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// ICON
            Container(
              width: iconSize - 20,
              height: iconSize - 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: purchasable ? Colors.white : Colors.grey,
              ),
              padding: EdgeInsets.all(4),
              child: Stack(
                children: [
                  Image.asset(ingridient.spriteFlutterPath),
                  ValueListenableBuilder(
                    valueListenable:
                        progSystem.ingridientInventory[ingridient]!,
                    builder: (context, value, child) => Align(
                      alignment: Alignment.topLeft,
                      child: Transform.translate(
                        offset: const Offset(-10, -5),
                        child: Text(
                          "${progSystem.ingridientInventory[ingridient]!.value}",
                          style: displayCountTextStyle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 4),

            /// PRICE (compact)
            purchasable
                ? Row(
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
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                        width: 10,
                        child: Icon(Icons.lock, size: 10, color: Colors.white),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        'Locked',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
