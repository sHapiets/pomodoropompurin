import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer_display_state_manager.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

/// >>>>>>>>>>>>>>>>>>>>
/// POM TIMER IDLE WIDGET
/// >>>>>>>>>>>>>>>>>>>>
class PomTimerIdleWidget extends StatefulWidget {
  const PomTimerIdleWidget({super.key});

  @override
  State<PomTimerIdleWidget> createState() => _PomTimerIdleWidgetState();
}

class _PomTimerIdleWidgetState extends State<PomTimerIdleWidget>
    with TickerProviderStateMixin {
  late PomTimer _pomTimer;
  double displayTime = 0;
  late AnimationController gaugeAnimController;
  late Animation<double> gaugeTweenController;

  double _value = 0;

  @override
  void initState() {
    super.initState();
    _pomTimer = PomTimer.singleton;
    gaugeAnimController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    gaugeTweenController = Tween<double>(begin: 0.5, end: 0.95).animate(
      CurvedAnimation(parent: gaugeAnimController, curve: Curves.easeInOutCirc),
    );
  }

  void switchGaugeAnimation(String setting) {
    switch (setting) {
      case 'work':
        gaugeAnimController.forward();
      case 'break':
        gaugeAnimController.reverse();
      default:
    }
  }

  @override
  void dispose() {
    gaugeAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: 400,
        height: 400,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: -50,
              child: AnimatedBuilder(
                animation: gaugeAnimController,
                builder: (context, child) {
                  return SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(
                        radiusFactor: gaugeTweenController.value,
                        minimum: 0,
                        maximum: 120,
                        showLabels: false,
                        showTicks: false,
                        startAngle: 240,
                        endAngle: 40,
                        isInversed: false,
                        axisLineStyle: AxisLineStyle(
                          thickness: 1,
                          color: const Color.fromARGB(0, 255, 255, 255),
                          thicknessUnit: GaugeSizeUnit.factor,
                        ),
                        pointers: <GaugePointer>[
                          RangePointer(
                            value: 120,
                            width: 0.25,
                            color: const Color.fromARGB(255, 255, 255, 255),
                            gradient: SweepGradient(
                              colors: const <Color>[
                                Color.fromARGB(201, 204, 196, 249),
                                Color.fromARGB(183, 78, 222, 241),
                              ],
                              stops: const <double>[0, 1],
                            ),
                            pointerOffset: 0.1,
                            cornerStyle: CornerStyle.bothCurve,
                            sizeUnit: GaugeSizeUnit.factor,
                          ),
                          MarkerPointer(
                            enableDragging: true,
                            value: _value,
                            onValueChangeStart: (value) {
                              gaugeAnimController.forward();
                            },
                            onValueChanged: (value) {
                              _value = value;
                              setState(() {});
                            },
                            markerOffset: -45,
                            markerType: MarkerType.diamond,
                          ),
                        ],
                      ),

                      RadialAxis(
                        radiusFactor: 1.4 - gaugeTweenController.value,
                        minimum: 0,
                        maximum: 360,
                        showLabels: false,
                        showTicks: false,
                        startAngle: 160,
                        endAngle: 300,
                        isInversed: true,
                        axisLineStyle: AxisLineStyle(
                          thickness: 1,
                          color: const Color.fromARGB(0, 104, 104, 104),
                          thicknessUnit: GaugeSizeUnit.factor,
                        ),

                        pointers: <GaugePointer>[
                          RangePointer(
                            value: 360,
                            width: 0.25,
                            color: const Color.fromARGB(255, 255, 255, 255),
                            gradient: SweepGradient(
                              colors: const <Color>[
                                Color.fromARGB(199, 239, 249, 152),
                                Color.fromARGB(183, 28, 243, 82),
                              ],
                              stops: const <double>[0, 1],
                            ),
                            pointerOffset: 0.1,
                            cornerStyle: CornerStyle.bothCurve,
                            sizeUnit: GaugeSizeUnit.factor,
                          ),
                          MarkerPointer(
                            enableDragging: true,
                            value: _value,
                            onValueChangeStart: (value) {
                              gaugeAnimController.reverse();
                            },
                            onValueChanged: (value) {
                              _value = value;
                              setState(() {});
                            },
                            markerOffset: -45,
                            markerType: MarkerType.diamond,
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),

            Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              child: SizedBox(
                child: MaterialButton(
                  onPressed: () {
                    _pomTimer.playTimer();
                  },
                  child: Text('play'),
                ),
              ),
            ),

            MaterialButton(
              onPressed: () {
                PomTimerDisplayStateManager.singleton.closePomTimer();
              },
              child: Icon(Icons.accessible_forward),
            ),
          ],
        ),
      ),
    );
  }
}
