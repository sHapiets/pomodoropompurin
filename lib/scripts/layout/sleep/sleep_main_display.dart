import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/layout/sleep/sleep_display_state_manager.dart';
import 'package:pomodoropompurin/scripts/memory/asset_manager.dart';

class SleepMainDisplay extends StatefulWidget {
  const SleepMainDisplay({super.key});

  @override
  State<SleepMainDisplay> createState() => _SleepMainDisplayState();
}

class _SleepMainDisplayState extends State<SleepMainDisplay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final assetManager = AssetManager.singleton;
  final sleepDisplayState = SleepDisplayStateManager.singleton.state;
  Widget moonWidget = SizedBox.shrink();

  @override
  void initState() {
    super.initState();

    moonWidget = Image.asset(assetManager.flutterAssetPaths['pT_FG']!);

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void startSleep() {
    sleepDisplayState.value = SleepDisplayState.sleep;
  }

  void cancelSleep() {
    sleepDisplayState.value = SleepDisplayState.close;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: sleepDisplayState,
      builder: (context, value, child) {
        Map<SleepDisplayState, double> posBottom = {
          SleepDisplayState.close: -80,
          SleepDisplayState.open: 50,
          SleepDisplayState.sleep: MediaQuery.of(context).size.height / 2,
        };

        return AnimatedPositioned(
          bottom: 0,
          duration: const Duration(milliseconds: 500),
          child: child!,
        );
      },
      child: Stack(children: [moonWidget]),
    );
  }
}
