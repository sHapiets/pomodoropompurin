import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/prog_system.dart';
import 'package:pomodoropompurin/scripts/foundation/ingridient.dart';

class IngridientTile extends StatefulWidget {
  const IngridientTile({
    super.key,
    required this.ingridient,
    required this.ingridientIngridients,
    required this.processorIcon,
    required this.processorColor,
  });

  final Ingridient ingridient;
  final Map<Ingridient, int> ingridientIngridients;
  final IconData processorIcon;
  final Color processorColor;

  @override
  State<IngridientTile> createState() => _IngridientTileState();
}

class _IngridientTileState extends State<IngridientTile>
    with TickerProviderStateMixin {
  final progSystem = ProgSystem.singleton;

  final ValueNotifier<int> maxProcessableCount = ValueNotifier(1000);
  final ValueNotifier<int> processCount = ValueNotifier(0);

  void updateProcessableCount() {
    for (Ingridient requiredIngridient in widget.ingridientIngridients.keys) {
      final int ingridientInventoryCount =
          progSystem.ingridientInventory[requiredIngridient]!;
      final int requiredIngridientCount =
          widget.ingridientIngridients[requiredIngridient]!;
      final int processableCountFromIngridient =
          ingridientInventoryCount ~/ requiredIngridientCount;
      (maxProcessableCount.value > processableCountFromIngridient)
          ? maxProcessableCount.value = processableCountFromIngridient
          : null;
    }
  }

  final double iconSides = 60;
  final double tileHeight = 180;
  final double tileWidth = 80;
  final double buttonHeight = 40;
  final double buttonWidth = 40;

  late final AnimationController tileOnLoadAnimationController;
  late final Animation<double> tileOnLoadTween;

  final displayNameTextStyle = const TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 10,
    color: Color.fromARGB(255, 0, 0, 0),
  );

  late final AnimationController buttonAnimationController;
  late final Animation<double> buttonTween;
  bool showCookButton = false;

  Timer? cookTimer;
  double cookIndicator = 0.0;

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

  void buttonHold() {
    cookTimer?.cancel();
    cookTimer = Timer.periodic(Duration(milliseconds: 16), (cookTimer) {
      setState(() {
        cookIndicator = (cookIndicator + 0.05).clamp(0.0, 1.0);
        if (cookIndicator == 1.0) {
          cookTimer.cancel();
        }
      });
    });
  }

  void buttonCancel() {
    cookTimer?.cancel();
    cookTimer = Timer.periodic(Duration(milliseconds: 16), (openTimer) {
      setState(() {
        cookIndicator = (cookIndicator - 0.05).clamp(0.0, 1.0);
      });
    });
  }

  @override
  void dispose() {
    cookTimer?.cancel();
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
            /// Ingridient Image
            Align(
              alignment: AlignmentGeometry.topCenter,
              child: Transform.translate(
                offset: Offset(0, 10),
                child: Container(
                  width: iconSides,
                  height: iconSides,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),

            /// Ingridient Name
            Align(
              alignment: AlignmentGeometry.topCenter,
              child: Transform.translate(
                offset: Offset(0, 70),
                child: SizedBox(
                  child: Text(
                    widget.ingridient.displayName,
                    style: displayNameTextStyle,
                  ),
                ),
              ),
            ),

            /// ingridientIngridient Names
            Align(
              alignment: AlignmentGeometry.bottomCenter,
              child: Transform.translate(
                offset: Offset(0, -50),
                child: SizedBox(
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.ingridientIngridients.keys.map((
                      ingridient,
                    ) {
                      int ingridientCountInInventory =
                          progSystem.ingridientInventory[ingridient]!;
                      int ingridientCountNeeded =
                          widget.ingridientIngridients[ingridient]!;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(width: 20, height: 20, color: Colors.black),
                          Text(
                            '$ingridientCountInInventory/$ingridientCountNeeded',
                            style: displayNameTextStyle,
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),

            /// BUTTON BACKGROUND
            Align(
              alignment: AlignmentGeometry.bottomCenter,
              child: Transform.translate(
                offset: Offset(0, -5),
                child: Container(
                  width: buttonWidth,
                  height: buttonHeight,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.processorColor,
                  ),
                ),
              ),
            ),

            /// PROCESS BUTTON
            Align(
              alignment: AlignmentGeometry.bottomCenter,
              child: Transform.translate(
                offset: Offset(0, -5),
                child: ValueListenableBuilder(
                  valueListenable: maxProcessableCount,
                  builder: (context, value, child) {
                    return AnimatedBuilder(
                      animation: buttonTween,
                      builder: (context, child) {
                        return (showCookButton)
                            ? child!
                            : ScaleTransition(scale: buttonTween, child: child);
                      },
                      child: GestureDetector(
                        onTapDown: (details) {
                          buttonHold();
                        },
                        onTapUp: (details) {
                          buttonCancel();
                        },
                        onTapCancel: () {
                          buttonCancel();
                        },
                        child: IconButton(
                          icon: Icon(
                            widget.processorIcon,
                            color: const Color.fromARGB(255, 255, 255, 255),
                            /* shadows: [
                                Shadow(
                                  color: const Color.fromARGB(255, 206, 136, 30),
                                  offset: Offset(1, 1),
                                ),
                              ], */
                          ),
                          onPressed: () {},
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            Align(
              alignment: AlignmentGeometry.topRight,
              child: Transform.translate(
                offset: Offset(-5, 5),
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color.fromARGB(255, 91, 147, 185),
                  ),
                  child: Icon(
                    Icons.receipt_long_rounded,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    size: 15,
                  ),
                ),
              ),
            ),

            // PROGRESS INDICATOR
            Align(
              alignment: AlignmentGeometry.topCenter,
              child: Transform.translate(
                offset: Offset(0, 10),
                child: IgnorePointer(
                  child: SizedBox(
                    height: iconSides,
                    width: iconSides,
                    child: CircularProgressIndicator(
                      backgroundColor: const Color.fromARGB(151, 221, 221, 221),
                      value: cookIndicator,
                      color: widget.processorColor,
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
