import 'package:contribution_heatmap/contribution_heatmap.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/prog_system.dart';

class ProgCalendarDisplay extends StatefulWidget {
  const ProgCalendarDisplay({super.key});

  @override
  State<ProgCalendarDisplay> createState() => _ProgCalendarDisplayState();
}

class _ProgCalendarDisplayState extends State<ProgCalendarDisplay> {
  final _progSystem = ProgSystem.singleton;

  @override
  Widget build(BuildContext context) {
    return ContributionHeatmap(
      cellSize: 25,
      cellSpacing: 5,
      cellDateTextStyle: TextStyle(fontSize: 15),
      splittedMonthView: true,
      showCellDate: true,
      weekdayLabel: WeekdayLabel.none,
      heatmapColor: HeatmapColor.amber,
      entries: <ContributionEntry>[
        for (final entry in _progSystem.dateLogList)
          ContributionEntry(entry.dateLogDate, entry.timeSeconds),
      ],
    );
  }
}
