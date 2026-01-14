import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer.dart';
import 'package:pomodoropompurin/scripts/layout/pom_timer/pom_timer_display.dart';
import 'package:pomodoropompurin/scripts/memory/asset_manager.dart';

class PomTimerPauseWidget extends StatefulWidget {
  const PomTimerPauseWidget({super.key});

  @override
  State<PomTimerPauseWidget> createState() => _PomTimerPauseWidgetState();
}

class _PomTimerPauseWidgetState extends State<PomTimerPauseWidget>
    with TickerProviderStateMixin {
  final assetManager = AssetManager.singleton;
  final pomTimer = PomTimer.singleton;

  late AnimationController buttonAnimController;
  late Animation<double> buttonTween;

  @override
  void initState() {
    super.initState();

    buttonAnimController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..repeat(reverse: true);
    buttonTween = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: buttonAnimController, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    buttonAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          bottom: 100,
          child: SizedBox(
            height: 300,
            width: 300,
            child: AnimatedBuilder(
              animation: buttonAnimController,
              builder: (context, child) {
                return ScaleTransition(scale: buttonTween, child: child);
              },
              child: Image.asset(assetManager.flutterAssetPaths['pT_SB']!),
            ),
          ),
        ),

        Positioned(
          left: 0,
          right: 0,
          bottom: 90,
          child: SizedBox(
            height: 250,
            width: 250,
            child: MaterialButton(
              onPressed: () {
                pomTimer.playTimer();
              },
              shape: CircleBorder(),
            ),
          ),
        ),

        Positioned(
          left: 0,
          right: 0,
          bottom: -150,
          child: SizedBox(
            height: 250,
            width: 250,
            child: Align(
              alignment: Alignment.topCenter,
              child: IgnorePointer(
                child: Text(
                  PomTimerExtensions.formatDuration(pomTimer.timeLeftSeconds),
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontWeight: FontWeight.w500,
                    fontSize: 90,
                    color: const Color.fromARGB(137, 255, 255, 255),
                    shadows: [
                      Shadow(color: Colors.black12, offset: Offset(4, 4)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
