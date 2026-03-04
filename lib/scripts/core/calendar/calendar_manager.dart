import 'package:flutter/foundation.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/prog_system.dart';
import 'package:pomodoropompurin/scripts/foundation/date_log.dart';

/// A listenable class for the ProgCalendarDisplay widget, which updates or
/// rebuilds when changing the current month in display and/or other data within
/// the list of DataLogs at display.
///
/// To clarify, this also means that this class mostly relates to the DISPLAY state
/// of the calendar when opened, and not of the actual list of DateLogs. The list that you
/// might encounter below is the collection of DateLogs that is currently in display,
/// which changes value throughout the session (e.g. browsing through the months)
///
/// Since DateLogs is a collection of dates that dictates your time usage, they are
/// mostly considered as a progress system in and of itself. Hence, the 'real' list
/// of DateLogs is actually stored in the ProgSystem singleton, where loading is also
/// defined there.
class CalendarManager extends ChangeNotifier {
  CalendarManager._();
  static final singleton = CalendarManager._();

  final progSystem = ProgSystem.singleton;
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
    'December',
    'January',
  ];

  List<DateLog> calendarMonthAtDisplay = [];
  int monthAtDisplay = DateTime.now().month;
  int yearAtDisplay = DateTime.now().year;

  void updateCalendarDisplay(int year, int month) {
    monthAtDisplay = month;
    yearAtDisplay = year;
    calendarMonthAtDisplay = progSystem.dateLogfromMonth(year, month);
    notifyListeners();
  }
}
