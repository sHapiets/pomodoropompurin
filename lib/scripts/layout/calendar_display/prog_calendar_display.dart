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
              /// BACKGROUND CONT
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

              /// CALENDAR HEATMAP
              Align(
                alignment: AlignmentGeometry.bottomCenter,
                child: Padding(
                  padding: const EdgeInsetsGeometry.fromLTRB(0, 0, 25, 20),
                  child: ListenableBuilder(
                    listenable: calendarManager,
                    builder: (context, child) {
                      return AnimatedSwitcher(
                        duration: Duration(milliseconds: 400),
                        switchInCurve: Curves.easeInOutBack,
                        switchOutCurve: Curves.easeInOutBack,
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: ScaleTransition(
                              scale: animation,
                              child: child,
                            ),
                          );
                        },
                        child: ContributionHeatmap(
                          key: Key(
                            calendarManager.monthNames[calendarManager
                                .monthAtDisplay],
                          ),
                          cellSize: 23,
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
                        ),
                      );
                    },
                  ),
                ),
              ),

              /// HEADER TEXT
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

              /// NEW MONTH TEXT
              Align(
                alignment: AlignmentGeometry.topCenter,
                child: Transform.translate(
                  offset: Offset(0, 65),
                  child: ListenableBuilder(
                    listenable: calendarManager,
                    builder: (context, child) {
                      return Text(
                        calendarManager.monthNames[calendarManager
                            .monthAtDisplay],
                        style: TextStyle(
                          fontFamily: 'Fredoka',
                          fontSize: 24,
                          color: Colors.white,
                          shadows: [
                            Shadow(color: Colors.black38, offset: Offset(1, 1)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),

              // NEW YEAR TEXT
              Align(
                alignment: AlignmentGeometry.topCenter,
                child: Transform.translate(
                  offset: Offset(0, 90),
                  child: ListenableBuilder(
                    listenable: calendarManager,
                    builder: (context, child) {
                      return Text(
                        '${calendarManager.yearAtDisplay}',
                        style: TextStyle(
                          fontFamily: 'Fredoka',
                          fontSize: 15,
                          color: Colors.white,
                          shadows: [
                            Shadow(color: Colors.black38, offset: Offset(1, 1)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),

              /// +1 MONTH
              Positioned(
                top: 65,
                right: 40,
                child: IconButton(
                  onPressed: () {
                    int newMonth = (calendarManager.monthAtDisplay == 12)
                        ? 1
                        : calendarManager.monthAtDisplay + 1;
                    int newYear = (calendarManager.monthAtDisplay == 12)
                        ? calendarManager.yearAtDisplay + 1
                        : calendarManager.yearAtDisplay;
                    calendarManager.updateCalendarDisplay(newYear, newMonth);
                  },
                  icon: Icon(
                    Icons.arrow_right_rounded,
                    color: Colors.white,
                    shadows: [
                      Shadow(color: Colors.black38, offset: Offset(3, 3)),
                    ],
                  ),
                ),
              ),

              /// +1 MONTH
              Positioned(
                top: 65,
                left: 30,
                child: IconButton(
                  onPressed: () {
                    int newMonth = (calendarManager.monthAtDisplay == 1)
                        ? 12
                        : calendarManager.monthAtDisplay - 1;
                    int newYear = (calendarManager.monthAtDisplay == 1)
                        ? calendarManager.yearAtDisplay - 1
                        : calendarManager.yearAtDisplay;

                    calendarManager.updateCalendarDisplay(newYear, newMonth);
                  },
                  icon: Icon(
                    Icons.arrow_left_rounded,
                    color: Colors.white,
                    shadows: [
                      Shadow(color: Colors.black38, offset: Offset(3, 3)),
                    ],
                  ),
                ),
              ),

              /// CLOSE BUTTON
              Positioned(
                top: 15,
                right: 20,
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
