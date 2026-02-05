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

  final ValueNotifier<String> showType = ValueNotifier("consumablesOnly");

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
            color: const Color.fromARGB(163, 255, 255, 255),
          ),

          child: ValueListenableBuilder(
            valueListenable: showType,
            builder: (context, value, child) {
              return Stack(
                children: [
                  Align(
                    alignment: AlignmentGeometry.topCenter,
                    child: Text(
                      kitchenProcessor.displayName,
                      style: TextStyle(
                        fontFamily: 'Fredoka',
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                        color: const Color.fromARGB(235, 53, 53, 53),
                        shadows: [
                          Shadow(
                            color: const Color.fromARGB(255, 94, 94, 94),
                            offset: Offset(1.5, 1.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentGeometry.topLeft,
                    child: AnimatedScale(
                      scale: (value == "ingridientsOnly") ? 1 : 0.5,
                      duration: Duration(milliseconds: 600),
                      curve: Curves.easeInOutBack,
                      child: GestureDetector(
                        onTapDown: (details) {
                          showType.value = "ingridientsOnly";
                        },
                        child: Container(
                          height: showButtonSides,
                          width: showButtonSides,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color.fromARGB(134, 108, 172, 255),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 58, 146, 255),
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.receipt_long_rounded,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Align(
                    alignment: AlignmentGeometry.topRight,
                    child: AnimatedScale(
                      scale: (value == "consumablesOnly") ? 1 : 0.5,
                      duration: Duration(milliseconds: 600),
                      curve: Curves.easeInOutBack,
                      child: GestureDetector(
                        onTapDown: (details) {
                          showType.value = "consumablesOnly";
                        },
                        child: Container(
                          height: showButtonSides,
                          width: showButtonSides,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color.fromARGB(159, 173, 213, 110),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 25, 197, 60),
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.restaurant,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentGeometry.bottomCenter,
                    child: SizedBox(
                      height: gridHeight,
                      width: menuWidth,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 0.6,
                            ),
                        itemBuilder: (context, index) {
                          if (value == "ingridientsOnly") {
                            return IngridientTile(
                              ingridient: kitchenProcessor
                                  .ingridientIngridients
                                  .keys
                                  .toList()[index],
                              ingridientIngridients: kitchenProcessor
                                  .ingridientIngridients
                                  .values
                                  .toList()[index],
                              processorIcon: kitchenProcessor.processIcon,
                            );
                          } else {}
                        },
                        itemCount: (value == "ingridientsOnly")
                            ? kitchenProcessor.ingridientIngridients.length
                            : 0,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
