import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ProgSystemDisplay extends StatefulWidget {
  const ProgSystemDisplay({super.key});

  @override
  State<ProgSystemDisplay> createState() => _ProgSystemDisplayState();
}

class _ProgSystemDisplayState extends State<ProgSystemDisplay> {
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: expGaugeHeight,
              width: expGaugeWidth,
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
                              gradient: SweepGradient(
                                colors: const <Color>[
                                  Color.fromARGB(255, 255, 250, 230),
                                  Color.fromARGB(255, 255, 255, 255),
                                ],
                                stops: const <double>[0, 1],
                              ),
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
                      child: Text(
                        '5',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w500,
                          fontSize: 27,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          shadows: [
                            Shadow(color: Colors.black12, offset: Offset(2, 2)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
