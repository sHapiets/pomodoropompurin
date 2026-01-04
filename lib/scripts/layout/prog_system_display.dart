import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/prog_system.dart';

class ProgSystemDisplay extends StatefulWidget {
  const ProgSystemDisplay({super.key});

  @override
  State<ProgSystemDisplay> createState() => _ProgSystemDisplayState();
}

class _ProgSystemDisplayState extends State<ProgSystemDisplay> {
  final progSystem = ProgSystem.singleton;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 30,
      children: [
        ValueListenableBuilder(
          valueListenable: progSystem.pomPoints,
          builder: (context, value, child) {
            return Text('PP: ${progSystem.pomPointsString}');
          },
        ),

        ValueListenableBuilder(
          valueListenable: progSystem.milkJugs,
          builder: (context, value, child) {
            return Text('MJ: ${progSystem.milkJugsString}');
          },
        ),
      ],
    );
  }
}
