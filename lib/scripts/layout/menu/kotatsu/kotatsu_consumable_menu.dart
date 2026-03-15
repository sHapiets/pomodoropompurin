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
      final consumableAmount = consumableEntry.value.value;
      if (consumableAmount == 0) {
        continue;
      }

      acquiredConsumables.addAll({consumableEntry.key: consumableAmount});
    }

    return Center(
      child: Transform.translate(
        offset: Offset(0, -80),
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
                      color: const Color.fromARGB(255, 176, 225, 53),
                    ),
                    child: Icon(
                      Icons.restaurant,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      size: 15,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'consumables',
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
                    itemCount: acquiredConsumables.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.8,
                        ),
                    itemBuilder: (context, index) {
                      final consumable = acquiredConsumables.keys
                          .toList()[index];
                      final amount = acquiredConsumables.values.toList()[index];
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
    );
  }
}
