import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer.dart';
import 'package:pomodoropompurin/scripts/layout/equip_menu/purin/purin_equip_menu.dart';
import 'package:pomodoropompurin/scripts/layout/purin/purin_main_menu.dart';
import 'package:pomodoropompurin/scripts/layout/ui/current_datetime_display.dart';
import 'package:pomodoropompurin/scripts/layout/ui/prog_system_display.dart';
import 'package:pomodoropompurin/scripts/layout/equip_menu/kotatsu/kotatsu_equip_menu.dart';
import 'package:pomodoropompurin/scripts/layout/ui/menu_dial.dart';
import 'package:pomodoropompurin/scripts/layout/pom_timer/pom_timer_display.dart';
import 'package:pomodoropompurin/scripts/layout/calendar_display/prog_calendar_display.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/purin_area.dart';
import 'package:pomodoropompurin/scripts/layout/ui/ui_block.dart';
import 'package:pomodoropompurin/scripts/layout/ui/vignette.dart';
import 'package:pomodoropompurin/scripts/memory/asset_manager.dart';

final purinAreaKey = GlobalKey<GameWidgetState>();

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
            key: purinAreaKey,
            game: PurinArea(),
            overlayBuilderMap: {
              "kotatsuMenu": (BuildContext context, PurinArea game) {
                return KotatsuEquipMenu();
              },
              "purinEquipMenu": (BuildContext context, PurinArea game) {
                return PurinEquipMenu();
              },
              "purinMainMenu": (BuildContext context, PurinArea game) {
                return PurinMainMenu();
              },
            },
          ),
          ProgSystemDisplay(),
          CurrentDatetimeDisplay(),
          MenuDial(),
          UIBlock(),
          PomTimerDisplay(),
        ],
      ),
    );
  }
}
