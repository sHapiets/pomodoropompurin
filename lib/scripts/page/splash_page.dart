import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer.dart';
import 'package:pomodoropompurin/scripts/core/prog_system.dart';
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

  final minimumDuration = Duration(seconds: 1); // minimum splash time
  final startTime = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _preloadAll() async {
    await _preloadData();
    await _preloadAssets();

    // Wait for the minimum duration if preloading was too fast
    final elapsed = DateTime.now().difference(startTime);
    if (elapsed < minimumDuration) {
      await Future.delayed(minimumDuration - elapsed);
    }

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => MainPage()),
    );
  }

  Future<void> _preloadAssets() async {
    // PRELOAD ASSETS HERE!
    await _assetManager.preloadImages(context);
    await _assetManager.preloadFlameImages();
    await _assetManager.loadFonts();
  }

  Future<void> _preloadData() async {
    // Database loading
    _progSystem.loadPomPoints(await _databaseManager.userDataLoad('pomPoints'));
    _progSystem.loadMilkJugs(await _databaseManager.userDataLoad('milkJugs'));

    _pomTimer.timeSetWorkSeconds = await _databaseManager.userConfigTimerLoad(
      'timeSetWorkSeconds',
    );
    _pomTimer.timeSetBreakSeconds = await _databaseManager.userConfigTimerLoad(
      'timeSetBreakSeconds',
    );

    // Not actually needed... remove soon
    _progSystem.loadDateLogList(
      await _databaseManager.calendarMonthLoad(2026, 1),
    );
    DateTime.now();
  }

  Future<void> loadingScreenchuchu() async {}

  @override
  Widget build(BuildContext context) {
    _preloadAll();
    return Center(child: CircularProgressIndicator());
  }
}
