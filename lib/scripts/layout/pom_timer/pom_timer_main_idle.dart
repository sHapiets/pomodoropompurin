import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer_display_state_manager.dart';
import 'package:pomodoropompurin/scripts/memory/asset_manager.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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
    timeSetWorkMinutes = (_pomTimer.timeSetWorkSeconds / 60).round();
    timeSetBreakMinutes = (_pomTimer.timeSetBreakSeconds / 60).round();

    gaugeAnimController = AnimationController(
      value: 1.0,
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
                        endAngle: 30,
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

                          WidgetPointer(
                            value: 43,
                            offset: -46.5 * gaugeTween.value,
                            child: GestureDetector(
                              onTapDown: (details) =>
                                  gaugeAnimController.forward(),
                              child: Text(
                                '-focus-',
                                style: TextStyle(
                                  fontFamily: 'Fredoka',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 25 * gaugeTween.value,
                                  color: const Color.fromARGB(
                                    191,
                                    53,
                                    161,
                                    147,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          WidgetPointer(
                            enableDragging: true,
                            value: timeSetWorkMinutes.toDouble(),
                            onValueChangeStart: (value) {
                              gaugeAnimController.forward();
                            },
                            onValueChanged: (value) {
                              timeSetWorkMinutes = value.round();
                              setState(() {});
                            },
                            offset: -103 * gaugeTween.value,
                            child: GestureDetector(
                              onTapDown: (details) =>
                                  gaugeAnimController.forward(),
                              child: Text(
                                '$timeSetWorkMinutes',
                                style: TextStyle(
                                  fontFamily: 'Fredoka',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 45 * gaugeTween.value,
                                  color: const Color.fromARGB(
                                    255,
                                    255,
                                    255,
                                    255,
                                  ),
                                  shadows: [
                                    Shadow(
                                      color: const Color.fromARGB(106, 0, 0, 0),
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          WidgetPointer(
                            enableDragging: true,
                            value: timeSetWorkMinutes.toDouble(),
                            onValueChangeStart: (value) {
                              gaugeAnimController.forward();
                            },
                            onValueChanged: (value) {
                              timeSetWorkMinutes = value.round();
                              setState(() {});
                            },
                            offset: -45 * gaugeTween.value,
                            child: GestureDetector(
                              onTapDown: (details) =>
                                  gaugeAnimController.forward(),
                              child: Container(
                                width: 60 * gaugeTween.value,
                                height: 60 * gaugeTween.value,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  assetManager.flutterAssetPaths['pT_WP']!,
                                ),
                              ),
                            ),
                          ),

                          // ADD WORKPOINTER
                          WidgetPointer(
                            enableDragging: false,
                            value: 86,
                            offset: -48 * gaugeTween.value,
                            child: GestureDetector(
                              onTap: () {
                                gaugeAnimController.forward();
                                setState(() {
                                  if (timeSetWorkMinutes < 90) {
                                    timeSetWorkMinutes += 1;
                                  }
                                });
                              },
                              child: Container(
                                width: 40 * gaugeTween.value,
                                height: 40 * gaugeTween.value,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(0, 255, 255, 255),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.add_circle_rounded,
                                  color: const Color.fromARGB(
                                    121,
                                    53,
                                    161,
                                    147,
                                  ),
                                  size: 25 * gaugeTween.value,
                                ),
                              ),
                            ),
                          ),

                          // SUBTRACT WORKPOINTER
                          WidgetPointer(
                            enableDragging: false,
                            value: 5,
                            offset: -48 * gaugeTween.value,
                            child: GestureDetector(
                              onTap: () {
                                gaugeAnimController.forward();
                                setState(() {
                                  if (timeSetWorkMinutes > 1) {
                                    timeSetWorkMinutes -= 1;
                                  }
                                });
                              },
                              child: Container(
                                width: 40 * gaugeTween.value,
                                height: 40 * gaugeTween.value,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(0, 255, 255, 255),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.remove_circle_rounded,
                                  color: const Color.fromARGB(
                                    121,
                                    53,
                                    161,
                                    147,
                                  ),
                                  size: 25 * gaugeTween.value,
                                ),
                              ),
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
                        startAngle: 180,
                        endAngle: 0,
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

                          WidgetPointer(
                            enableDragging: true,
                            value: timeSetBreakMinutes.toDouble(),
                            onValueChangeStart: (value) {
                              gaugeAnimController.reverse();
                            },
                            onValueChanged: (value) {
                              timeSetBreakMinutes = value.round();
                              setState(() {});
                            },
                            offset: -103 * (1.2 - gaugeTween.value),
                            child: Text(
                              "$timeSetBreakMinutes",
                              style: TextStyle(
                                fontFamily: 'Fredoka',
                                fontWeight: FontWeight.w500,
                                fontSize: 45 * (1.2 - gaugeTween.value),
                                color: const Color.fromARGB(255, 255, 255, 255),
                                shadows: [
                                  Shadow(
                                    color: const Color.fromARGB(106, 0, 0, 0),
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          WidgetPointer(
                            value: 15.5,
                            offset: -46.5 * (1.2 - gaugeTween.value),
                            child: GestureDetector(
                              onTapDown: (details) =>
                                  gaugeAnimController.reverse(),
                              child: IgnorePointer(
                                child: Text(
                                  '-break-',
                                  style: TextStyle(
                                    fontFamily: 'Fredoka',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 25 * (1.2 - gaugeTween.value),
                                    color: const Color.fromARGB(
                                      206,
                                      148,
                                      86,
                                      25,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          WidgetPointer(
                            enableDragging: true,
                            value: timeSetBreakMinutes.toDouble(),
                            onValueChangeStart: (value) {
                              gaugeAnimController.reverse();
                            },
                            onValueChanged: (value) {
                              timeSetBreakMinutes = value.round();
                              setState(() {});
                            },
                            offset: -45 * (1.2 - gaugeTween.value),
                            child: GestureDetector(
                              onTapDown: (details) =>
                                  gaugeAnimController.reverse(),
                              child: Container(
                                width: 60 * (1.2 - gaugeTween.value),
                                height: 60 * (1.2 - gaugeTween.value),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  assetManager.flutterAssetPaths['pT_BP']!,
                                ),
                              ),
                            ),
                          ),

                          // ADD BREAKPOINTER
                          WidgetPointer(
                            enableDragging: false,
                            value: 28.5,
                            offset: -48 * (1.2 - gaugeTween.value),
                            child: GestureDetector(
                              onTap: () {
                                gaugeAnimController.reverse();
                                setState(() {
                                  if (timeSetBreakMinutes < 30) {
                                    timeSetBreakMinutes += 1;
                                  }
                                });
                              },
                              child: Container(
                                width: 40 * (1.2 - gaugeTween.value),
                                height: 40 * (1.2 - gaugeTween.value),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(0, 255, 255, 255),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.add_circle_rounded,
                                  color: const Color.fromARGB(93, 144, 91, 37),
                                  size: 25 * (1.2 - gaugeTween.value),
                                ),
                              ),
                            ),
                          ),

                          // SUBTRACT BREAKPOINTER
                          WidgetPointer(
                            enableDragging: false,
                            value: 2.5,
                            offset: -48 * (1.2 - gaugeTween.value),
                            child: GestureDetector(
                              onTap: () {
                                gaugeAnimController.reverse();
                                setState(() {
                                  if (timeSetBreakMinutes > 1) {
                                    timeSetBreakMinutes -= 1;
                                  }
                                });
                              },
                              child: Container(
                                width: 40 * (1.2 - gaugeTween.value),
                                height: 40 * (1.2 - gaugeTween.value),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(0, 255, 255, 255),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.remove_circle_rounded,
                                  color: const Color.fromARGB(93, 144, 91, 37),
                                  size: 25 * (1.2 - gaugeTween.value),
                                ),
                              ),
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
                      _pomTimer.timeSetBreakSeconds = timeSetBreakMinutes * 60;
                      _pomTimer.playTimer();
                    },
                    shape: CircleBorder(),
                  ),
                ),
              ),
            ),

            Align(
              alignment: AlignmentGeometry.bottomCenter,
              child: Padding(
                padding: const EdgeInsetsGeometry.fromLTRB(70, 0, 0, 145),
                child: IconButton(
                  onPressed: () {
                    if (_pomTimer.loopsSet < 9) {
                      _pomTimer.loopsSet++;
                    }
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.add_circle_rounded,
                    color: Colors.white,
                    shadows: [
                      const Shadow(color: Colors.black12, offset: Offset(2, 2)),
                    ],
                  ),
                ),
              ),
            ),

            Align(
              alignment: AlignmentGeometry.bottomCenter,
              child: Padding(
                padding: const EdgeInsetsGeometry.fromLTRB(0, 0, 70, 145),
                child: IconButton(
                  onPressed: () {
                    if (_pomTimer.loopsSet > 1) {
                      _pomTimer.loopsSet--;
                      setState(() {});
                    }
                  },
                  icon: Icon(
                    Icons.remove_circle_rounded,
                    color: Colors.white,
                    shadows: [
                      const Shadow(color: Colors.black12, offset: Offset(2, 2)),
                    ],
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsetsGeometry.only(bottom: 140),
                child: Text(
                  '${_pomTimer.loopsSet}',
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontWeight: FontWeight.w500,
                    fontSize: 38,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    shadows: [
                      Shadow(
                        color: const Color.fromARGB(106, 0, 0, 0),
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// TOGGLE FOCUS-BREAK DIALS
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsetsGeometry.only(bottom: 90),
                child: IconButton(
                  onPressed: () {
                    if (gaugeTween.status == AnimationStatus.dismissed) {
                      gaugeAnimController.forward();
                    } else {
                      gaugeAnimController.reverse();
                    }
                  },
                  icon: Icon(
                    Icons.swap_horizontal_circle_rounded,
                    size: 30,
                    color: Colors.white,
                    shadows: [
                      const Shadow(color: Colors.black12, offset: Offset(2, 2)),
                    ],
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsetsGeometry.only(bottom: 130),
                child: Text(
                  '-loops-',
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    shadows: [
                      Shadow(
                        color: const Color.fromARGB(106, 0, 0, 0),
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),

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
                      PomTimerDisplayStateManager
                              .singleton
                              .pomTimerState
                              .value =
                          PomTimerStates.exit;
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
