import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/kitchen/kitchen_processor.dart';
import 'package:pomodoropompurin/scripts/core/kitchen/stove.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer.dart';
import 'package:pomodoropompurin/scripts/layout/menu/kitchen/kitchen_menu.dart';
import 'package:pomodoropompurin/scripts/layout/menu/purin/purin_equip_menu.dart';
import 'package:pomodoropompurin/scripts/layout/position_menu/purin_position_menu.dart';
import 'package:pomodoropompurin/scripts/layout/purin/purin_main_menu.dart';
import 'package:pomodoropompurin/scripts/layout/ui/current_datetime_display.dart';
import 'package:pomodoropompurin/scripts/layout/ui/prog_system_display.dart';
import 'package:pomodoropompurin/scripts/layout/menu/kotatsu/kotatsu_equip_menu.dart';
import 'package:pomodoropompurin/scripts/layout/ui/menu_dial.dart';
import 'package:pomodoropompurin/scripts/layout/pom_timer/pom_timer_display.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/purin_area.dart';
import 'package:pomodoropompurin/scripts/layout/ui/ui_block.dart';
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
            game: PurinArea.gameSingleton,
            overlayBuilderMap: {
              "purinEquipMenu": (BuildContext context, PurinArea game) {
                return PurinEquipMenu();
              },
              "purinPositionMenu": (BuildContext context, PurinArea game) {
                return PurinPositionMenu();
              },
              "purinMainMenu": (BuildContext context, PurinArea game) {
                return PurinMainMenu();
              },

              "kotatsuMenu": (BuildContext context, PurinArea game) {
                return KotatsuEquipMenu();
              },
              "stoveMenu": (BuildContext context, PurinArea game) {
                return KitchenMenu(kitchenProcessor: Stove.singleton);
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
