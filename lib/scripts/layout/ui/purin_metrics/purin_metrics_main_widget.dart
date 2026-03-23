import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/ui/purin_metrics_ui_state.dart';
import 'package:pomodoropompurin/scripts/core/ui/ui_display_state.dart';
import 'package:pomodoropompurin/scripts/layout/ui/purin_metrics/energy_ui.dart';
import 'package:pomodoropompurin/scripts/layout/ui/purin_metrics/hunger_ui.dart';

class PurinMetricsMainWidget extends StatefulWidget {
  const PurinMetricsMainWidget({super.key});

  @override
  State<PurinMetricsMainWidget> createState() => _PurinMetricsMainWidgetState();
}

class _PurinMetricsMainWidgetState extends State<PurinMetricsMainWidget> {
  final widgetSize = 100;
  final uiDisplayState = UIDisplayState.singleton;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: uiDisplayState.hide,
      builder: (context, value, child) {
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          top: 0,
          bottom: 0,
          left: (value) ? -100 : 14,
          curve: Curves.easeInOutBack,
          child: child!,
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HungerUI(),
          const SizedBox(height: 10, width: 20),
          EnergyUI(),
        ],
      ),
    );
  }
}
