import 'dart:async';

import 'package:flutter/material.dart';

class CurrentDatetimeDisplay extends StatefulWidget {
  const CurrentDatetimeDisplay({super.key});

  @override
  State<CurrentDatetimeDisplay> createState() => _CurrentDatetimeDisplayState();
}

class _CurrentDatetimeDisplayState extends State<CurrentDatetimeDisplay> {
  DateTime _now = DateTime.now();
  String hour = '';
  String minute = '';
  String second = '';
  String day = '';
  String month = '';
  final monthNames = [
    '', // placeholder for index 0
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
  ];
  String year = '';

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _now = DateTime.now();
      hour = '${(_now.hour % 12 == 0) ? 12 : _now.hour % 12}'.padLeft(2, '0');
      minute = '${_now.minute}'.padLeft(2, '0');
      second = '${_now.second}'.padLeft(2, '0');
      month = monthNames[_now.month];
      day = '${_now.day}';
      year = '${_now.year}';

      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(),
      top: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 30,
              padding: EdgeInsets.fromLTRB(9, 3, 5, 0),
              margin: EdgeInsetsGeometry.only(top: 2),
              decoration: BoxDecoration(
                color: const Color.fromARGB(108, 152, 190, 189),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(3, 3),
                    color: const Color.fromARGB(184, 110, 131, 155),
                  ),
                ],
              ),
              child: Row(
                spacing: 2,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '$hour:$minute',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 20,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: const Color.fromARGB(136, 0, 0, 0),
                          offset: Offset(1.5, 1.5),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    ':$second',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 7,
                      color: Colors.white,
                      shadows: [
                        Shadow(color: Colors.black12, offset: Offset(4, 4)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Text(
              '$month $day, $year',
              style: TextStyle(
                fontFamily: 'Fredoka',
                fontSize: 15,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: const Color.fromARGB(181, 0, 0, 0),
                    offset: Offset(1.5, 1.5),
                    blurRadius: 1,
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
