import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer_display_state_manager.dart';
import 'package:pomodoropompurin/scripts/layout/pom_timer/pom_timer_display.dart';
import 'package:pomodoropompurin/scripts/memory/asset_manager.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class PomTimerActiveWidget extends StatefulWidget {
  const PomTimerActiveWidget({super.key});

  @override
  State<PomTimerActiveWidget> createState() => _PomTimerActiveWidgetState();
}

class _PomTimerActiveWidgetState extends State<PomTimerActiveWidget>
    with TickerProviderStateMixin {
  late PomTimer _pomTimer;
  final pomTimerDisplayStateManager = PomTimerDisplayStateManager.singleton;
  final assetManager = AssetManager.singleton;

  late void Function() updateTime;
  late void Function() updateGauge;
  double displayTime = 0;
  int maxTime = 1;

  final double gaugeRadius = 400;

  @override
  void initState() {
    super.initState();
    _pomTimer = PomTimer.singleton;
    displayTime = _pomTimer.timeLeftSeconds.toDouble();
    maxTime = (_pomTimer.onBreak)
        ? _pomTimer.timeSetBreakSeconds
        : _pomTimer.timeSetWorkSeconds;

    updateTime = () {
      setState(() {
        displayTime = _pomTimer.timeLeftSeconds.toDouble();
      });
    };
    pomTimerDisplayStateManager.timeLeftSeconds.addListener(updateTime);

    updateGauge = () {
      setState(() {
        maxTime = (_pomTimer.onBreak)
            ? _pomTimer.timeSetBreakSeconds
            : _pomTimer.timeSetWorkSeconds;
      });
    };
    pomTimerDisplayStateManager.onBreak.addListener(updateGauge);
  }

  @override
  void dispose() {
    pomTimerDisplayStateManager.timeLeftSeconds.removeListener(updateTime);
    pomTimerDisplayStateManager.onBreak.removeListener(updateGauge);
    super.dispose();
  }

  void showWarningEndTimerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(0), // optional
            child: Stack(
              children: [
                Image.asset('assets/images/L8.jpg'),
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Clipped original'),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _pomTimer.endTimer();
                          },
                          child: Text('yes,stop'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _pomTimer.playTimer();
                          },
                          child: Text("cancel"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
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
                  maximum: maxTime.toDouble(),
                  showLabels: false,
                  showTicks: false,
                  startAngle: 160,
                  endAngle: 20,
                  axisLineStyle: AxisLineStyle(
                    thickness: 1,
                    color: const Color.fromARGB(0, 255, 255, 255),
                    thicknessUnit: GaugeSizeUnit.factor,
                  ),

                  pointers: <GaugePointer>[
                    RangePointer(
                      value:
                          maxTime.toDouble() -
                          (_pomTimer.timeLeftSeconds.toDouble()),
                      width: 0.08,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      gradient: SweepGradient(
                        colors: const <Color>[
                          Color.fromARGB(255, 255, 255, 255),
                          Color.fromARGB(255, 255, 255, 255),
                        ],
                        stops: const <double>[0, 1],
                      ),
                      pointerOffset: 0.1,
                      cornerStyle: CornerStyle.bothFlat,
                      sizeUnit: GaugeSizeUnit.factor,
                      enableAnimation: true,
                      animationDuration: 700,
                      animationType: AnimationType.bounceOut,
                    ),

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
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        Positioned(
          left: 0,
          right: 0,
          bottom: 200,
          child: Column(
            children: [
              Text(
                PomTimerExtensions.formatDuration(_pomTimer.timeLeftSeconds),
                style: TextStyle(
                  fontFamily: 'Fredoka',
                  fontWeight: FontWeight.w500,
                  fontSize: 50,
                  color: const Color.fromARGB(232, 255, 255, 255),
                  shadows: [
                    Shadow(color: Colors.black12, offset: Offset(2, 2)),
                  ],
                ),
              ),
              Row(
                spacing: 30,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => _pomTimer.pauseTimer(),
                    child: Text('pause'),
                  ),
                  GestureDetector(
                    onTap: () {
                      _pomTimer.pauseTimer(); // Pause first
                      showWarningEndTimerDialog();
                    },
                    child: Text("End"), // change to icons...
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//// REDACTED
/* 
class PomTimerPlayButton extends StatefulWidget {
  const PomTimerPlayButton({super.key});

  @override
  State<PomTimerPlayButton> createState() => _PomTimerPlayButtonState();
}

class _PomTimerPlayButtonState extends State<PomTimerPlayButton> {
  final _pomTimer = PomTimer.singleton;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _pomTimer.playTimer();
      },
      child: Text("Resume"), // TODO change to icons...
    );
  }
}

class PomTimerPauseButton extends StatefulWidget {
  const PomTimerPauseButton({super.key});

  @override
  State<PomTimerPauseButton> createState() => _PomTimerPauseButtonState();
}

class _PomTimerPauseButtonState extends State<PomTimerPauseButton> {
  final _pomTimer = PomTimer.singleton;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _pomTimer.pauseTimer();
      },
      child: Text("Pause"), // change to icons...
    );
  }
} */
