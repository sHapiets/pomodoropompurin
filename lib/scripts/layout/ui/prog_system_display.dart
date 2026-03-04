import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer_display_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/prog_system.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/ui/ui_display_state.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/level_up_manager.dart';
import 'package:pomodoropompurin/scripts/memory/asset_manager.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ProgSystemDisplay extends StatefulWidget {
  const ProgSystemDisplay({super.key});

  @override
  State<ProgSystemDisplay> createState() => _ProgSystemDisplayState();
}

class _ProgSystemDisplayState extends State<ProgSystemDisplay> {
  final assetManager = AssetManager.singleton;
  final progSystem = ProgSystem.singleton;
  final levelUpManager = LevelUpManager.singleton;
  final pomTimerDisplayStateManager = PomTimerDisplayStateManager.singleton;
  final purinAreaStateManager = PurinAreaStateManager.singleton;

  final expGaugeHeight = 80.0;
  final expGaugeWidth = 80.0;

  @override
  void initState() {
    super.initState();

    progSystem.updateLevelSystem();
    progSystem.oshiriPoints.addListener(progSystem.updateLevelSystem);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: UIDisplayState.singleton.hide,
      builder: (context, value, child) {
        return AnimatedPositioned(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          top: 30,
          left: (value) ? -200 : 0,
          child: child!,
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// GAUGE
            Container(
              height: expGaugeHeight,
              width: expGaugeWidth,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color.fromARGB(167, 248, 229, 60),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(167, 183, 129, 43),
                    offset: Offset(5, 5),
                    blurStyle: BlurStyle.inner,
                    spreadRadius: -4,
                  ),
                ],
              ),
              child: Center(
                child: Stack(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: progSystem.oshiriRemainder,
                      builder: (context, value, child) {
                        return SfRadialGauge(
                          axes: <RadialAxis>[
                            RadialAxis(
                              radiusFactor: 0.95,
                              minimum: 0,
                              maximum: (progSystem.oshiriLevel.value == 1)
                                  ? progSystem.oshiriPointsFromLevel[1]
                                        .toDouble()
                                  : (progSystem.oshiriPointsFromLevel[progSystem
                                                .oshiriLevel
                                                .value] -
                                            progSystem
                                                .oshiriPointsFromLevel[progSystem
                                                    .oshiriLevel
                                                    .value -
                                                1])
                                        .toDouble(),
                              showLabels: false,
                              showTicks: false,
                              startAngle: 270,
                              endAngle: 270,
                              axisLineStyle: AxisLineStyle(
                                thickness: 1,
                                color: const Color.fromARGB(0, 0, 0, 0),
                                thicknessUnit: GaugeSizeUnit.factor,
                              ),
                              pointers: <GaugePointer>[
                                /* RangePointer(
                                value: 1,
                                width: 0.1,
                                color: const Color.fromARGB(80, 145, 145, 145),
                                pointerOffset: 0.15,
                                cornerStyle: CornerStyle.bothFlat,
                                sizeUnit: GaugeSizeUnit.factor,
                                enableAnimation: false,
                              ),
                              RangePointer(
                                value: 1,
                                width: 0.1,
                                color: const Color.fromARGB(75, 209, 209, 209),
                                pointerOffset: 0.1,
                                cornerStyle: CornerStyle.bothFlat,
                                sizeUnit: GaugeSizeUnit.factor,
                                enableAnimation: false,
                              ), */
                                RangePointer(
                                  value: progSystem.oshiriRemainder.value
                                      .toDouble(),
                                  width: 0.2,
                                  color: const Color.fromARGB(
                                    197,
                                    255,
                                    255,
                                    255,
                                  ),
                                  pointerOffset: 0.05,
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
                      },
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsetsGeometry.only(bottom: 30),
                        child: Text(
                          'Level',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: const Color.fromARGB(135, 0, 0, 0),
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    /// OSHIRILEVEL TEXT
                    Center(
                      child: Padding(
                        padding: EdgeInsetsGeometry.only(top: 5),
                        child: ListenableBuilder(
                          listenable: progSystem.oshiriLevel,
                          builder: (context, child) {
                            return Text(
                              '${progSystem.oshiriLevel.value}',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: const Color.fromARGB(255, 255, 255, 255),
                                shadows: [
                                  Shadow(
                                    color: const Color.fromARGB(68, 0, 0, 0),
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    Center(
                      child: Padding(
                        padding: EdgeInsetsGeometry.fromLTRB(2, 50, 0, 0),
                        child: Text(
                          '*',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: const Color.fromARGB(255, 169, 105, 62),
                            shadows: [],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// PomPoints
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: GestureDetector(
                      onTap: () => progSystem.addOshiriPoints(100),
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: Image.asset(
                          assetManager.flutterAssetPaths['pP_icon']!,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ValueListenableBuilder(
                      valueListenable: progSystem.pomPoints,
                      builder: (context, value, child) {
                        return Text(
                          NumberFormat(
                            '#,##0',
                            'en_US',
                          ).format(progSystem.pomPoints.value),
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white, // now readable on dark bg
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsetsGeometry.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: Image.asset(
                        assetManager.flutterAssetPaths['pP_icon']!,
                      ),
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: progSystem.dayTimeSeconds,
                    builder: (context, value, child) {
                      return Text(
                        "$value",
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 13,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          shadows: [
                            Shadow(color: Colors.black12, offset: Offset(2, 2)),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
