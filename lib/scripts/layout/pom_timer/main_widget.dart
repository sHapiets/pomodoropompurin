import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:pomodoropompurin/scripts/layout/pom_timer/main_active.dart';
import 'package:pomodoropompurin/scripts/layout/pom_timer/main_idle.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class PomTimerMainWidget extends StatefulWidget {
  const PomTimerMainWidget({super.key});

  @override
  State<PomTimerMainWidget> createState() => _PomTimerMainWidgetState();
}

class _PomTimerMainWidgetState extends State<PomTimerMainWidget> {
  late PomTimer _pomTimer;
  final purinAreaStateManager = PurinAreaStateManager.singleton;
  double displayTime = 0;
  int maxTime = 1;
  String panelDisplayMode = 'Idle';
  String widgetPositionState = 'Tab';

  int panelWidth = 400;
  int panelHeight = 400;
  int tabWidth = 100;

  double gaugeRadius = 400;

  /// A widget placeholder that switches between modes
  Widget get pomTimerWidget {
    switch (panelDisplayMode) {
      case 'Active':
        return PomTimerActiveWidget();
      case 'Paused':
        return PomTimerActiveWidget();
      default: // case Idle (or Input)
        return PomTimerIdleWidget();
    }
  }

  @override
  void initState() {
    super.initState();
    _pomTimer = PomTimer.singleton;
    _pomTimer.updatePomTimerCount = () {
      setState(() {
        displayTime = _pomTimer.timeLeftSeconds.toDouble();
      });
    };
    _pomTimer.updatePomTimerGauge = () {
      setState(() {
        maxTime = (_pomTimer.onBreak)
            ? _pomTimer.timeSetBreakSeconds
            : _pomTimer.timeSetWorkSeconds;
      });
    };
    _pomTimer.switchPomTimerMode = (String mode) {
      setState(() {
        panelDisplayMode = mode;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return
    // -- PANEL
    SizedBox(
      width: panelWidth.toDouble(),
      height: panelHeight.toDouble(),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          /* Positioned(
            left: 0,
            right: 0,
            bottom: -gaugeRadius / 2 + 80,
            child: IgnorePointer(
              child: SizedBox(
                width: gaugeRadius,
                height: gaugeRadius,
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

                          markerOffset: -70,
                          markerType: MarkerType.image,
                          markerHeight: 50,
                          markerWidth: 50,
                          elevation: 3,
                          imageUrl: 'images/pomPoints_icon.png',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ), */
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              layoutBuilder: (currentChild, previousChildren) {
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ...previousChildren,
                    if (currentChild != null) currentChild,
                  ],
                );
              },
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    alignment: Alignment.bottomCenter,
                    scale: Tween(begin: 0.95, end: 1.0).animate(animation),
                    child: child,
                  ),
                );
              },
              child: pomTimerWidget,
            ),
          ),
        ],
      ),
    );
  }
}
