import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer_display_state_manager.dart';

class UIBlock extends StatefulWidget {
  const UIBlock({super.key});

  @override
  State<UIBlock> createState() => _UIBlockState();
}

class _UIBlockState extends State<UIBlock> with TickerProviderStateMixin {
  final pomTimerDisplayStateManager = PomTimerDisplayStateManager.singleton;

  late void Function() uiBlockSet;
  late AnimationController fadeAnimController;
  late Animation<Color?> fadeTween;
  late Widget currentWidget;

  @override
  void initState() {
    super.initState();

    fadeAnimController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    fadeTween =
        ColorTween(
          begin: const Color.fromARGB(0, 0, 0, 0),
          end: const Color.fromARGB(114, 0, 0, 0),
        ).animate(
          CurvedAnimation(parent: fadeAnimController, curve: Curves.linear),
        );

    currentWidget = const SizedBox.shrink();

    uiBlockSet = () {
      setState(() {
        if (pomTimerDisplayStateManager.pomTimerState.value ==
            PomTimerStates.play) {
          currentWidget = AnimatedModalBarrier(color: fadeTween);
          fadeAnimController.forward();
        } else {
          fadeAnimController.reverse().then((_) {
            currentWidget = const SizedBox.shrink();
            setState(() {});
          });
        }
      });
    };

    pomTimerDisplayStateManager.pomTimerState.addListener(uiBlockSet);
  }

  @override
  void dispose() {
    pomTimerDisplayStateManager.pomTimerState.removeListener(uiBlockSet);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return currentWidget;
  }
}
