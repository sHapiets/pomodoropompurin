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

  final double iconSize = 60;
  final double buttonSize = 45;
  final double tileHeight = 135;
  final double tileWidth = 80;
  final double buttonHeight = 20;
  final double buttonWidth = 50;

  late final AnimationController tileOnLoadController;
  late final Animation<double> tileScale;

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

  bool showOccupiedButton = false;

  @override
  void initState() {
    super.initState();
    changeOccupiedButton();
    purinAreaEquipManager.feedableBitesLeft.addListener(changeOccupiedButton);

    final random = Random().nextInt(300);
    tileOnLoadController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400 + random),
    )..forward();

    tileScale = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: tileOnLoadController, curve: Curves.easeOutBack),
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
    tileOnLoadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: tileScale,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(2, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            /// TOP ICON + PROGRESS
            SizedBox(
              height: iconSize,
              width: iconSize,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Transform.translate(
                    offset: const Offset(0, 5),
                    child: SizedBox(
                      width: iconSize,
                      height: iconSize,
                      child: Image.asset(widget.consumable.iconFlutterPath),
                    ),
                  ),

                  /// ProcessConsumable Count
                  ValueListenableBuilder(
                    valueListenable:
                        progSystem.consumableInventory[widget.consumable]!,
                    builder: (context, value, child) {
                      return Align(
                        alignment: AlignmentGeometry.topLeft,
                        child: Transform.translate(
                          offset: Offset(-20, -5),
                          child: SizedBox(
                            child: Text("$value", style: displayCountTextStyle),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            /// NAME
            Text(
              widget.consumable.displayName,
              textAlign: TextAlign.center,
              style: displayNameTextStyle,
            ),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "+ ${widget.consumable.oshiriPointsPerBite * widget.consumable.totalBites} *",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Fredoka',
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 3),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "+ ${widget.consumable.hungerPointsPerBite * widget.consumable.totalBites}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Fredoka',
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 3),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 184, 93, 84),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.restaurant_rounded,
                    color: Colors.white,
                    size: 15,
                    shadows: const [
                      Shadow(color: Colors.black26, offset: Offset(2, 2)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 3),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "+ ${widget.consumable.energyPointsPerBite * widget.consumable.totalBites}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Fredoka',
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 3),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 49, 141, 151),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.bolt_rounded,
                    color: Colors.white,
                    size: 15,
                    shadows: const [
                      Shadow(color: Colors.black26, offset: Offset(2, 2)),
                    ],
                  ),
                ),
              ],
            ),

            const Spacer(),

            ValueListenableBuilder(
              valueListenable: purinAreaEquipManager.feedableBitesLeft,
              builder: (context, value, child) {
                return Container(
                  width: buttonWidth,
                  height: buttonHeight,
                  decoration: BoxDecoration(
                    color: (showOccupiedButton)
                        ? const Color.fromARGB(141, 144, 167, 179)
                        : const Color.fromARGB(255, 105, 194, 15),
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, offset: Offset(2, 2)),
                    ],
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      if (showOccupiedButton) {
                        return;
                      }
                      placeConsumable();
                      UIDisplayState.singleton.hide.value = false;
                      purinAreaKey.currentState!.currentGame.overlays.removeAll(
                        purinAreaKey
                            .currentState!
                            .currentGame
                            .overlays
                            .activeOverlays,
                      );
                      ScriptManager.singleton.removeAllDialogs();
                    },
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        (showOccupiedButton) ? "OCCUPIED" : "PLACE",
                        style: (showOccupiedButton)
                            ? equippedButtonTextStyle
                            : equipButtonTextStyle,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
