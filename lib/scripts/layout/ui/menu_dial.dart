import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer_display_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/ui/ui_display_state.dart';
import 'package:pomodoropompurin/scripts/layout/audio/volume_control_widget.dart';
import 'package:pomodoropompurin/scripts/layout/calendar_display/prog_calendar_display.dart';
import 'package:pomodoropompurin/scripts/layout/task_notes_display/task_notes_menu.dart';
import 'package:pomodoropompurin/scripts/layout/version_control/version_notes_dialog.dart';

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
          curve: Curves.easeInOutBack,
          top: 40,
          right: (value) ? -200 : 40,
          child: child!,
        );
      },
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          SizedBox(width: 60),

          /// EXPANDING BACKGROUND
          ValueListenableBuilder(
            valueListenable: toggle,
            builder: (context, value, _) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOutCubic,
                width: value ? 60 : 0,
                height: value ? 330 : 0,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(183, 118, 116, 110),
                  borderRadius: BorderRadius.circular(40),
                ),
              );
            },
          ),

          ///  BUTTON COLUMN
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// MAIN MENU BUTTON
              Stack(
                children: [
                  Transform.translate(
                    offset: Offset(2, 2),
                    child: IconButton(
                      iconSize: 40,
                      onPressed: toggleMenu,
                      icon: AnimatedIcon(
                        color: const Color.fromARGB(164, 76, 74, 74),
                        icon: AnimatedIcons.menu_close,
                        progress: menuAnimation,
                      ),
                    ),
                  ),
                  IconButton(
                    iconSize: 40,
                    onPressed: toggleMenu,
                    icon: AnimatedIcon(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      icon: AnimatedIcons.menu_close,
                      progress: menuAnimation,
                    ),
                  ),
                ],
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
                  icon: const Icon(
                    Icons.list_alt_rounded,
                    color: Color.fromARGB(255, 255, 255, 255),
                    shadows: [
                      Shadow(
                        color: Color.fromARGB(57, 59, 59, 59),
                        offset: Offset(3, 3),
                      ),
                    ],
                  ),
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
                    color: Color.fromARGB(255, 255, 255, 255),
                    shadows: [
                      Shadow(
                        color: Color.fromARGB(57, 59, 59, 59),
                        offset: Offset(3, 3),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              /// VOLUME BUTTON
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
                      pageBuilder: (_, __, ___) => VolumeControlWidget(),
                    );
                    toggleMenu();
                  },
                  icon: const Icon(
                    Icons.volume_up_rounded,
                    color: Color.fromARGB(255, 255, 255, 255),
                    shadows: [
                      Shadow(
                        color: Color.fromARGB(57, 59, 59, 59),
                        offset: Offset(3, 3),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              /// VERSION NOTES BUTTON
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
                      pageBuilder: (_, __, ___) => VersionNotesDialog(),
                    );
                    toggleMenu();
                  },
                  icon: const Icon(
                    Icons.update_rounded,
                    color: Color.fromARGB(255, 255, 255, 255),
                    shadows: [
                      Shadow(
                        color: Color.fromARGB(57, 59, 59, 59),
                        offset: Offset(3, 3),
                      ),
                    ],
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
