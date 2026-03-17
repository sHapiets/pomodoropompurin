import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/acquirables.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin.dart';
import 'package:pomodoropompurin/scripts/foundation/acquirable.dart';

class PurinEquipTile extends StatefulWidget {
  const PurinEquipTile({super.key, required this.purinVar});

  final PurinVar purinVar;

  @override
  State<PurinEquipTile> createState() => _PurinEquipTileState();
}

class _PurinEquipTileState extends State<PurinEquipTile>
    with TickerProviderStateMixin {
  final purin = Purin.singleton;

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
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Color.fromARGB(255, 0, 0, 0),
  );

  late final AnimationController tileOnLoadAnimationController;
  late final Animation<double> tileOnLoadTween;

  late final AnimationController buttonAnimationController;
  late final Animation<double> buttonTween;
  ValueNotifier<bool> showEquippedButton = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    changeEquipButton();
    purin.addListener(changeEquipButton);

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

  void changeEquipButton() {
    (purin.equipManager.equippedPurinVar == widget.purinVar)
        ? {showEquippedButton.value = true}
        : {showEquippedButton.value = false};
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
              child: Transform.translate(
                offset: const Offset(0, 10),
                child: SizedBox(
                  width: iconSides,
                  height: iconSides,
                  child: Image.asset(widget.purinVar.iconAssetPath),
                ),
              ),
            ),
            Align(
              alignment: AlignmentGeometry.center,
              child: Transform.translate(
                offset: const Offset(0, 25),
                child: SizedBox(
                  child: Text(
                    widget.purinVar.displayName,
                    style: displayNameTextStyle,
                  ),
                ),
              ),
            ),

            ValueListenableBuilder(
              valueListenable: showEquippedButton,
              builder: (context, value, child) {
                return Align(
                  alignment: AlignmentGeometry.bottomCenter,
                  child: Transform.translate(
                    offset: Offset(0, -5),
                    child: AnimatedBuilder(
                      animation: buttonTween,
                      builder: (context, child) {
                        return (value)
                            ? child!
                            : ScaleTransition(scale: buttonTween, child: child);
                      },
                      child: Container(
                        width: buttonWidth,
                        height: buttonHeight,
                        decoration: BoxDecoration(
                          color: (value)
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
                            purin.equip(widget.purinVar.id as PurinVars);
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            ValueListenableBuilder(
              valueListenable: showEquippedButton,
              builder: (context, value, child) {
                return Align(
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
                            child: Text(
                              (value) ? "EQUIPPED" : "EQUIP",
                              style: (value)
                                  ? equippedButtonTextStyle
                                  : equipButtonTextStyle,
                            ),
                          ),
                        ),
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
