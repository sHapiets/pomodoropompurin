import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer.dart';
import 'package:pomodoropompurin/scripts/layout/ui/current_datetime_display.dart';
import 'package:pomodoropompurin/scripts/layout/ui/prog_system_display.dart';
import 'package:pomodoropompurin/scripts/layout/equip_menu/kotatsu_equip_menu.dart';
import 'package:pomodoropompurin/scripts/layout/ui/menu_dial.dart';
import 'package:pomodoropompurin/scripts/layout/pom_timer/pom_timer_display.dart';
import 'package:pomodoropompurin/scripts/layout/prog_calendar_display.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/purin_area.dart';
import 'package:pomodoropompurin/scripts/layout/ui/vignette.dart';
import 'package:pomodoropompurin/scripts/memory/asset_manager.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  final assetManager = AssetManager.singleton;
  final pomTimer = PomTimer.singleton;

  @override
  void initState() {
    super.initState();
    /* 
    pomTimer.disablePurinArea = (bool enableModalBarrier) {
      setState(() {
        _enableModalBarrier = enableModalBarrier;
      });
    }; */
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
          GameWidget(
            game: PurinArea(),
            overlayBuilderMap: {
              "kotatsuMenu": (BuildContext context, PurinArea game) {
                return KotatsuEquipMenu();
              },
            },
          ),
          VignetteUI(visible: true),
          ProgSystemDisplay(),
          CurrentDatetimeDisplay(),
          MenuDial(),
          /*  if (_enableModalBarrier)
            ModalBarrier(
              color: const Color.fromARGB(133, 0, 0, 0),
              dismissible: true,
            ), */
          PomTimerDisplay(),
        ],
      ),
    );
  }
}
