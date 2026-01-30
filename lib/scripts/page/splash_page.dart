import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/acquirables.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer.dart';
import 'package:pomodoropompurin/scripts/core/prog_system.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_equip_manager.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/purin_area.dart';
import 'package:pomodoropompurin/scripts/memory/database_manager.dart';
import 'package:pomodoropompurin/scripts/page/main_page.dart';
import 'package:pomodoropompurin/scripts/memory/asset_manager.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _assetManager = AssetManager.singleton;
  final _databaseManager = DatabaseManager.singleton;
  final _pomTimer = PomTimer.singleton;
  final _progSystem = ProgSystem.singleton;
  final acquirables = Acquirables.singleton;
  final purinAreaEquipManager = PurinAreaEquipManager.singleton;

  late final Widget preloadedMainPage;

  final minimumDuration = Duration(seconds: 1); // minimum splash time
  final startTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    preloadedMainPage = const MainPage();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preloadAll();
    });
  }

  Future<void> _preloadAll() async {
    await _preloadData();
    await _preloadAssets();
    await _preloadPurinArea();

    // Wait for the minimum duration if preloading was too fast
    final elapsed = DateTime.now().difference(startTime);
    if (elapsed < minimumDuration) {
      await Future.delayed(minimumDuration - elapsed);
    }

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => preloadedMainPage),
    );
  }

  Future<void> _preloadPurinArea() async {
    await PurinArea.gameSingleton.onLoad();
  }

  Future<void> _preloadAssets() async {
    // PRELOAD ASSETS HERE!
    await _assetManager.preloadImages(context);
    await _assetManager.preloadFlameImages();
    await _assetManager.loadFonts();
  }

  Future<void> _preloadData() async {
    _progSystem.loadPomPoints(await _databaseManager.userDataLoad('pomPoints'));
    _progSystem.loadMilkJugs(await _databaseManager.userDataLoad('milkJugs'));
    _progSystem.loadOshiriPoints(
      await _databaseManager.userDataLoad('oshiriPoints'),
    );

    _pomTimer.timeSetWorkSeconds = await _databaseManager.userConfigTimerLoad(
      'timeSetWorkSeconds',
    );
    _pomTimer.timeSetBreakSeconds = await _databaseManager.userConfigTimerLoad(
      'timeSetBreakSeconds',
    );
    _pomTimer.loopsSet = await _databaseManager.userConfigTimerLoad('loopsSet');

    // Not actually needed... remove soon
    _progSystem.loadDateLogMonth(
      2026,
      1,
      await _databaseManager.calendarMonthLoad(2026, 1),
    );

    await _databaseManager.configSelectablesLoad().then((
      selectableConfigString,
    ) {
      KotatsuDesigns kotatsuDesign = KotatsuDesigns.values.byName(
        selectableConfigString['kotatsuDesign'],
      );
      purinAreaEquipManager.kotatsu.value =
          acquirables.kotatsus[kotatsuDesign]!;
    });
  }

  Future<void> loadingScreenchuchu() async {}

  @override
  Widget build(BuildContext context) {
    return Stack(children: [Center(child: CircularProgressIndicator())]);
  }
}
