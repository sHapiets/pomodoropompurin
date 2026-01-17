import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer_display_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:pomodoropompurin/scripts/layout/pom_timer/pom_timer_main_widget.dart';
import 'package:pomodoropompurin/scripts/layout/pom_timer/pom_timer_open_timer_button.dart';

class PomTimerDisplay extends StatefulWidget {
  const PomTimerDisplay({super.key});

  @override
  State<PomTimerDisplay> createState() => _PomTimerDisplayState();
}

class _PomTimerDisplayState extends State<PomTimerDisplay> {
  final purinAreaStateManager = PurinAreaStateManager.singleton;
  final pomTimerDisplayStateManager = PomTimerDisplayStateManager.singleton;
  late Widget pomTimerAtDisplay;

  @override
  void initState() {
    super.initState();
    pomTimerAtDisplay = PomTimerOpenButton();
    pomTimerDisplayStateManager.openPomTimer = () {
      setState(() {
        pomTimerAtDisplay = PomTimerMainWidget();
      });
    };
    pomTimerDisplayStateManager.closePomTimer = () {
      setState(() {
        pomTimerAtDisplay = PomTimerOpenButton();
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    // Animation for Opening Widget
    return AnimatedPositioned(
      duration: Duration(milliseconds: 500),
      bottom: 0,
      left: 0,
      right: 0,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 1000),
        switchInCurve: Curves.easeInOutBack,
        switchOutCurve: Curves.easeInOutBack,
        layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ...previousChildren,
              if (currentChild != null) currentChild,
            ],
          );
        },
        transitionBuilder: (Widget child, Animation<double> animation) {
          final slideAnimation = Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation);

          return SlideTransition(position: slideAnimation, child: child);
        },
        child: pomTimerAtDisplay, // MUST have a Key
      ),
    );
  }
}

// List of Extra Methods
abstract class PomTimerExtensions {
  static String formatDuration(int totalSeconds) {
    final int hours = (totalSeconds ~/ 3600) % 24;
    final int minutes = (totalSeconds ~/ 60) % 60;
    final int seconds = totalSeconds % 60;

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr';
  }
}

// List of Text Styles for PomTimer
abstract class PomTimerTextStyles {
  static final digitTextStyle = TextStyle(
    fontSize: 20,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );
}
