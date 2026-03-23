import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin_state_manager.dart';

class EnergyUI extends StatefulWidget {
  const EnergyUI({super.key});

  @override
  State<EnergyUI> createState() => _EnergyUIState();
}

class _EnergyUIState extends State<EnergyUI> {
  final Color uiColor = Color.fromARGB(255, 49, 141, 151);
  final icon = Icons.bolt_rounded;
  final iconColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueListenableBuilder<int>(
          valueListenable: PurinStateManager.singleton.energy,
          builder: (context, value, _) {
            return Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    color: uiColor,
                    value: (value / 100).clamp(0.0, 1.0),
                    strokeWidth: 3,
                  ),
                ),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: uiColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 20,
                    shadows: [
                      Shadow(color: Colors.black26, offset: Offset(2, 2)),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
