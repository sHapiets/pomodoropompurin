import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/prog_system.dart';
import 'package:pomodoropompurin/scripts/foundation/consumable.dart';
import 'package:pomodoropompurin/scripts/foundation/ingridient.dart';

class ConsumableTile extends StatefulWidget {
  const ConsumableTile({
    super.key,
    required this.consumable,
    required this.ingridientIngridients,
    required this.processorIcon,
    required this.processorColor,
  });

  final Consumable consumable;
  final Map<Ingridient, int> ingridientIngridients;
  final IconData processorIcon;
  final Color processorColor;

  @override
  State<ConsumableTile> createState() => _ConsumableTileState();
}

class _ConsumableTileState extends State<ConsumableTile>
    with TickerProviderStateMixin {
  final progSystem = ProgSystem.singleton;

  final ValueNotifier<int> maxProcessableCount = ValueNotifier(1000);

  void updateMaxProcessableCount() {
    for (MapEntry<Ingridient, int> requiredIngridient
        in widget.ingridientIngridients.entries) {
      final int ingridientInventoryCount =
          progSystem.ingridientInventory[requiredIngridient.key]!.value;
      final int processableCountFromIngridient =
          ingridientInventoryCount ~/ requiredIngridient.value;
      maxProcessableCount.value =
          (maxProcessableCount.value > processableCountFromIngridient)
          ? processableCountFromIngridient
          : maxProcessableCount.value;
    }
  }

  void processIngridients() {
    for (MapEntry<Ingridient, int> requiredIngridient
        in widget.ingridientIngridients.entries) {
      progSystem.useIngridient(
        requiredIngridient.key,
        requiredIngridient.value,
      );
    }

    progSystem.addConsumable(widget.consumable, 1);
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

  final ingNameTextStyle = const TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 9,
    color: Color.fromARGB(255, 0, 0, 0),
  );
  TextStyle ingCountTextStyle(bool insuffecientAmount) {
    return TextStyle(
      fontFamily: 'Fredoka',
      fontSize: 10,
      fontWeight: FontWeight.bold,
      color: insuffecientAmount ? Colors.red : Colors.green,
    );
  }

  late final AnimationController buttonAnimationController;
  late final Animation<double> buttonTween;
  bool showCookButton = false;

  Timer? cookTimer;
  double cookSpeed = 0.03;
  double cookIndicator = 0.0;

  @override
  void initState() {
    super.initState();
    updateMaxProcessableCount();
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
        if (maxProcessableCount.value == 0) {
          cookTimer.cancel();
          return;
        }

        cookIndicator = (cookIndicator + cookSpeed).clamp(0.0, 1.0);
        if (cookIndicator == 1.0) {
          cookIndicator = 0;
          processIngridients();
          updateMaxProcessableCount();
          cookSpeed = (cookSpeed >= 0.05) ? 0.05 : cookSpeed + 0.006;
        }
      });
    });
  }

  void buttonCancel() {
    cookTimer?.cancel();
    cookSpeed = 0.03;
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

            /// ingridientIngridient Names
            Align(
              alignment: AlignmentGeometry.center,
              child: Transform.translate(
                offset: Offset(0, 20),
                child: SizedBox(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.ingridientIngridients.keys.map((
                      ingridient,
                    ) {
                      int ingridientCountNeeded =
                          widget.ingridientIngridients[ingridient]!;
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 5,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: Image.asset(
                                  ingridient.spriteFlutterPath,
                                ),
                              ),
                              ValueListenableBuilder(
                                valueListenable:
                                    progSystem.ingridientInventory[ingridient]!,
                                builder: (context, value, child) {
                                  return Text(
                                    '$value/$ingridientCountNeeded',
                                    style: ingCountTextStyle(
                                      value < ingridientCountNeeded,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),

                          Text(ingridient.displayName, style: ingNameTextStyle),
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
                child: ScaleTransition(
                  scale: buttonTween,
                  child: GestureDetector(
                    onTapDown: (_) => buttonHold(),
                    onTapUp: (_) => buttonCancel(),
                    onTapCancel: buttonCancel,
                    child: Container(
                      height: buttonHeight,
                      width: buttonWidth,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.processorColor,
                      ),
                      child: IconButton(
                        icon: Icon(
                          widget.processorIcon,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          size: 22,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              ),
            ),

            ///
            Align(
              alignment: AlignmentGeometry.topRight,
              child: Transform.translate(
                offset: Offset(-5, 5),
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color.fromARGB(255, 176, 225, 53),
                  ),
                  child: Icon(
                    Icons.restaurant,
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
