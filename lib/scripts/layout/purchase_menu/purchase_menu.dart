import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/foundation/ingridient.dart';
import 'package:pomodoropompurin/scripts/layout/purchase_menu/purchase_tile.dart';
import 'package:pomodoropompurin/scripts/page/main_page.dart';

class PurchaseMenu extends StatelessWidget {
  const PurchaseMenu({super.key});

  @override
  Widget build(BuildContext context) {
    const double menuWidth = 320;
    const double menuHeight = 520;

    return Material(
      color: Colors.black45, // dimmed background
      child: Center(
        child: Container(
          width: menuWidth,
          height: menuHeight,
          decoration: BoxDecoration(
            color: const Color(0xFFE0F7FA), // light cyan
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(138, 0, 150, 167),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: Stack(
            children: [
              /// HEADER
              Positioned(
                top: 18,
                left: 24,
                child: Text(
                  'grocery',
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontWeight: FontWeight.w600,
                    fontSize: 28,
                    color: const Color(0xFF006064), // dark teal
                  ),
                ),
              ),

              /// CLOSE BUTTON
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  onPressed: () {
                    purinAreaKey.currentState!.currentGame.overlays.removeAll(
                      purinAreaKey
                          .currentState!
                          .currentGame
                          .overlays
                          .activeOverlays,
                    );
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Color(0xFF006064),
                    size: 26,
                  ),
                ),
              ),

              /// GRID AREA
              Positioned.fill(
                top: 70,
                bottom: 20,
                left: 20,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB2EBF2), // soft aqua panel
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: GridView.builder(
                    itemCount: Ingridient.values.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.85,
                        ),
                    itemBuilder: (context, index) {
                      return PurchaseTile(ingridient: Ingridient.values[index]);
                    },
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
