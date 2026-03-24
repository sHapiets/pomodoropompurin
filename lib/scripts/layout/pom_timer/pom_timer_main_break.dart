import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer_display_state_manager.dart';
import 'package:pomodoropompurin/scripts/layout/pom_timer/dialogs/stop_pom_timer_dialog.dart';
import 'package:pomodoropompurin/scripts/layout/pom_timer/pom_timer_display.dart';
import 'package:pomodoropompurin/scripts/memory/asset_manager.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class PomTimerBreakWidget extends StatefulWidget {
  const PomTimerBreakWidget({super.key});

  @override
  State<PomTimerBreakWidget> createState() => _PomTimerBreakWidgetState();
}

class _PomTimerBreakWidgetState extends State<PomTimerBreakWidget>
    with TickerProviderStateMixin {
  final assetManager = AssetManager.singleton;
  final pomTimer = PomTimer.singleton;
  final pomTimerDisplayStateManager = PomTimerDisplayStateManager.singleton;

  late AnimationController textAnimController;
  late Animation<double> textTween;

  late void Function() updateBreakWidget;

  @override
  void initState() {
    super.initState();

    textAnimController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    textTween = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: textAnimController, curve: Curves.easeIn),
    );

    updateBreakWidget = () {
      setState(() {});
    };

    pomTimerDisplayStateManager.timeLeftSeconds.addListener(updateBreakWidget);
  }

  @override
  void dispose() {
    pomTimerDisplayStateManager.timeLeftSeconds.removeListener(
      updateBreakWidget,
    );
    textAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          bottom: 47,
          child: IgnorePointer(
            child: SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  radiusFactor: 0.95,
                  minimum: 0,
                  maximum: pomTimer.timeSetBreakSeconds.toDouble(),
                  showLabels: false,
                  showTicks: false,
                  startAngle: 270,
                  endAngle: 270,
                  axisLineStyle: AxisLineStyle(
                    thickness: 1,
                    color: const Color.fromARGB(0, 255, 255, 255),
                    thicknessUnit: GaugeSizeUnit.factor,
                  ),

                  pointers: <GaugePointer>[
                    RangePointer(
                      value:
                          pomTimer.timeSetBreakSeconds.toDouble() -
                          (pomTimer.timeLeftSeconds.toDouble()),
                      width: 0.1,
                      color: const Color.fromARGB(228, 255, 255, 255),
                      pointerOffset: 0.2,
                      cornerStyle: CornerStyle.bothFlat,
                      sizeUnit: GaugeSizeUnit.factor,
                      enableAnimation: true,
                      animationDuration: 700,
                      animationType: AnimationType.bounceOut,
                    ),
                    /* 
                    MarkerPointer(
                      value:
                          maxTime.toDouble() -
                          (_pomTimer.timeLeftSeconds.toDouble()),
                      enableAnimation: true,
                      animationDuration: 700,
                      animationType: AnimationType.bounceOut,

                      markerOffset: -60,
                      markerType: MarkerType.image,
                      markerHeight: 50,
                      markerWidth: 50,
                      elevation: 3,
                      imageUrl: assetManager.flutterAssetPaths['pT_WP'],
                    ), */
                  ],
                ),
              ],
            ),
          ),
        ),

        Positioned(
          left: 0,
          right: 0,
          bottom: 220,
          child: SizedBox(
            width: 320,
            height: 250,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 100,
                  onPressed: () {
                    pomTimer.skipBreak();
                  },
                  icon: Icon(
                    Icons.skip_next_rounded,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: const Color.fromARGB(130, 146, 105, 11),
                        offset: Offset(3, 3),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30, width: 150),

                IconButton(
                  iconSize: 100,
                  onPressed: () {
                    pomTimer.pauseTimer();
                    showGeneralDialog(
                      context: context,
                      barrierDismissible: false,
                      barrierLabel: "Pomodoro End",
                      barrierColor: Colors.black54,
                      transitionDuration: const Duration(milliseconds: 400),
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return StopPomTimerDialog(
                          onCancel: () {
                            Navigator.of(context).pop(); // just close dialog
                          },
                          onConfirm: () {
                            Navigator.of(context).pop();
                            // Add your stop timer logic here
                          },
                        );
                      },
                      transitionBuilder:
                          (context, animation, secondaryAnimation, child) {
                            final curved = CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeInOutBack,
                              reverseCurve: Curves.easeInOutBack,
                            );

                            return FadeTransition(
                              opacity: animation,
                              child: ScaleTransition(
                                scale: Tween<double>(
                                  begin: 0.7,
                                  end: 1,
                                ).animate(curved),
                                child: child,
                              ),
                            );
                          },
                    );
                  },
                  icon: Icon(
                    Icons.stop_rounded,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: const Color.fromARGB(130, 146, 105, 11),
                        offset: Offset(3, 3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        Positioned(
          left: 0,
          right: 0,
          bottom: 30,
          child: SizedBox(
            height: 250,
            width: 250,
            child: Align(
              alignment: Alignment.topCenter,
              child: IgnorePointer(
                child: AnimatedBuilder(
                  animation: textAnimController,
                  builder: (context, child) {
                    return ScaleTransition(scale: textTween, child: child);
                  },
                  child: Text(
                    'break',
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                      fontWeight: FontWeight.w500,
                      fontSize: 70,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      shadows: [
                        Shadow(color: Colors.black12, offset: Offset(4, 4)),
                      ],
                    ),
                  ),
                ),
              ),
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
                    color: const Color.fromARGB(217, 255, 255, 255),
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
