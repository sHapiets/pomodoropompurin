import 'dart:async';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/main.dart';
import 'package:pomodoropompurin/scripts/core/audio/background_music.dart';
import 'package:pomodoropompurin/scripts/core/dialog/script_dialog/script_manager.dart';
import 'package:pomodoropompurin/scripts/core/kitchen/chopping_board.dart';
import 'package:pomodoropompurin/scripts/core/kitchen/mixer.dart';
import 'package:pomodoropompurin/scripts/core/kitchen/oven.dart';
import 'package:pomodoropompurin/scripts/core/kitchen/refrigerator.dart';
import 'package:pomodoropompurin/scripts/core/kitchen/stove.dart';
import 'package:pomodoropompurin/scripts/core/kitchen/sink.dart' as sink;
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer_interrupted_manager.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/level_up/level_up_manager.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/shoe_achievement/shoe_achievement_manager.dart';
import 'package:pomodoropompurin/scripts/core/tutorial/tutorial_manager.dart';
import 'package:pomodoropompurin/scripts/core/tutorial/tutorial_state.dart';
import 'package:pomodoropompurin/scripts/core/version_control/client_version_manager.dart';
import 'package:pomodoropompurin/scripts/layout/menu/kitchen/kitchen_menu.dart';
import 'package:pomodoropompurin/scripts/layout/menu/kotatsu/kotatsu_consumable_menu.dart';
import 'package:pomodoropompurin/scripts/layout/menu/purin/purin_equip_menu.dart';
import 'package:pomodoropompurin/scripts/layout/menu/snack/snack_menu.dart';
import 'package:pomodoropompurin/scripts/layout/position_menu/purin_position_menu.dart';
import 'package:pomodoropompurin/scripts/layout/purchase_menu/purchase_menu.dart';
import 'package:pomodoropompurin/scripts/layout/purchase_menu/snack_purchase_menu.dart';
import 'package:pomodoropompurin/scripts/layout/purin/purin_main_menu.dart';
import 'package:pomodoropompurin/scripts/layout/script_dialog/feed_script_widget.dart';
import 'package:pomodoropompurin/scripts/layout/script_dialog/level_up_script_widget.dart';
import 'package:pomodoropompurin/scripts/layout/script_dialog/pet_script_widget.dart';
import 'package:pomodoropompurin/scripts/layout/script_dialog/purin_menu_script_widget.dart';
import 'package:pomodoropompurin/scripts/layout/script_dialog/tutorial_script_widget.dart';
import 'package:pomodoropompurin/scripts/layout/shoe_achievement/shoe_achievement_menu.dart';
import 'package:pomodoropompurin/scripts/layout/ui/current_datetime_display.dart';
import 'package:pomodoropompurin/scripts/layout/ui/purin_metrics/purin_metrics_main_widget.dart';
import 'package:pomodoropompurin/scripts/layout/ui/purin_metrics/purin_metrics_ui.dart';
import 'package:pomodoropompurin/scripts/layout/ui/prog_system_display.dart';
import 'package:pomodoropompurin/scripts/layout/ui/menu_dial.dart';
import 'package:pomodoropompurin/scripts/layout/pom_timer/pom_timer_display.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/purin_area.dart';
import 'package:pomodoropompurin/scripts/layout/ui/ui_block.dart';
import 'package:pomodoropompurin/scripts/layout/version_control/version_notes_dialog.dart';
import 'package:pomodoropompurin/scripts/layout/words_of_wisdom/words_of_wisdom_menu.dart';
import 'package:pomodoropompurin/scripts/memory/asset_manager.dart';
import 'package:pomodoropompurin/scripts/memory/database_manager.dart';
import 'package:pomodoropompurin/scripts/page/tutorial_page_blocker.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

final purinAreaKey = GlobalKey<GameWidgetState>();

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  final assetManager = AssetManager.singleton;
  final pomTimer = PomTimer.singleton;
  final pomTimerInterruptedManager = PomTimerInterruptedManager.singleton;
  final levelUpManager = LevelUpManager.singleton;
  final shoeAchievementManager = ShoeAchievementManager.singleton;
  final scriptManager = ScriptManager.singleton;
  final tutorialManager = TutorialManager.singleton;
  final tutorialState = TutorialState.singleton;
  final clientVersionManager = ClientVersionManager.singleton;

  @override
  void initState() {
    levelUpManager.addListener(showLevelUpDialog);
    shoeAchievementManager.addListener(showShoeAchievementDialog);
    super.initState();
    pomTimerInterruptedManager.rewardInterruptedTime();
    playBackgroundMusic();

    WakelockPlus.enable();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (clientVersionManager.wasOutdated) {
        showLatestVersionNotes();
      }
    });
  }

  Future<void> playBackgroundMusic() async {
    if (tutorialState.loadTutorial == true) {
      return;
    }
    if (BackgroundMusic().enabled == false) {
      return;
    }
    final savedVolume = await DatabaseManager.singleton.configVolumeLoad();
    await BackgroundMusic().setVolume(savedVolume);
    BackgroundMusic().play('assets/audio/track_playful.mp3');
  }

  void showLevelUpDialog() async {
    await showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) {
        return levelUpManager.levelUpDialog;
      },
    );
  }

  void showShoeAchievementDialog() async {
    await showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) {
        return shoeAchievementManager.shoeAchievementDialog;
      },
    );
  }

  void showLatestVersionNotes() {
    showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) {
        return VersionNotesDialog();
      },
    );
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    super.dispose();
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
              "wordsOfWisdomMenu": (BuildContext context, PurinArea game) {
                return WordsOfWisdomMenu();
              },
              "shoeAchievementMenu": (BuildContext context, PurinArea game) {
                return ShoeAchievementMenu();
              },

              "kotatsuMenu": (BuildContext context, PurinArea game) {
                return KotatsuConsumableMenu();
              },
              "stoveMenu": (BuildContext context, PurinArea game) {
                return KitchenMenu(kitchenProcessor: Stove.singleton);
              },
              "refrigeratorMenu": (BuildContext context, PurinArea game) {
                return KitchenMenu(kitchenProcessor: Refrigerator.singleton);
              },
              "sinkMenu": (BuildContext context, PurinArea game) {
                return KitchenMenu(kitchenProcessor: sink.Sink.singleton);
              },
              "choppingMenu": (BuildContext context, PurinArea game) {
                return KitchenMenu(kitchenProcessor: ChoppingBoard.singleton);
              },
              "mixerMenu": (BuildContext context, PurinArea game) {
                return KitchenMenu(kitchenProcessor: Mixer.singleton);
              },
              "ovenMenu": (BuildContext context, PurinArea game) {
                return KitchenMenu(kitchenProcessor: Oven.singleton);
              },
              "snackMenu": (BuildContext context, PurinArea game) {
                return SnackMenu();
              },

              "shopMenu": (BuildContext context, PurinArea game) {
                return PurchaseMenu();
              },
              "snackShopMenu": (BuildContext context, PurinArea game) {
                return SnackPurchaseMenu();
              },
            },
          ),
          ProgSystemDisplay(),
          CurrentDatetimeDisplay(),
          MenuDial(),
          PurinMetricsMainWidget(),
          PurinMetricsUI(),
          UIBlock(),
          PomTimerDisplay(),
          LevelUpScriptWidget(),
          FeedScriptWidget(),
          PetScriptWidget(),
          PurinMenuScriptWidget(),
          TutorialPageBlocker(),
          TutorialScriptWidget(),
        ],
      ),
    );
  }
}
