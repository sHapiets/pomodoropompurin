import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_equip_manager.dart';
import 'package:pomodoropompurin/scripts/foundation/acquirable.dart';

class KotatsuEquipTile extends StatefulWidget {
  const KotatsuEquipTile({super.key, required this.item});

  final RoomDesign item;

  @override
  State<KotatsuEquipTile> createState() => _KotatsuEquipTileState();
}

class _KotatsuEquipTileState extends State<KotatsuEquipTile>
    with TickerProviderStateMixin {
  final purinAreaEquipManager = PurinAreaEquipManager.singleton;

  final double iconSides = 70;
  final double tileHeight = 135;
  final double tileWidth = 80;
  final double buttonHeight = 20;
  final double buttonWidth = 50;

  final equippedButtonTextStyle = const TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 6,
    color: Color.fromARGB(172, 255, 255, 255),
  );

  final equipButtonTextStyle = const TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 10,
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
  bool showEquippedButton = false;

  @override
  void initState() {
    super.initState();
    changeEquipButton();
    purinAreaEquipManager.kotatsu.addListener(changeEquipButton);

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
    (purinAreaEquipManager.kotatsu.value == widget.item)
        ? {showEquippedButton = true}
        : {showEquippedButton = false};
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
                  widget.item.displayName,
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
                          },
                          child: Center(
                            child: Text(
                              (showEquippedButton) ? "EQUIPPED" : "EQUIP",
                              style: (showEquippedButton)
                                  ? equippedButtonTextStyle
                                  : equipButtonTextStyle,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
