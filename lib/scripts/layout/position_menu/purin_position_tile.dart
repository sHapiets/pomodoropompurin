import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:pomodoropompurin/scripts/foundation/acquirable.dart';
import 'package:pomodoropompurin/scripts/page/main_page.dart';

class PurinPositionTile extends StatefulWidget {
  const PurinPositionTile({super.key, required this.purinPosition});

  final PurinPosition purinPosition;

  @override
  State<PurinPositionTile> createState() => _PurinPositionTileState();
}

class _PurinPositionTileState extends State<PurinPositionTile>
    with TickerProviderStateMixin {
  final purin = Purin.singleton;
  final purinAreaStateManager = PurinAreaStateManager.singleton;

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
    fontSize: 10,
    color: Color.fromARGB(255, 0, 0, 0),
  );

  late final AnimationController tileOnLoadAnimationController;
  late final Animation<double> tileOnLoadTween;

  late final AnimationController buttonAnimationController;
  late final Animation<double> buttonTween;
  bool showPlacedButton = false;

  @override
  void initState() {
    super.initState();
    changeSetButton();
    purin.addListener(changeSetButton);

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

  void changeSetButton() {
    (purin.stateManager.position == widget.purinPosition)
        ? {showPlacedButton = true}
        : {showPlacedButton = false};
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
                  widget.purinPosition.name,
                  style: displayNameTextStyle,
                ),
              ),
            ),

            Align(
              alignment: AlignmentGeometry.bottomCenter,
              child: Transform.translate(
                offset: Offset(0, -5),
                child: ListenableBuilder(
                  listenable: purin,
                  builder: (context, child) {
                    return AnimatedBuilder(
                      animation: buttonTween,
                      builder: (context, child) {
                        return (showPlacedButton)
                            ? child!
                            : ScaleTransition(scale: buttonTween, child: child);
                      },
                      child: Container(
                        width: buttonWidth,
                        height: buttonHeight,
                        decoration: BoxDecoration(
                          color: (showPlacedButton)
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
                            purin.changePosition(widget.purinPosition);
                            purinAreaStateManager.jumpToPosition(
                              purin.purinPositionVect2,
                              Vector2(70, -100),
                              1.5,
                            );
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
                        child: ListenableBuilder(
                          listenable: purin,
                          builder: (context, child) {
                            return Text(
                              (showPlacedButton) ? "PLACED" : "SET",
                              style: (showPlacedButton)
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
