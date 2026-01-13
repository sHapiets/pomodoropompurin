import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:pomodoropompurin/scripts/layout/pom_timer/pom_timer_main_active.dart';
import 'package:pomodoropompurin/scripts/layout/pom_timer/pom_timer_main_idle.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class PomTimerMainWidget extends StatefulWidget {
  const PomTimerMainWidget({super.key});

  @override
  State<PomTimerMainWidget> createState() => _PomTimerMainWidgetState();
}

class _PomTimerMainWidgetState extends State<PomTimerMainWidget> {
  late PomTimer _pomTimer;
  final purinAreaStateManager = PurinAreaStateManager.singleton;
  String panelDisplayMode = 'Idle';
  String widgetPositionState = 'Tab';

  int panelWidth = 400;
  int panelHeight = 400;
  int tabWidth = 100;

  /// A widget placeholder that switches between modes
  Widget get pomTimerWidget {
    switch (panelDisplayMode) {
      case 'Active':
        return PomTimerActiveWidget();
      case 'Paused':
        return PomTimerActiveWidget();
      default: // case Idle (or Input)
        return PomTimerIdleWidget();
    }
  }

  @override
  void initState() {
    super.initState();
    _pomTimer = PomTimer.singleton;
    _pomTimer.switchPomTimerMode = (String mode) {
      setState(() {
        panelDisplayMode = mode;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return
    // -- PANEL
    SizedBox(
      width: panelWidth.toDouble(),
      height: panelHeight.toDouble(),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          /*  */
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              layoutBuilder: (currentChild, previousChildren) {
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ...previousChildren,
                    if (currentChild != null) currentChild,
                  ],
                );
              },
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    alignment: Alignment.bottomCenter,
                    scale: Tween(begin: 0.95, end: 1.0).animate(animation),
                    child: child,
                  ),
                );
              },
              child: pomTimerWidget,
            ),
          ),
        ],
      ),
    );
  }
}
