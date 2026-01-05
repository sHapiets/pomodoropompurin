import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class PomTimerDisplay extends StatefulWidget {
  const PomTimerDisplay({super.key});

  @override
  State<PomTimerDisplay> createState() => _PomTimerDisplayState();
}

class _PomTimerDisplayState extends State<PomTimerDisplay>
    with TickerProviderStateMixin {
  late PomTimer _pomTimer;
  double displayTime = 0;
  String displayMode = 'Input';

  int panelWidth = 400;
  int panelHeight = 200;
  int tabWidth = 100;
  bool isHidden = true;

  Widget get pomTimerWidget {
    switch (displayMode) {
      case 'Playing':
        return PomTimerGauge();
      case 'Pause':
        return PomTimerGauge2();
      default: // case Input
        return PomTimerGauge2();
    }
  } /////// ERASE SAMPLE

  @override
  void initState() {
    super.initState();
    _pomTimer = PomTimer.singleton;
    _pomTimer.updatePomTimerCount = () {
      setState(() {
        displayTime = _pomTimer.timeLeftSeconds.toDouble();
      });
    };
    _pomTimer.switchPomTimerMode = (String mode) {
      setState(() {
        displayMode = mode;
      });
    };
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
                Image.asset('assets/L8.jpg'),
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

  /// >>>>>>>>>>>>>>>>>>>>>
  /// PomTimer Widget Build
  /// >>>>>>>>>>>>>>>>>>>>>
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubicEmphasized,
      top: 0,
      bottom: 0,
      left: isHidden ? (-panelWidth).toDouble() : 0,
      child: Row(
        children: [
          // PANEL
          Container(
            width: panelWidth.toDouble(),
            height: panelHeight.toDouble(),
            color: Colors.blueGrey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //
                SizedBox(
                  width: 200,
                  height: 200,

                  // Animation for MODE SWITCHING (not isHidden)
                  child: AnimatedSwitcher(
                    switchInCurve: Curves.linearToEaseOut,
                    switchOutCurve: Curves.linear,
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position: Tween(
                                begin: const Offset(0.2, 0),
                                end: Offset.zero,
                              ).animate(animation),
                              child: child,
                            ),
                          );
                        },
                    child: pomTimerWidget,
                  ),
                ),

                // PomTimer Text
                Column(
                  children: [
                    Text(
                      PomTimerExtensions.formatDuration(
                        _pomTimer.timeLeftSeconds,
                      ),
                      style: PomTimerTextStyles.digitTextStyle,
                    ),

                    Row(
                      spacing: 30,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _pomTimer.playTimer();
                          },
                          child: Text("Play"), // TODO change to icons...
                        ),

                        GestureDetector(
                          onTap: () {
                            _pomTimer.pauseTimer();
                          },
                          child: Text("Pause"), // change to icons...
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
              ],
            ),
          ),

          // TAB
          GestureDetector(
            onTap: () {
              isHidden = !isHidden;
              setState(() {});
            },
            child: Container(
              width: tabWidth.toDouble(),
              height: 100,
              color: Colors.blueAccent,
              child: Icon(
                isHidden ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PomTimerGauge extends StatefulWidget {
  const PomTimerGauge({super.key});

  @override
  State<PomTimerGauge> createState() => _PomTimerGaugeState();
}

class _PomTimerGaugeState extends State<PomTimerGauge> {
  late PomTimer _pomTimer;
  double displayTime = 0;

  @override
  void initState() {
    super.initState();
    _pomTimer = PomTimer.singleton;
    _pomTimer.updatePomTimerGauge = () {
      setState(() {
        displayTime = _pomTimer.timeLeftSeconds.toDouble();
      });
    };
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      key: Key('Active'), // Just used to see different SfRadialGauges switching
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: _pomTimer.timeSetWorkSeconds.toDouble(),
          showLabels: false,
          showTicks: false,
          startAngle: 270,
          endAngle: 270,
          axisLineStyle: AxisLineStyle(
            thickness: 1,
            color: Colors.orangeAccent.shade100,
            thicknessUnit: GaugeSizeUnit.factor,
          ),
          pointers: <GaugePointer>[
            RangePointer(
              value: _pomTimer.timeLeftSeconds.toDouble(),
              width: 0.3,
              color: Colors.white,
              pointerOffset: 0.1,
              cornerStyle: CornerStyle.bothFlat,
              sizeUnit: GaugeSizeUnit.factor,
              enableAnimation: true,
              animationDuration: 1000,
              animationType: AnimationType.bounceOut,
            ),
          ],
        ),
      ],
    );
  }
}

class PomTimerGauge2 extends StatefulWidget {
  const PomTimerGauge2({super.key});

  @override
  State<PomTimerGauge2> createState() => _PomTimerGauge2State();
}

class _PomTimerGauge2State extends State<PomTimerGauge2> {
  late PomTimer _pomTimer;
  double displayTime = 0;

  @override
  void initState() {
    super.initState();
    _pomTimer = PomTimer.singleton;
    _pomTimer.updatePomTimerGauge = () {
      setState(() {
        displayTime = _pomTimer.timeLeftSeconds.toDouble();
      });
    };
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Text('Hello');
  }
}

// List of Extra Methods
abstract class PomTimerExtensions {
  static String formatDuration(int totalSeconds) {
    final int hours = (totalSeconds ~/ 3600) % 24;
    final int minutes = (totalSeconds ~/ 60) % 60;
    final int seconds = totalSeconds % 60;

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr';
  }
}

// List of Text Styles for PomTimer
abstract class PomTimerTextStyles {
  static final digitTextStyle = TextStyle(fontSize: 30, color: Colors.amber);
}
