import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/memory/asset_manager.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ProgSystemDisplay extends StatefulWidget {
  const ProgSystemDisplay({super.key});

  @override
  State<ProgSystemDisplay> createState() => _ProgSystemDisplayState();
}

class _ProgSystemDisplayState extends State<ProgSystemDisplay> {
  final assetManager = AssetManager.singleton;

  final expGaugeHeight = 80.0;
  final expGaugeWidth = 80.0;
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(),
      top: 30,
      left: 0,
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
                color: const Color.fromARGB(133, 99, 255, 224),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(31, 147, 11, 11),
                    offset: Offset(7, 7),
                    blurStyle: BlurStyle.inner,
                    spreadRadius: -2,
                  ),
                ],
              ),
              child: Center(
                child: Stack(
                  children: [
                    SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                          radiusFactor: 0.95,
                          minimum: 0,
                          maximum: 1,
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
                              value: 0.7,
                              width: 0.2,
                              color: const Color.fromARGB(202, 255, 255, 255),
                              pointerOffset: 0.08,
                              cornerStyle: CornerStyle.bothFlat,
                              sizeUnit: GaugeSizeUnit.factor,
                              enableAnimation: true,
                              animationDuration: 1000,
                              animationType: AnimationType.bounceOut,
                            ),
                          ],
                        ),
                      ],
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
                                color: Colors.black12,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsetsGeometry.only(top: 10),
                        child: Text(
                          '78',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                            color: const Color.fromARGB(255, 255, 255, 255),
                            shadows: [
                              Shadow(
                                color: Colors.black12,
                                offset: Offset(2, 2),
                              ),
                            ],
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
                  Text(
                    '150,912',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 13,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      shadows: [
                        Shadow(color: Colors.black12, offset: Offset(2, 2)),
                      ],
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
                  Text(
                    '1,980',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 13,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      shadows: [
                        Shadow(color: Colors.black12, offset: Offset(2, 2)),
                      ],
                    ),
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
