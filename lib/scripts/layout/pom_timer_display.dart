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

  @override
  void initState() {
    super.initState();
    _pomTimer = PomTimer.singleton;
    _pomTimer.updatePomTimerCount = () {
      setState(() {
        displayTime = _pomTimer.timeLeftSeconds.toDouble();
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

  // APPEARANCE
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SfRadialGauge(
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
                  animationType: AnimationType.linear,
                ),
              ],
            ),
          ],
        ),

        // PomTimer Text
        Text(
          PomTimerExtensions.formatDuration(_pomTimer.timeLeftSeconds),
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
              child: Text("Play"), // change to icons...
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
    );
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
