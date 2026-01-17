import 'package:flutter/material.dart';
import 'package:freestyle_speed_dial/freestyle_speed_dial.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer_display_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';

/// A clean, dropdown menu widget
class MenuDial extends StatefulWidget {
  const MenuDial({super.key});

  @override
  State<MenuDial> createState() => _MenuDialState();
}

class _MenuDialState extends State<MenuDial> with TickerProviderStateMixin {
  late AnimationController menuAnimationController;
  late Animation<double> menuAnimation;

  final pomTimerDisplayStateManager = PomTimerDisplayStateManager.singleton;

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
    return ValueListenableBuilder(
      valueListenable: pomTimerDisplayStateManager.pomTimerState,
      builder: (context, value, child) {
        return AnimatedPositioned(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          top: 40,
          right: (value == 'play') ? -100 : 40,
          child: child!,
        );
      },
      child: SpeedDialBuilder(
        buttonAnchor: Alignment.bottomCenter,
        itemAnchor: Alignment.topCenter,
        buttonBuilder: (context, isActive, toggle) {
          return IconButton(
            color: Colors.white,
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
            child: Center(
              child: MaterialButton(
                shape: CircleBorder(),
                onPressed: () {},
                child: const Icon(
                  Icons.library_add_sharp,
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
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            width: 50,
            height: 50,
            child: Center(
              child: MaterialButton(
                shape: CircleBorder(),
                onPressed: () {},
                child: const Icon(
                  Icons.calendar_month_outlined,
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
          ),
        ],
      ),
    );
  }
}
