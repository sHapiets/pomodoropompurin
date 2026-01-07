import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/layout/pom_timer_display.dart';
import 'package:pomodoropompurin/scripts/layout/prog_calendar_display.dart';
import 'package:pomodoropompurin/scripts/layout/prog_system_display.dart';
import 'package:pomodoropompurin/scripts/layout/purinArea/purin_area.dart';
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
      body: Stack(
        children: [
          /* Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ProgSystemDisplay(), ProgCalendarDisplay()],
          ), */
          GameWidget(game: PurinArea()),
          PomTimerDisplay(),
        ],
      ),
    );
  }
}
