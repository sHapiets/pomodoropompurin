import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/prog_system.dart';
import 'package:pomodoropompurin/scripts/core/ui/ui_display_state.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/level_up/unlocks_from_level.dart';
import 'package:pomodoropompurin/scripts/foundation/ingridient.dart';
import 'package:pomodoropompurin/scripts/layout/purchase_menu/purchase_panel.dart';
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
    const double menuWidth = 300;
    const double menuHeight = 520;

    final purchasableList = getPurchasableList();

    return Center(
      child: Container(
        width: menuWidth,
        height: menuHeight,
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
        decoration: BoxDecoration(
          color: const Color.fromARGB(0, 224, 247, 250),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          children: [
            /// HEADER + CURRENCY ROW
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(214, 163, 201, 199),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(color: Colors.black12, offset: Offset(3, 3)),
                ],
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// HEADER
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 91, 147, 185),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.receipt_long_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'grocery',
                        style: TextStyle(
                          fontFamily: 'Fredoka',
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: Colors.white,
                          shadows: [
                            Shadow(color: Colors.black45, offset: Offset(2, 2)),
                          ],
                        ),
                      ),
                    ],
                  ),

                  /// CURRENCY DISPLAY
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(3, 3),
                              ),
                            ],
                          ),
                          height: 24,
                          width: 24,
                          child: Image.asset(
                            assetManager.flutterAssetPaths['pP_icon']!,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(0, 200, 107, 53),
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
                ],
              ),
            ),

            const SizedBox(height: 8),

            /// GRID AREA
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFB2EBF2),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 123, 161, 167),
                      offset: Offset(5, 5),
                    ),
                  ],
                ),
                child: CustomScrollView(
                  slivers: [
                    for (final type in IngridientType.values) ...[
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 3,
                              vertical: 3,
                            ),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 1,
                            ),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(134, 91, 147, 185),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(type.icon, color: Colors.white),
                                SizedBox(width: 5),
                                Text(
                                  type.displayName,
                                  style: const TextStyle(
                                    fontFamily: 'Fredoka',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black26,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SliverPadding(
                        padding: EdgeInsetsGeometry.only(bottom: 15),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final ing = purchasableList
                                  .where((i) => i.type == type)
                                  .toList()[index];

                              return PurchaseTile(
                                ingridient: ing,
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => PurchasePanel(
                                      ingridient: ing,
                                      onReturn: () => Navigator.pop(context),
                                    ),
                                  );
                                },
                              );
                            },
                            childCount: purchasableList
                                .where((i) => i.type == type)
                                .length,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 1,
                              ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
