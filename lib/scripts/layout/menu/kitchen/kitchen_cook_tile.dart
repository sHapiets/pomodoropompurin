/* import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/prog_system.dart';
import 'package:pomodoropompurin/scripts/foundation/consumable.dart';

class KitchenCookTile extends StatefulWidget {
  const KitchenCookTile({super.key, required this.consumable});

  final Consumable consumable;

  @override
  State<KitchenCookTile> createState() => _KitchenCookTileState();
}

class _KitchenCookTileState extends State<KitchenCookTile>
    with TickerProviderStateMixin {
  final ingridientInventory = ProgSystem.singleton.ingridientInventory;

  final double iconSides = 70;
  final double tileHeight = 135;
  final double tileWidth = 80;
  final double buttonHeight = 20;
  final double buttonWidth = 50;

  final cookedButtonTextStyle = const TextStyle(
    fontFamily: 'Fredoka',
    color: Color.fromARGB(172, 255, 255, 255),
  );

  final cookButtonTextStyle = const TextStyle(
    fontFamily: 'Fredoka',
    color: Color.fromARGB(255, 255, 255, 255),
  );

  final displayNameTextStyle = const TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 10,
    color: Color.fromARGB(255, 0, 0, 0),
  );

  late final AnimationController tileOnLoadAnimationController;
  late final Animation<double> tileOnLoadTween;

  late final AnimationController buttonAnimationController;
  late final Animation<double> buttonTween;
  bool showButton = false;

  @override
  void initState() {
    super.initState();

    buttonAnimationController =
        AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 1200),
          )
          ..forward()
          ..repeat(reverse: true);
    buttonTween = Tween<double>(begin: 0.9, end: 1).animate(
      CurvedAnimation(
        parent: buttonAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    final int random = Random().nextInt(300);
    final randomDuration = Duration(milliseconds: (400 + random));
    tileOnLoadAnimationController = AnimationController(
      vsync: this,
      duration: randomDuration,
    )..forward();
    tileOnLoadTween = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: tileOnLoadAnimationController,
        curve: Curves.easeOutBack,
      ),
    );
  }

  void changeCookButton() {
    //
  }

  @override
  void dispose() {
    buttonAnimationController.dispose();
    tileOnLoadAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: tileOnLoadAnimationController,
      builder: (context, child) {
        return ScaleTransition(scale: tileOnLoadTween, child: child);
      },
      child: Container(
        width: tileWidth,
        height: tileHeight,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(4),
          boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(2, 2))],
        ),
        child: Stack(
          children: [
            Align(
              alignment: AlignmentGeometry.topCenter,
              child: Container(
                width: iconSides,
                height: iconSides,
                color: Colors.white,
              ),
            ),
            Align(
              alignment: AlignmentGeometry.topCenter,
              child: SizedBox(
                child: Text(
                  widget.consumable.displayName,
                  style: displayNameTextStyle,
                ),
              ),
            ),

            Align(
              alignment: AlignmentGeometry.bottomCenter,
              child: Transform.translate(
                offset: Offset(0, -5),
                child: ValueListenableBuilder(
                  valueListenable: purinAreaEquipManager.kotatsu,
                  builder: (context, value, child) {
                    return AnimatedBuilder(
                      animation: buttonTween,
                      builder: (context, child) {
                        return (showEquippedButton)
                            ? child!
                            : ScaleTransition(scale: buttonTween, child: child);
                      },
                      child: Container(
                        width: buttonWidth,
                        height: buttonHeight,
                        decoration: BoxDecoration(
                          color: (showEquippedButton)
                              ? const Color.fromARGB(141, 144, 167, 179)
                              : const Color.fromARGB(255, 105, 194, 15),
                          borderRadius: BorderRadius.circular(3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            purinAreaEquipManager.kotatsu.value = widget.item;
                            databaseManager.configKotatsuSave(widget.item.id);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            Align(
              alignment: AlignmentGeometry.bottomCenter,
              child: Transform.translate(
                offset: Offset(0, -5),
                child: IgnorePointer(
                  child: SizedBox(
                    width: buttonWidth - 20,
                    height: buttonHeight,
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: ValueListenableBuilder(
                          valueListenable: purinAreaEquipManager.kotatsu,
                          builder: (context, value, child) {
                            return Text(
                              (showEquippedButton) ? "EQUIPPED" : "EQUIP",
                              style: (showEquippedButton)
                                  ? equippedButtonTextStyle
                                  : equipButtonTextStyle,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 */
