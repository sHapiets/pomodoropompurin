import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/tutorial/tutorial_state.dart';

class TutorialPageBlocker extends StatefulWidget {
  const TutorialPageBlocker({super.key});

  @override
  State<TutorialPageBlocker> createState() => _TutorialPageBlockerState();
}

class _TutorialPageBlockerState extends State<TutorialPageBlocker> {
  final tutorialState = TutorialState.singleton;

  Widget display = const SizedBox.shrink();
  final blocker = Container(
    color: const Color.fromARGB(255, 30, 30, 30),
    width: double.infinity,
    height: double.infinity,
  );

  @override
  void initState() {
    display = blocker;
    super.initState();

    tutorialState.section.addListener(() {
      setState(() {
        showBlocker(tutorialState.section.value);
      });
    });
  }

  void showBlocker(int currentSection) {
    final blockedSections = [1, 2, 4];

    if (blockedSections.contains(currentSection)) {
      display = blocker;
    } else {
      display = const SizedBox.expand();
    }
  }

  @override
  Widget build(BuildContext context) {
    return display;
  }
}
