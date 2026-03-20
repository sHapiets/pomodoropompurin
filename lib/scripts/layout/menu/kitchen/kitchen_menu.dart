import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/kitchen/kitchen_processor.dart';
import 'package:pomodoropompurin/scripts/layout/menu/kitchen/consumable_icon.dart';
import 'package:pomodoropompurin/scripts/layout/menu/kitchen/consumable_tile.dart';
import 'package:pomodoropompurin/scripts/layout/menu/kitchen/ingridient_icon.dart';
import 'package:pomodoropompurin/scripts/layout/menu/kitchen/ingridient_tile.dart';

class KitchenMenu extends StatefulWidget {
  const KitchenMenu({super.key, required this.kitchenProcessor});

  final KitchenProcessor kitchenProcessor;

  static const double menuWidth = 290;
  static const double menuHeight = 400;

  @override
  State<KitchenMenu> createState() => _KitchenMenuState();
}

class _KitchenMenuState extends State<KitchenMenu> {
  bool showIngredients = true;

  @override
  Widget build(BuildContext context) {
    final consumables = widget.kitchenProcessor.consumableIngridients;
    final ingridients = widget.kitchenProcessor.ingridientIngridients;

    return Center(
      child: Transform.translate(
        offset: const Offset(0, -80),
        child: Container(
          width: KitchenMenu.menuWidth,
          height: KitchenMenu.menuHeight,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color.fromARGB(0, 255, 255, 255),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              /// HEADER
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                decoration: BoxDecoration(
                  color: widget.kitchenProcessor.processColor
                      .brighten(0.3)
                      .withAlpha(120),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: widget.kitchenProcessor.processColor
                          .darken(0.3)
                          .withAlpha(120),
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        widget.kitchenProcessor.processIcon,
                        color: widget.kitchenProcessor.processColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        widget.kitchenProcessor.displayName,
                        style: const TextStyle(
                          fontFamily: 'Fredoka',
                          fontWeight: FontWeight.w600,
                          fontSize: 25,
                          color: Colors.white,
                          shadows: [
                            Shadow(color: Colors.black38, offset: Offset(2, 2)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 6),

              /// GRID AREA WITH ANIMATION
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: widget.kitchenProcessor.processColor.brighten(0.5),
                    boxShadow: [
                      BoxShadow(
                        color: widget.kitchenProcessor.processColor,
                        offset: const Offset(6, 6),
                      ),
                    ],
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(
                          scale: Tween<double>(
                            begin: 0.95,
                            end: 1,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: GridView.builder(
                      key: ValueKey(showIngredients),
                      itemCount: (showIngredients)
                          ? ingridients.length
                          : consumables.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.55,
                          ),
                      itemBuilder: (context, index) {
                        if (showIngredients) {
                          return IngridientTile(
                            ingridient: ingridients.keys.toList()[index],
                            ingridientIngridients: ingridients.values
                                .toList()[index],
                            processorIcon: widget.kitchenProcessor.processIcon,
                            processorColor:
                                widget.kitchenProcessor.processColor,
                          );
                        } else {
                          return ConsumableTile(
                            consumable: consumables.keys.toList()[index],
                            ingridientIngridients: consumables.values
                                .toList()[index],
                            processorIcon: widget.kitchenProcessor.processIcon,
                            processorColor:
                                widget.kitchenProcessor.processColor,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              /// TAB SWITCHER
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: widget.kitchenProcessor.processColor,
                  boxShadow: [
                    BoxShadow(color: Colors.black12, offset: Offset(3, 3)),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildTab(
                      ingridientIcon,
                      "Ingredients",
                      showIngredients,
                      () {
                        setState(() => showIngredients = true);
                      },
                    ),
                    _buildTab(
                      consumableIcon,
                      "Consumables",
                      !showIngredients,
                      () {
                        setState(() => showIngredients = false);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(
    Widget icon,
    String label,
    bool isActive,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.white24,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isActive
              ? [const BoxShadow(color: Colors.black26, offset: Offset(2, 2))]
              : [],
        ),
        child: Row(
          spacing: 6,
          children: [
            icon,
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Fredoka',
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: isActive ? Colors.black : Colors.black38,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
