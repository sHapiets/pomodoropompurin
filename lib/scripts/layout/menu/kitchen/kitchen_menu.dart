import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/kitchen/kitchen_processor.dart';
import 'package:pomodoropompurin/scripts/core/kitchen/stove.dart';
import 'package:pomodoropompurin/scripts/layout/menu/kitchen/ingridient_tile.dart';

/// A menu for all KitchenProcessors for creating Ingridients or Consumables.
///
/// An instance of this menu is created whenever a [KitchenProcessor] selectable
/// calls OnLongTapDown(), (e.g [StoveEntity]).
/// To construct this menu, a [KitchenProcessors] enum value must be passed to know
/// which processor is being selected.
/// It contains a grid view of [IngridientTile]'s and [ConsumableTile]'s, that matches
/// the [KitchenProcessor]'s parameters.
///
/// I suggest taking a look at [KitchenProcessor] to see how the processor logic is defined
class KitchenMenu extends StatelessWidget {
  const KitchenMenu({super.key, required this.kitchenProcessorType});

  final KitchenProcessors kitchenProcessorType;

  final double menuWidth = 200;
  final double menuHeight = 250;

  KitchenProcessor get kitchenProcessor {
    switch (kitchenProcessorType) {
      case KitchenProcessors.stove:
        return Stove.singleton;
      default:
        return Stove.singleton;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.translate(
        offset: Offset(50, -50),
        child: Container(
          width: menuWidth,
          height: menuHeight,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(91, 255, 255, 255),
          ),

          child: Stack(
            children: [
              Positioned(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1.0,
                  ),
                  itemBuilder: (context, index) {
                    return IngridientTile(
                      ingridient: kitchenProcessor.ingridientIngridients.keys
                          .toList()[index],
                      ingridientIngridients: kitchenProcessor
                          .ingridientIngridients
                          .values
                          .toList()[index],
                    );
                  },
                  itemCount: kitchenProcessor.ingridientIngridients.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
