import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer_display_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/ui/ui_display_state.dart';
import 'package:pomodoropompurin/scripts/layout/calendar_display/prog_calendar_display.dart';
import 'package:pomodoropompurin/scripts/layout/task_notes_display/task_notes_menu.dart';

class MenuDial extends StatefulWidget {
  const MenuDial({super.key});

  @override
  State<MenuDial> createState() => _MenuDialState();
}

class _MenuDialState extends State<MenuDial> with TickerProviderStateMixin {
  late AnimationController menuAnimationController;
  late Animation<double> menuAnimation;

  final pomTimerDisplayStateManager = PomTimerDisplayStateManager.singleton;

  ValueNotifier<bool> toggle = ValueNotifier(false);

  @override
  void initState() {
    super.initState();

    menuAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    menuAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(menuAnimationController);
  }

  @override
  void dispose() {
    menuAnimationController.dispose();
    toggle.dispose();
    super.dispose();
  }

  void toggleMenu() {
    toggle.value = !toggle.value;

    if (menuAnimationController.isCompleted) {
      menuAnimationController.reverse();
    } else {
      menuAnimationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: UIDisplayState.singleton.hide,
      builder: (context, value, child) {
        return AnimatedPositioned(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          top: 40,
          right: (value) ? -200 : 40,
          child: child!,
        );
      },
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          /// EXPANDING BACKGROUND
          ValueListenableBuilder(
            valueListenable: toggle,
            builder: (context, value, _) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOutCubic,
                width: value ? 60 : 0,
                height: value ? 200 : 0,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(84, 89, 89, 89),
                  borderRadius: BorderRadius.circular(40),
                ),
              );
            },
          ),

          /// 🔘 BUTTON COLUMN
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// MAIN MENU BUTTON
              IconButton(
                iconSize: 40,
                onPressed: toggleMenu,
                icon: AnimatedIcon(
                  color: Colors.white,
                  icon: AnimatedIcons.menu_close,
                  progress: menuAnimation,
                ),
              ),

              const SizedBox(height: 20),

              /// TASK BUTTON
              ValueListenableBuilder(
                valueListenable: toggle,
                builder: (context, value, child) {
                  return AnimatedScale(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOutCirc,
                    scale: value ? 1 : 0,
                    child: child,
                  );
                },
                child: IconButton(
                  iconSize: 30,
                  onPressed: () {
                    showModalBottomSheet(
                      enableDrag: false,
                      context: context,
                      elevation: 5,
                      barrierColor: Colors.black26,
                      backgroundColor: Colors.transparent,
                      builder: (_) => TaskNotesMenu(),
                    );
                    toggleMenu();
                  },
                  icon: const Icon(Icons.list_alt_rounded, color: Colors.white),
                ),
              ),

              const SizedBox(height: 20),

              /// CALENDAR BUTTON
              ValueListenableBuilder(
                valueListenable: toggle,
                builder: (context, value, child) {
                  return AnimatedScale(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOutCirc,
                    scale: value ? 1 : 0,
                    child: child,
                  );
                },
                child: IconButton(
                  iconSize: 30,
                  onPressed: () {
                    showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierColor: Colors.black26,
                      barrierLabel: '',
                      transitionDuration: const Duration(milliseconds: 300),
                      transitionBuilder: (context, animation, _, child) {
                        return ScaleTransition(
                          scale: CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOutBack,
                          ),
                          child: child,
                        );
                      },
                      pageBuilder: (_, __, ___) => ProgCalendarDisplay(),
                    );
                    toggleMenu();
                  },
                  icon: const Icon(
                    Icons.calendar_today_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/* SpeedDialBuilder(
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
                onPressed: () {
                  showModalBottomSheet(
                    enableDrag: false,
                    context: context,
                    elevation: 5,
                    barrierColor: Colors.black26,
                    backgroundColor: const Color.fromARGB(0, 0, 0, 0),
                    builder: (context) {
                      return TaskNotesMenu();
                    },
                  );
                },
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
                onPressed: () {
                  showGeneralDialog(
                    context: context,
                    barrierDismissible: true,
                    barrierColor: Colors.black26,
                    barrierLabel: '',
                    transitionDuration: Duration(milliseconds: 300),
                    transitionBuilder:
                        (context, animation, secondaryAnimation, child) {
                          return ScaleTransition(
                            scale: CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeOutBack,
                            ),
                            child: child,
                          );
                        },
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return ProgCalendarDisplay();
                    },
                  );
                },
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
      ), */
