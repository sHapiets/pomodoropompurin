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

  int timeSetWorkMinutes = 1;
  int timeSetBreakMinutes = 1;

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
                        minimum: 1,
                        maximum: 90,
                        showLabels: false,
                        showTicks: false,
                        startAngle: 160,
                        endAngle: 320,
                        isInversed: false,
                        axisLineStyle: AxisLineStyle(
                          thickness: 1,
                          color: const Color.fromARGB(0, 255, 255, 255),
                          thicknessUnit: GaugeSizeUnit.factor,
                        ),
                        pointers: <GaugePointer>[
                          RangePointer(
                            value: 360,
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
                            value: timeSetWorkMinutes.toDouble(),
                            onValueChangeStart: (value) {
                              gaugeAnimController.forward();
                            },
                            onValueChanged: (value) {
                              timeSetWorkMinutes = value.round();
                              setState(() {});
                            },
                            markerOffset: -45 * gaugeTween.value,
                            markerType: MarkerType.image,
                            markerHeight: 70 * gaugeTween.value,
                            markerWidth: 70 * gaugeTween.value,
                            imageUrl: assetManager.flutterAssetPaths['pT_WP'],
                          ),
                          MarkerPointer(
                            enableDragging: true,
                            value: timeSetWorkMinutes.toDouble(),
                            onValueChangeStart: (value) {
                              gaugeAnimController.forward();
                            },
                            onValueChanged: (value) {
                              timeSetWorkMinutes = value.round();
                              setState(() {});
                            },
                            markerOffset: -100 * gaugeTween.value,
                            markerType: MarkerType.text,
                            markerHeight: 70 * gaugeTween.value,
                            markerWidth: 70 * gaugeTween.value,
                            /* imageUrl: assetManager.flutterAssetPaths['pT_WP'], */
                            text: '$timeSetWorkMinutes',
                            textStyle: GaugeTextStyle(
                              fontFamily: 'Fredoka',
                              fontWeight: FontWeight.w500,
                              fontSize: 45 * gaugeTween.value,
                              color: const Color.fromARGB(151, 54, 54, 54),
                            ),
                          ),
                          MarkerPointer(
                            enableDragging: true,
                            value: timeSetWorkMinutes.toDouble(),
                            onValueChangeStart: (value) {
                              gaugeAnimController.forward();
                            },
                            onValueChanged: (value) {
                              timeSetWorkMinutes = value.round();
                              setState(() {});
                            },
                            markerOffset: -103 * gaugeTween.value,
                            markerType: MarkerType.text,
                            markerHeight: 70 * gaugeTween.value,
                            markerWidth: 70 * gaugeTween.value,
                            /* imageUrl: assetManager.flutterAssetPaths['pT_WP'], */
                            text: '$timeSetWorkMinutes',
                            textStyle: GaugeTextStyle(
                              fontFamily: 'Fredoka',
                              fontWeight: FontWeight.w500,
                              fontSize: 45 * gaugeTween.value,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ],
                      ),

                      RadialAxis(
                        radiusFactor: 1.2 - gaugeTween.value,
                        minimum: 1,
                        maximum: 30,
                        showLabels: false,
                        showTicks: false,
                        startAngle: 220,
                        endAngle: 30,
                        isInversed: false,
                        axisLineStyle: AxisLineStyle(
                          thickness: 1,
                          color: const Color.fromARGB(0, 104, 104, 104),
                          thicknessUnit: GaugeSizeUnit.factor,
                        ),

                        pointers: <GaugePointer>[
                          RangePointer(
                            value: 120,
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
                            value: timeSetBreakMinutes.toDouble(),
                            onValueChangeStart: (value) {
                              gaugeAnimController.reverse();
                            },
                            onValueChanged: (value) {
                              timeSetBreakMinutes = value.round();
                              setState(() {});
                            },
                            markerOffset: -40 * (1.2 - gaugeTween.value),
                            markerType: MarkerType.diamond,
                          ),

                          MarkerPointer(
                            enableDragging: true,
                            value: timeSetBreakMinutes.toDouble(),
                            onValueChangeStart: (value) {
                              gaugeAnimController.reverse();
                            },
                            onValueChanged: (value) {
                              timeSetBreakMinutes = value.round();
                              setState(() {});
                            },
                            markerOffset: -100 * (1.2 - gaugeTween.value),
                            markerType: MarkerType.text,
                            text: '$timeSetBreakMinutes',
                            textStyle: GaugeTextStyle(
                              fontFamily: 'Fredoka',
                              fontWeight: FontWeight.w500,
                              fontSize: 45 * (1.2 - gaugeTween.value),
                              color: const Color.fromARGB(151, 54, 54, 54),
                            ),
                          ),
                          MarkerPointer(
                            enableDragging: true,
                            value: timeSetBreakMinutes.toDouble(),
                            onValueChangeStart: (value) {
                              gaugeAnimController.reverse();
                            },
                            onValueChanged: (value) {
                              timeSetBreakMinutes = value.round();
                              setState(() {});
                            },
                            markerOffset: -103 * (1.2 - gaugeTween.value),
                            markerType: MarkerType.text,
                            text: '$timeSetBreakMinutes',
                            textStyle: GaugeTextStyle(
                              fontFamily: 'Fredoka',
                              fontWeight: FontWeight.w500,
                              fontSize: 45 * (1.2 - gaugeTween.value),
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),

            /// PomTimer PlayButton Image (red cherry)
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

            /// Play PomTimer Button
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsetsGeometry.only(bottom: 185),
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: MaterialButton(
                    onPressed: () {
                      _pomTimer.timeSetWorkSeconds = timeSetWorkMinutes * 60;
                      _pomTimer.playTimer();
                    },
                    shape: CircleBorder(),
                  ),
                ),
              ),
            ),

            /* 
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsetsGeometry.only(bottom: 50),
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: 
                ),
              ),
            ), */

            /// ClosePomTimerButton
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsetsGeometry.only(bottom: 20),
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: IconButton(
                    iconSize: 45,
                    onPressed: () {
                      PomTimerDisplayStateManager.singleton.closePomTimer();
                    },
                    icon: Icon(
                      Icons.arrow_drop_down_circle_rounded,
                      color: const Color.fromARGB(255, 255, 224, 130),
                      shadows: [
                        Shadow(
                          color: const Color.fromARGB(172, 252, 165, 42),
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
