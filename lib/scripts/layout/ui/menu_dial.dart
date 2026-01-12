import 'package:flutter/material.dart';
import 'package:freestyle_speed_dial/freestyle_speed_dial.dart';

/// A clean, dropdown menu widget
class MenuDial extends StatefulWidget {
  const MenuDial({super.key});

  @override
  State<MenuDial> createState() => _MenuDialState();
}

class _MenuDialState extends State<MenuDial> with TickerProviderStateMixin {
  late AnimationController menuAnimationController;
  late Animation<double> menuAnimation;

  @override
  void initState() {
    super.initState();
    menuAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    menuAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(menuAnimationController);
  }

  @override
  void dispose() {
    menuAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 500),
      top: 40,
      right: 40,
      child: SpeedDialBuilder(
        buttonAnchor: Alignment.bottomCenter,
        itemAnchor: Alignment.topCenter,
        buttonBuilder: (context, isActive, toggle) {
          return IconButton(
            iconSize: 40,
            onPressed: () {
              toggle();
              (menuAnimationController.status == AnimationStatus.dismissed)
                  ? menuAnimationController.forward()
                  : menuAnimationController.reverse();
            },
            icon: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              color: Colors.white,
              progress: menuAnimationController,
            ),
          );
        },
        itemBuilder: (context, Widget item, i, animation) =>
            FractionalTranslation(
              translation: Offset(0, i.toDouble()),
              child: ScaleTransition(scale: animation, child: item),
            ),
        items: [
          Container(
            margin: EdgeInsets.only(top: 10),
            width: 50,
            height: 50,
            child: MaterialButton(
              shape: CircleBorder(),
              onPressed: () {},
              child: const Icon(
                Icons.hub,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Color.fromARGB(169, 147, 147, 147),
                    offset: Offset(3, 3),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            width: 50,
            height: 50,
            child: MaterialButton(
              shape: CircleBorder(),
              onPressed: () {},
              child: const Icon(
                Icons.download,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Color.fromARGB(169, 147, 147, 147),
                    offset: Offset(3, 3),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
