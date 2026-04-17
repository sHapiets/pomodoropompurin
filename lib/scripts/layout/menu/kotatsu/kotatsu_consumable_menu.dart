import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/kitchen/kitchen_processor.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/prog_system.dart';
import 'package:pomodoropompurin/scripts/foundation/consumable.dart';
import 'package:pomodoropompurin/scripts/layout/menu/kitchen/consumable_tile.dart';
import 'package:pomodoropompurin/scripts/layout/menu/kitchen/ingridient_tile.dart';
import 'package:pomodoropompurin/scripts/layout/menu/kotatsu/kotatsu_consumable_tile.dart';

class KotatsuConsumableMenu extends StatelessWidget {
  const KotatsuConsumableMenu({super.key});

  @override
  Widget build(BuildContext context) {
    const double menuWidth = 260;
    const double menuHeight = 320;

    final progSystem = ProgSystem.singleton;
    final Map<Consumable, int> acquiredConsumables = {};

    for (final consumableEntry in progSystem.consumableInventory.entries) {
      final amount = consumableEntry.value.value;
      if (amount == 0) continue;

      acquiredConsumables[consumableEntry.key] = amount;
    }

    return Center(
      child: Transform.translate(
        offset: const Offset(0, -80),
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
                  "consumables",
                  Icons.restaurant,
                  const Color.fromARGB(255, 176, 225, 53),
                ),
                const SizedBox(height: 14),

                /// GRID AREA
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(185, 176, 225, 53),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: acquiredConsumables.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 2,
                          ),
                      itemBuilder: (context, index) {
                        final consumable = acquiredConsumables.keys
                            .toList()[index];
                        final amount = acquiredConsumables.values
                            .toList()[index];

                        return KotatsuConsumableTile(
                          consumable: consumable,
                          amount: amount,
                        );
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

  Widget _header(String title, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2).darken(0.3),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(spreadRadius: 4, color: color.withOpacity(0.2))],
      ),
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            child: Icon(icon, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
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
