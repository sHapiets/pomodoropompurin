import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/kitchen/kitchen_processor.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/prog_system.dart';
import 'package:pomodoropompurin/scripts/foundation/consumable.dart';
import 'package:pomodoropompurin/scripts/foundation/snack.dart';
import 'package:pomodoropompurin/scripts/layout/menu/kitchen/consumable_tile.dart';
import 'package:pomodoropompurin/scripts/layout/menu/kitchen/ingridient_tile.dart';
import 'package:pomodoropompurin/scripts/layout/menu/kotatsu/kotatsu_consumable_tile.dart';
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
        child: Container(
          width: menuWidth,
          height: menuHeight,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color.fromARGB(223, 255, 255, 255),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),

          child: Column(
            children: [
              /// HEADER
              Row(
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color.fromARGB(255, 225, 168, 53),
                    ),
                    child: Icon(
                      Icons.fastfood_rounded,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'snacks',
                      style: const TextStyle(
                        fontFamily: 'Fredoka',
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                        color: Color.fromARGB(255, 42, 42, 42),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              /// GRID AREA
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
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
    );
  }
}
