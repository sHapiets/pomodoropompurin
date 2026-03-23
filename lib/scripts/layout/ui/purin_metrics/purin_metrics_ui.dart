import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/ui/purin_metrics_ui_state.dart';
import 'package:pomodoropompurin/scripts/layout/ui/purin_metrics/energy_ui.dart';
import 'package:pomodoropompurin/scripts/layout/ui/purin_metrics/hunger_ui.dart';

class PurinMetricsUI extends StatefulWidget {
  const PurinMetricsUI({super.key});

  @override
  State<PurinMetricsUI> createState() => _PurinMetricsUIState();
}

class _PurinMetricsUIState extends State<PurinMetricsUI> {
  final widgetSize = 100;
  final purinMetricsUIState = PurinMetricsUIState.singleton;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: purinMetricsUIState.hide,
      builder: (context, value, child) {
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          left: 0,
          right: 0,
          top: (value) ? -100 : 50,
          curve: Curves.easeInOutBack,
          child: child!,
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HungerUI(showHungerValue: true),
          const SizedBox(height: 20, width: 20),
          EnergyUI(showEnergyValue: true),
        ],
      ),
    );
  }
}
