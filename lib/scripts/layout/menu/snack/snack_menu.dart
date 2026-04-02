import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/prog_system.dart';
import 'package:pomodoropompurin/scripts/foundation/snack.dart';
import 'package:pomodoropompurin/scripts/layout/menu/snack/snack_tile.dart';

class SnackMenu extends StatelessWidget {
  const SnackMenu({super.key});
  @override
  Widget build(BuildContext context) {
    const double menuWidth = 260;
    const double menuHeight = 320;

    final progSystem = ProgSystem.singleton;
    final Map<Snack, int> acquiredSnacks = {};

    for (final snackEntry in progSystem.snacksInventory.entries) {
      final snackAmount = snackEntry.value.value;
      if (snackAmount == 0) {
        continue;
      }

      acquiredSnacks.addAll({snackEntry.key: snackAmount});
    }

    return Center(
      child: Transform.translate(
        offset: Offset(50, -50),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Container(
            width: menuWidth,
            height: menuHeight,
            padding: const EdgeInsets.all(14),
            color: Colors.transparent,

            child: Column(
              children: [
                _header(
                  "snacks",
                  Icons.fastfood_rounded,
                  const Color.fromARGB(255, 225, 168, 53),
                ),
                const SizedBox(height: 14),

                /// GRID AREA
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(185, 255, 193, 7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: acquiredSnacks.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 2,
                          ),
                      itemBuilder: (context, index) {
                        final snack = acquiredSnacks.keys.toList()[index];
                        return SnackTile(snack: snack);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(String menuTitle, IconData menuIcon, Color menuColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: menuColor.withOpacity(0.2).darken(0.3),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(spreadRadius: 4, color: menuColor.withOpacity(0.2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(shape: BoxShape.circle, color: menuColor),
            child: Icon(menuIcon, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              menuTitle,
              style: const TextStyle(
                fontFamily: 'Fredoka',
                fontWeight: FontWeight.w600,
                fontSize: 21,
                color: Colors.white,
                shadows: [Shadow(color: Colors.black38, offset: Offset(2, 2))],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
