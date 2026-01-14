import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer_display_state_manager.dart';
import 'package:pomodoropompurin/scripts/memory/asset_manager.dart';
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
  final assetManager = AssetManager.singleton;

  double displayTime = 0;
  late AnimationController gaugeAnimController;
  late Animation<double> gaugeTween;

  late AnimationController buttonAnimController;
  late Animation<double> buttonTween;

  double _value = 0;

  @override
  void initState() {
    super.initState();
    _pomTimer = PomTimer.singleton;
    gaugeAnimController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    gaugeTween = Tween<double>(begin: 0.4, end: 0.8).animate(
      CurvedAnimation(parent: gaugeAnimController, curve: Curves.easeInOutBack),
    );

    buttonAnimController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..repeat(reverse: true);
    buttonTween = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: buttonAnimController, curve: Curves.easeIn),
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
    buttonAnimController.dispose();
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
              bottom: 47,
              child: AnimatedBuilder(
                animation: gaugeAnimController,
                builder: (context, child) {
                  return SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(
                        radiusFactor: gaugeTween.value,
                        minimum: 0,
                        maximum: 120,
                        showLabels: false,
                        showTicks: false,
                        startAngle: 200,
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
                            /*  gradient: SweepGradient(
                              colors: const <Color>[
                                Color.fromARGB(, 204, 196, 249),
                                Color.fromARGB(255, 78, 222, 241),
                              ],
                              stops: const <double>[0, 1],
                            ), */
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
                            markerOffset: -45 * gaugeTween.value,
                            markerType: MarkerType.image,
                            markerHeight: 70 * gaugeTween.value,
                            markerWidth: 70 * gaugeTween.value,
                            imageUrl: assetManager.flutterAssetPaths['pT_WP'],
                          ),
                        ],
                      ),

                      RadialAxis(
                        radiusFactor: 1.2 - gaugeTween.value,
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
                            /* gradient: SweepGradient(
                              colors: const <Color>[
                                Color.fromARGB(255, 255, 255, 255),
                                Color.fromARGB(255, 46, 131, 100),
                              ],
                              stops: const <double>[0, 1],
                            ), */
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
                            markerOffset: -40,
                            markerType: MarkerType.diamond,
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),

            ///
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsetsGeometry.only(bottom: 190),
                child: SizedBox(
                  width: 75,
                  height: 75,
                  child: AnimatedBuilder(
                    animation: buttonAnimController,
                    builder: (context, child) {
                      return ScaleTransition(scale: buttonTween, child: child);
                    },
                    child: Image.asset(
                      assetManager.flutterAssetPaths['pT_SB']!,
                    ),
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsetsGeometry.only(bottom: 185),
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: MaterialButton(
                    onPressed: () {
                      _pomTimer.playTimer();
                    },
                    shape: CircleBorder(),
                  ),
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
