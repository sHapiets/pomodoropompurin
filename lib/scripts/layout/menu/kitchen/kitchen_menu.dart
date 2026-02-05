import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/kitchen/kitchen_processor.dart';
import 'package:pomodoropompurin/scripts/core/kitchen/stove.dart';
import 'package:pomodoropompurin/scripts/foundation/consumable.dart';
import 'package:pomodoropompurin/scripts/foundation/ingridient.dart';
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
  KitchenMenu({super.key, required this.kitchenProcessor});

  final KitchenProcessor kitchenProcessor;

  final double menuWidth = 250;
  final double menuHeight = 300;
  final double gridHeight = 240;

  final double showButtonSides = 30;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.translate(
        offset: Offset(0, -50),
        child: Container(
          width: menuWidth,
          height: menuHeight,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(209, 255, 255, 255),
          ),

          child: Stack(
            children: [
              Align(
                alignment: AlignmentGeometry.topLeft,
                child: Transform.translate(
                  offset: Offset(30, 0),
                  child: Text(
                    kitchenProcessor.displayName,
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                      color: const Color.fromARGB(255, 42, 42, 42),
                      shadows: [
                        Shadow(
                          color: const Color.fromARGB(0, 0, 0, 0),
                          offset: Offset(1.5, 1.5),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentGeometry.topLeft,
                child: Transform.translate(
                  offset: Offset(0, 5),
                  child: Icon(
                    kitchenProcessor.processIcon,
                    color: kitchenProcessor.processColor,
                  ),
                ),
              ),

              Align(
                alignment: AlignmentGeometry.bottomCenter,
                child: Container(
                  height: gridHeight,
                  width: menuWidth,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(135, 207, 207, 207),
                  ),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.6,
                        ),
                    itemBuilder: (context, index) {
                      return IngridientTile(
                        ingridient: kitchenProcessor.ingridientIngridients.keys
                            .toList()[index],
                        ingridientIngridients: kitchenProcessor
                            .ingridientIngridients
                            .values
                            .toList()[index],
                        processorIcon: kitchenProcessor.processIcon,
                        processorColor: kitchenProcessor.processColor,
                      );
                    },
                    itemCount: kitchenProcessor.ingridientIngridients.length,
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
