import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/prog_system.dart';
import 'package:pomodoropompurin/scripts/core/ui/ui_display_state.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/level_up/unlocks_from_level.dart';
import 'package:pomodoropompurin/scripts/foundation/ingridient.dart';
import 'package:pomodoropompurin/scripts/layout/purchase_menu/purchase_tile.dart';
import 'package:pomodoropompurin/scripts/memory/asset_manager.dart';
import 'package:pomodoropompurin/scripts/page/main_page.dart';

class PurchaseMenu extends StatelessWidget {
  PurchaseMenu({super.key});

  final progSystem = ProgSystem.singleton;
  final assetManager = AssetManager.singleton;
  final oshiriLevel = ProgSystem.singleton.oshiriLevel.value;
  final unlockedPurchasableMap = UnlocksFromLevel.purchasableIngridients;

  List<Ingridient> getPurchasableList() {
    final List<Ingridient> purchasableList = [];

    for (final unlockedPurchaseEntry in unlockedPurchasableMap.entries) {
      if (unlockedPurchaseEntry.key > oshiriLevel) {
        continue;
      }

      purchasableList.addAll(unlockedPurchaseEntry.value);
    }

    return purchasableList;
  }

  @override
  Widget build(BuildContext context) {
    const double menuWidth = 320;
    const double menuHeight = 520;

    final purchasableList = getPurchasableList();

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
                    UIDisplayState.singleton.hide.value = false;
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

              /// CURRENCY DISPLAY
              Positioned(
                top: 24,
                right: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: GestureDetector(
                        onTap: () => progSystem.addOshiriPoints(100),
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: Image.asset(
                            assetManager.flutterAssetPaths['pP_icon']!,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(197, 200, 107, 53),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ValueListenableBuilder(
                        valueListenable: progSystem.pomPoints,
                        builder: (context, value, child) {
                          return Text(
                            NumberFormat(
                              '#,##0',
                              'en_US',
                            ).format(progSystem.pomPoints.value),
                            style: const TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black26,
                                  offset: Offset(1, 1),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
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
                    itemCount: purchasableList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.7,
                        ),
                    itemBuilder: (context, index) {
                      return PurchaseTile(ingridient: purchasableList[index]);
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
