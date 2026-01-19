import 'package:contribution_heatmap/contribution_heatmap.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/calendar/calendar_manager.dart';
import 'package:pomodoropompurin/scripts/core/prog_system.dart';

class ProgCalendarDisplay extends StatefulWidget {
  const ProgCalendarDisplay({super.key});

  @override
  State<ProgCalendarDisplay> createState() => _ProgCalendarDisplayState();
}

class _ProgCalendarDisplayState extends State<ProgCalendarDisplay> {
  final calendarManager = CalendarManager.singleton;

  @override
  void initState() {
    super.initState();

    calendarManager.updateCalendarDisplay(
      DateTime.now().year,
      DateTime.now().month,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: 300,
          height: 350,
          color: const Color.fromARGB(0, 255, 255, 255),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 50,
                child: Container(
                  width: 290,
                  height: 290,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(183, 192, 255, 167),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(95, 1, 66, 152),
                        offset: Offset(10, 10),
                      ),
                    ],
                  ),
                ),
              ),

              Align(
                alignment: AlignmentGeometry.bottomCenter,
                child: Padding(
                  padding: const EdgeInsetsGeometry.fromLTRB(0, 0, 25, 20),
                  child: ListenableBuilder(
                    listenable: calendarManager,
                    builder: (context, child) {
                      return ContributionHeatmap(
                        cellSize: 25,
                        cellSpacing: 5,
                        cellDateTextStyle: const TextStyle(
                          fontFamily: 'Fredoka',
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Color.fromARGB(255, 88, 88, 88),
                        ),
                        splittedMonthView: true,
                        weekdayTextStyle: const TextStyle(
                          fontFamily: 'Fredoka',
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Color.fromARGB(255, 255, 255, 255),
                          shadows: [
                            Shadow(
                              color: Colors.black38,
                              offset: Offset(1.5, 1.5),
                            ),
                          ],
                        ),
                        showMonthLabels: false,
                        showCellDate: true,
                        heatmapColor: HeatmapColor.amber,

                        minDate: DateTime(
                          calendarManager.yearAtDisplay,
                          calendarManager.monthAtDisplay,
                          1,
                        ),
                        maxDate: DateTime(
                          calendarManager.yearAtDisplay,
                          calendarManager.monthAtDisplay,
                          DateTime(
                            calendarManager.yearAtDisplay,
                            calendarManager.monthAtDisplay + 1,
                            0,
                          ).day,
                        ),
                        entries: <ContributionEntry>[
                          for (final entry
                              in calendarManager.calendarMonthAtDisplay)
                            ContributionEntry(
                              entry.dateLogDate,
                              entry.timeSeconds,
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Text(
                  'daily logs',
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                    color: Colors.white,
                    shadows: [
                      Shadow(color: Colors.black38, offset: Offset(3, 3)),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                    shadows: [
                      Shadow(color: Colors.black38, offset: Offset(3, 3)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
