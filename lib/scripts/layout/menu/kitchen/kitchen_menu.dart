import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/kitchen/kitchen_processor.dart';
import 'package:pomodoropompurin/scripts/layout/menu/kitchen/consumable_tile.dart';
import 'package:pomodoropompurin/scripts/layout/menu/kitchen/ingridient_tile.dart';

class KitchenMenu extends StatelessWidget {
  const KitchenMenu({super.key, required this.kitchenProcessor});

  final KitchenProcessor kitchenProcessor;

  static const double menuWidth = 260;
  static const double menuHeight = 320;

  @override
  Widget build(BuildContext context) {
    final consumables = kitchenProcessor.consumableIngridients.entries.toList();
    final ingridients = kitchenProcessor.ingridientIngridients.entries.toList();

    return Center(
      child: Transform.translate(
        offset: Offset(0, -80),
        child: Container(
          width: menuWidth,
          height: menuHeight,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color.fromARGB(228, 255, 255, 255),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              /// HEADER
              Row(
                children: [
                  Icon(
                    kitchenProcessor.processIcon,
                    color: kitchenProcessor.processColor,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      kitchenProcessor.displayName,
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
                    color: kitchenProcessor.processColor.brighten(0.5),
                  ),
                  child: GridView.builder(
                    itemCount: consumables.length + ingridients.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.5,
                        ),
                    itemBuilder: (context, index) {
                      if (index < consumables.length) {
                        final entry = consumables[index];
                        return ConsumableTile(
                          consumable: entry.key,
                          ingridientIngridients: entry.value,
                          processorIcon: kitchenProcessor.processIcon,
                          processorColor: kitchenProcessor.processColor,
                        );
                      } else {
                        final adjustedIndex = index - consumables.length;
                        final entry = ingridients[adjustedIndex];
                        return IngridientTile(
                          ingridient: entry.key,
                          ingridientIngridients: entry.value,
                          processorIcon: kitchenProcessor.processIcon,
                          processorColor: kitchenProcessor.processColor,
                        );
                      }
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
