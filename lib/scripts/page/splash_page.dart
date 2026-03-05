import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/acquirables.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/prog_system.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_equip_manager.dart';
import 'package:pomodoropompurin/scripts/foundation/consumable.dart';
import 'package:pomodoropompurin/scripts/foundation/date_log.dart';
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

  final minimumDuration = const Duration(seconds: 1);
  final startTime = DateTime.now();

  double _progress = 0;
  String _currentStep = "Starting...";
  int _totalSteps = 0;
  int _completedSteps = 0;

  @override
  void initState() {
    super.initState();
    preloadedMainPage = const MainPage();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preloadAll();
    });
  }

  Future<void> _runStep(String label, Future<void> Function() task) async {
    if (!mounted) return;

    setState(() {
      _currentStep = label;
    });

    await task();

    _completedSteps++;
    if (!mounted) return;

    setState(() {
      _progress = _completedSteps / _totalSteps;
    });
  }

  Future<void> _preloadAll() async {
    _calculateTotalSteps();

    await _preloadData();
    await _preloadAssets();
    await _preloadPurinArea();

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

  void _calculateTotalSteps() {
    _totalSteps = 13;
    // 10 data loads
    // 3 asset/purin loads
  }

  Future<void> _preloadData() async {
    await _runStep("Loading Pom Points...", () async {
      _progSystem.loadPomPoints(
        await _databaseManager.userDataLoad('pomPoints'),
      );
    });

    await _runStep("Loading Milk Jugs...", () async {
      _progSystem.loadMilkJugs(await _databaseManager.userDataLoad('milkJugs'));
    });

    await _runStep("Loading Oshiri Points...", () async {
      _progSystem.loadOshiriPoints(
        await _databaseManager.userDataLoad('oshiriPoints'),
      );
      _progSystem.loadAccTotalTime(
        await _databaseManager.userDataLoad('accTotalTime'),
      );
    });

    await _runStep("Loading Ingredients...", () async {
      _progSystem.loadIngridientInventory(
        await _databaseManager.ingridientInventoryLoad(),
      );
    });

    await _runStep("Loading Consumables...", () async {
      _progSystem.loadConsumableInventory(
        await _databaseManager.consumableInventoryLoad(),
      );
    });

    await _runStep("Loading Purin Variables...", () async {});

    await _runStep("Loading Calendar...", () async {
      _progSystem.dateLogList = await _databaseManager.calendarLoad();
    });

    await _runStep("Restoring Today Progress...", () async {
      final monthDateLog = _progSystem.dateLogfromMonth(
        DateTime.now().year,
        DateTime.now().month,
      );

      if (monthDateLog == []) {
        _progSystem.addDayTimeSeconds(0);
        return;
      }

      bool dayDateLogExists = false;
      final DateLog dayDateLog = monthDateLog.firstWhere(
        (iterDateLog) {
          dayDateLogExists = true;
          return iterDateLog.dateLogDate.day == DateTime.now().day;
        },
        orElse: () {
          return DateLog(dateLogDate: DateTime.now(), timeSeconds: 0);
        },
      );

      if (dayDateLogExists == false) {
        _progSystem.addDayTimeSeconds(0);
      }

      _progSystem.dayTimeSeconds.value = dayDateLog.timeSeconds;
    });

    await _runStep("Loading Timer Settings...", () async {
      _pomTimer.timeSetWorkSeconds = await _databaseManager.userConfigTimerLoad(
        'timeSetWorkSeconds',
      );
      _pomTimer.timeSetBreakSeconds = await _databaseManager
          .userConfigTimerLoad('timeSetBreakSeconds');
      _pomTimer.loopsSet = await _databaseManager.userConfigTimerLoad(
        'loopsSet',
      );
    });

    await _runStep("Loading Equipped Items...", () async {
      await _databaseManager.configSelectablesLoad().then((
        selectableConfigString,
      ) {
        final kotatsuDesign = KotatsuDesigns.values.byName(
          selectableConfigString['kotatsuDesign'],
        );
        final feedable = Consumable.values.byName(
          selectableConfigString['feedable'],
        );
        final bitesLeft = selectableConfigString['feedableBitesLeft'];

        purinAreaEquipManager.changeKotatsu(
          acquirables.kotatsus[kotatsuDesign]!,
        );

        purinAreaEquipManager.addFeedable(feedable, bitesLeft);
      });
    });
  }

  Future<void> _preloadAssets() async {
    await _runStep("Preloading Images...", () async {
      await _assetManager.preloadImages(context);
    });

    await _runStep("Preloading Flame Assets...", () async {
      await _assetManager.preloadFlameImages();
    });

    await _runStep("Loading Fonts...", () async {
      await _assetManager.loadFonts();
    });
  }

  Future<void> _preloadPurinArea() async {
    await _runStep("Initializing Purin Area...", () async {
      await PurinArea.gameSingleton.onLoad();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Pomodoro Pompurin",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),

              Text(
                _currentStep,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 16),

              LinearProgressIndicator(
                value: _progress,
                minHeight: 8,
                borderRadius: BorderRadius.circular(8),
              ),

              const SizedBox(height: 12),

              Text("${(_progress * 100).toInt()}%"),
            ],
          ),
        ),
      ),
    );
  }
}
