import 'dart:math';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/dialog/script_dialog/script_manager.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/prog_system.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_equip_manager.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/ui/ui_display_state.dart';
import 'package:pomodoropompurin/scripts/foundation/acquirable.dart';
import 'package:pomodoropompurin/scripts/foundation/consumable.dart';
import 'package:pomodoropompurin/scripts/page/main_page.dart';

class KotatsuConsumableTile extends StatefulWidget {
  const KotatsuConsumableTile({
    super.key,
    required this.consumable,
    required this.amount,
  });

  final Consumable consumable;
  final int amount;

  @override
  State<KotatsuConsumableTile> createState() => _KotatsuConsumableTileState();
}

class _KotatsuConsumableTileState extends State<KotatsuConsumableTile>
    with TickerProviderStateMixin {
  final purinAreaEquipManager = PurinAreaEquipManager.singleton;
  final purinAreaStateManager = PurinAreaStateManager.singleton;
  final purin = Purin.singleton;
  final progSystem = ProgSystem.singleton;

  final double iconSides = 70;
  final double tileHeight = 135;
  final double tileWidth = 80;
  final double buttonHeight = 20;
  final double buttonWidth = 50;

  final equippedButtonTextStyle = const TextStyle(
    fontFamily: 'Fredoka',
    color: Color.fromARGB(172, 255, 255, 255),
  );

  final equipButtonTextStyle = const TextStyle(
    fontFamily: 'Fredoka',
    color: Color.fromARGB(255, 255, 255, 255),
  );

  final displayNameTextStyle = const TextStyle(
    fontFamily: 'Fredoka',
    fontWeight: FontWeight.w600,
    fontSize: 11,
    color: Color.fromARGB(255, 0, 0, 0),
  );

  final displayCountTextStyle = const TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Color.fromARGB(255, 0, 0, 0),
  );

  void placeConsumable() {
    purinAreaEquipManager.addFeedable(
      widget.consumable,
      widget.consumable.totalBites,
    );
    progSystem.useConsumable(widget.consumable, 1);
    purin.changePosition(PurinPosition.kotatsuLeft);
    purinAreaStateManager.jumpToPosition(
      purin.purinPositionVect2,
      Vector2(25, 0),
      1.8,
    );
  }

  late final AnimationController tileOnLoadAnimationController;
  late final Animation<double> tileOnLoadTween;

  late final AnimationController buttonAnimationController;
  late final Animation<double> buttonTween;
  bool showOccupiedButton = false;

  @override
  void initState() {
    super.initState();
    changeOccupiedButton();
    purinAreaEquipManager.feedableBitesLeft.addListener(changeOccupiedButton);

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

  void changeOccupiedButton() {
    (purinAreaEquipManager.feedableBitesLeft.value == 0)
        ? {showOccupiedButton = false}
        : {showOccupiedButton = true};
  }

  @override
  void dispose() {
    purinAreaEquipManager.feedableBitesLeft.removeListener(
      changeOccupiedButton,
    );
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
                child: Image.asset(widget.consumable.iconFlutterPath),
              ),
            ),

            /// Ingridient Name
            Align(
              alignment: AlignmentGeometry.topCenter,
              child: Transform.translate(
                offset: Offset(0, 70),
                child: SizedBox(
                  child: Text(
                    widget.consumable.displayName,
                    style: displayNameTextStyle,
                  ),
                ),
              ),
            ),

            /// ProcessConsumable Count
            Align(
              alignment: AlignmentGeometry.topLeft,
              child: Transform.translate(
                offset: Offset(8, 5),
                child: SizedBox(
                  child: Text(
                    "${progSystem.consumableInventory[widget.consumable]!.value}",
                    style: displayCountTextStyle,
                  ),
                ),
              ),
            ),

            Align(
              alignment: AlignmentGeometry.bottomCenter,
              child: Transform.translate(
                offset: Offset(0, -5),
                child: ValueListenableBuilder(
                  valueListenable: purinAreaEquipManager.feedableBitesLeft,
                  builder: (context, value, child) {
                    return AnimatedBuilder(
                      animation: buttonTween,
                      builder: (context, child) {
                        return (showOccupiedButton)
                            ? child!
                            : ScaleTransition(scale: buttonTween, child: child);
                      },
                      child: Container(
                        width: buttonWidth,
                        height: buttonHeight,
                        decoration: BoxDecoration(
                          color: (showOccupiedButton)
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
                            if (showOccupiedButton) {
                              return;
                            }
                            placeConsumable();
                            UIDisplayState.singleton.hide.value = false;
                            purinAreaKey.currentState!.currentGame.overlays
                                .removeAll(
                                  purinAreaKey
                                      .currentState!
                                      .currentGame
                                      .overlays
                                      .activeOverlays,
                                );
                            ScriptManager.singleton.removeAllDialogs();
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
                          valueListenable:
                              purinAreaEquipManager.feedableBitesLeft,
                          builder: (context, value, child) {
                            return Text(
                              (showOccupiedButton) ? "OCCUPIED" : "PLACE",
                              style: (showOccupiedButton)
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
