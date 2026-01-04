import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/layout/item_display/item_display_area.dart';
import 'package:pomodoropompurin/scripts/layout/pom_timer_display.dart';
import 'package:pomodoropompurin/scripts/layout/prog_calendar_display.dart';
import 'package:pomodoropompurin/scripts/layout/prog_system_display.dart';
import 'package:pomodoropompurin/scripts/memory/asset_manager.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final assetManager = AssetManager.singleton;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProgSystemDisplay(),
          PomTimerDisplay(),
          ProgCalendarDisplay(),
        ],
      ),
    );
  }
}
