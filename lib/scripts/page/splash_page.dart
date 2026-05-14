import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/authentication/account_manager.dart';
import 'package:pomodoropompurin/scripts/core/acquirables.dart';
import 'package:pomodoropompurin/scripts/core/activity/activity_manager.dart';
import 'package:pomodoropompurin/scripts/core/audio/background_music.dart';
import 'package:pomodoropompurin/scripts/core/event_systems/achievement_events/daily_achievement.dart';
import 'package:pomodoropompurin/scripts/core/event_systems/achievement_events/streak_system.dart';
import 'package:pomodoropompurin/scripts/core/event_systems/misc/sanrio_2026_voting.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer_interrupted_manager.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/prog_system.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/purin_var/purin_var.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_equip_manager.dart';
import 'package:pomodoropompurin/scripts/core/tutorial/tutorial_manager.dart';
import 'package:pomodoropompurin/scripts/core/version_control/client_version_manager.dart';
import 'package:pomodoropompurin/scripts/foundation/client_version.dart';
import 'package:pomodoropompurin/scripts/page/devmode/devmode_splash_page.dart';
import 'package:pomodoropompurin/scripts/foundation/consumable.dart';
import 'package:pomodoropompurin/scripts/foundation/date_log.dart';
import 'package:pomodoropompurin/scripts/foundation/status_conversion.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/purin_area.dart';
import 'package:pomodoropompurin/scripts/memory/database_manager.dart';
import 'package:pomodoropompurin/scripts/page/main_page.dart';
import 'package:pomodoropompurin/scripts/memory/asset_manager.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  final _assetManager = AssetManager.singleton;
  final _accountManager = AccountManager.singleton;
  final _databaseManager = DatabaseManager.singleton;
  final _pomTimer = PomTimer.singleton;
  final pomTimerInterruptedManager = PomTimerInterruptedManager.singleton;
  final _progSystem = ProgSystem.singleton;
  final activityManager = ActivityManager.singleton;
  final dailyAchievement = DailyAchievement.singleton;
  final streakSystem = StreakSystem.singleton;
  final sanrio2026Voting = Sanrio2026Voting.singleton;
  final clientVersionManager = ClientVersionManager.singleton;
  final acquirables = Acquirables.singleton;
  final purin = Purin.singleton;
  final purinAreaEquipManager = PurinAreaEquipManager.singleton;

  late final Widget preloadedMainPage;

  double _progress = 0;
  String _currentStep = "Starting...";
  int _totalSteps = 0;
  int _completedSteps = 0;
  late final List<MapEntry<String, Future<void> Function()>> loadSteps;
  bool _isCancelled = false;

  Completer<bool>? _audioCompleter;
  ValueNotifier<bool> showEnableAudioBool = ValueNotifier(false);
  bool enableAudio = false;

  Widget koupenAnimation = const SizedBox.shrink();
  late Timer? koupenSwitchTimer;
  AnimationController? koupenPositionController;
  Animation<Offset>? koupenPositionAnimation;

  final int maxDots = 3;
  final ValueNotifier dotCounter = ValueNotifier(0);
  late final Timer dotCounterTimer;

  Future<void> showEnableAudioButton() async {
    _audioCompleter = Completer<bool>();
    showEnableAudioBool.value = true;

    enableAudio = await _audioCompleter!.future;
    BackgroundMusic().setEnabled(enableAudio);
    showEnableAudioBool.value = false;
  }

  @override
  void initState() {
    super.initState();

    koupenPositionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    )..repeat(reverse: true);

    koupenPositionAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -0.7)).animate(
          CurvedAnimation(
            parent: koupenPositionController!,
            curve: Curves.easeInOut,
          ),
        );

    loadSteps = [
      MapEntry('Declaring User....', () async {
        _databaseManager.changeUser('yana');
      }),

      MapEntry('Restoring User Progress...', () async {
        _progSystem.loadPomPoints(
          await _databaseManager.userDataLoad('pomPoints'),
        );
        _progSystem.loadOshiriPoints(
          await _databaseManager.userDataLoad('oshiriPoints'),
        );
        _progSystem.loadAccTotalTime(
          await _databaseManager.userDataLoad('accTotalTime'),
        );
        _progSystem.loadAcquiredShoeAchievementBool(
          await _databaseManager.acquiredShoeAchievementLoad(),
        );

        _progSystem.updateLevelSystem();
        _progSystem.oshiriPoints.addListener(_progSystem.updateLevelSystem);

        dailyAchievement.initialize(
          await _databaseManager.statusDailyAchievementLoad(),
        );
        streakSystem.initialize(await _databaseManager.statusStreakLoad());
        sanrio2026Voting.initialize(
          await _databaseManager.statusSanrio2026Load(),
        );
      }),

      MapEntry('Loading Inventories...', () async {
        _progSystem.loadIngridientInventory(
          await _databaseManager.ingridientInventoryLoad(),
        );
        _progSystem.loadConsumableInventory(
          await _databaseManager.consumableInventoryLoad(),
        );
        _progSystem.loadSnacksInventory(
          await _databaseManager.snacksInventoryLoad(),
        );
      }),

      MapEntry('Collecting Date Logs...', () async {
        _progSystem.dateLogList = await _databaseManager.calendarLoad();
      }),

      MapEntry('Restoring Today Progress...', () async {
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

        if (!dayDateLogExists) {
          _progSystem.addDayTimeSeconds(0);
        }

        _progSystem.dayTimeSeconds.value = dayDateLog.timeSeconds;
      }),

      MapEntry('Initializing Activity Manager...', () async {
        activityManager.initialize(
          await _databaseManager.latestActivityLoad(),
          _databaseManager.latestActivitySave,
        );
      }),

      MapEntry('Coordinating VCS...', () async {
        final recordedVersion = ClientVersion.fromVersionNumber(
          await _databaseManager.versionClientLoad(),
        );
        clientVersionManager.initialize(recordedVersion);
      }),

      MapEntry('Calculating Current Status...', () async {
        final savedPurinMetrics = await _databaseManager
            .statusPurinMetricsLoad();

        final inactiveDuration = activityManager
            .getDurationFromLatestActivity();

        final int savedHungerPoints = savedPurinMetrics['hunger'];
        final int savedEnergyPoints = savedPurinMetrics['energy'];

        final initHungerPoints = HungerPointsConversion.fromInactiveDuration(
          savedHungerPoints,
          inactiveDuration,
        );
        final initEnergyPoints = EnergyPointsConversion.fromInactiveDuration(
          savedEnergyPoints,
          inactiveDuration,
        );

        purin.setHungerPoints(initHungerPoints);
        purin.setEnergyPoints(initEnergyPoints);
      }),

      MapEntry('Loading Configurations...', () async {
        _pomTimer.timeSetWorkSeconds = await _databaseManager
            .userConfigTimerLoad('timeSetWorkSeconds');
        _pomTimer.timeSetBreakSeconds = await _databaseManager
            .userConfigTimerLoad('timeSetBreakSeconds');
        _pomTimer.loopsSet = await _databaseManager.userConfigTimerLoad(
          'loopsSet',
        );

        final statusPomTimer = await _databaseManager.statusPomTimerLoad();

        if (statusPomTimer['wasActive'] == true) {
          pomTimerInterruptedManager.wasActive = true;
          pomTimerInterruptedManager.wasTimeTotalSeconds =
              statusPomTimer["wasTimeTotalSeconds"];
          pomTimerInterruptedManager.wasMultiplierTotal =
              statusPomTimer["wasMultiplierTotal"];
        } else {
          pomTimerInterruptedManager.wasActive = false;
        }

        await TutorialManager.singleton.initialize();
      }),

      MapEntry("Setting up Purin's Home...", () async {
        final selectableConfigString = await _databaseManager
            .configSelectablesLoad();

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

        final PurinVar purinVar = PurinVar.values.byName(
          await _databaseManager.configPurinVarLoad(),
        );

        purin.equip(purinVar);
      }),

      MapEntry('Caching Widget Images...', () async {
        await _assetManager.preloadImages(context);
      }),

      MapEntry('Downloading Flame Assets...', () async {
        await _assetManager.preloadFlameImages();
      }),

      MapEntry('Preparing Fonts and Audio...', () async {
        await _assetManager.loadFonts();
        await BackgroundMusic().load('assets/audio/track_playful.mp3');
      }),

      MapEntry('.....', () async {
        await showEnableAudioButton();
      }),

      MapEntry('Initializing...', () async {
        await PurinArea.gameSingleton.onLoad();
        if (clientVersionManager.wasOutdated) {
          await _databaseManager.versionClientSave(
            clientVersionManager.clientVersion,
          );
        }
        await Future.delayed(Duration(seconds: 3));
      }),
    ];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preloadAll();
    });
  }

  Future<void> _runStep(String label, Future<void> Function() task) async {
    if (!mounted || _isCancelled) return;

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
    _totalSteps = loadSteps.length;

    await loadKoupenAnimation();

    dotCounterTimer = Timer.periodic(Duration(milliseconds: 400), (timer) {
      if (_isCancelled) return;
      if (dotCounter.value == 3) {
        dotCounter.value = 0;
        return;
      }
      dotCounter.value = dotCounter.value + 1;
    });

    for (final step in loadSteps) {
      if (_isCancelled) return;
      await _runStep(step.key, step.value);
    }

    if (!mounted || _isCancelled) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => MainPage()),
    );
  }

  Future<void> loadKoupenAnimation() async {
    await _assetManager.preloadSplashImages(context);
    runKoupenAnimation();
  }

  void runKoupenAnimation() {
    final koupenSwitchDuration = Duration(milliseconds: 700);
    bool koupenSwitcher = true;
    koupenSwitchTimer = Timer.periodic(koupenSwitchDuration, (timer) {
      setState(() {
        if (koupenSwitcher) {
          koupenAnimation = Image.asset(
            _assetManager.splashAssetPaths['koupen_loading_1']!,
          );
        } else {
          koupenAnimation = Image.asset(
            _assetManager.splashAssetPaths['koupen_loading_2']!,
          );
        }
        koupenSwitcher = !koupenSwitcher;
      });
    });
  }

  void switchToDevMode() {
    _isCancelled = true;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => DevModeSplashPage()),
    );
  }

  Future<void> showDebugSwitcherDialog() async {
    await showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (context) {
        return Dialog(
          constraints: BoxConstraints(maxWidth: 300, minWidth: 300),
          backgroundColor: const Color.fromARGB(255, 40, 40, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: DefaultTextStyle.merge(
            style: TextStyle(fontFamily: 'Nunito'),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.computer_rounded,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    "Enter Developer-Mode?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "This switches your current session to developer-mode, which uses the Koupen's debug-user dataset. Note that proceeding with an outdated client might cause errors due to backend mismatch.\n\nContinue?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white70,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 22),

                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white70,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            switchToDevMode();
                          },
                          child: const Text(
                            "Switch",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _isCancelled = true;
    dotCounterTimer.cancel();
    koupenPositionController?.dispose();
    koupenSwitchTimer?.cancel();
    super.dispose();
  }

  Widget loadingDot(int count, int disappearLimit) {
    final double size = 15;
    if (count < disappearLimit) {
      return SizedBox.square(dimension: size);
    }
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      body: DefaultTextStyle(
        style: const TextStyle(fontFamily: 'Nunito', color: Colors.white),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Transform.translate(
                offset: Offset(0, 20),
                child: SizedBox(
                  height: 700,
                  width: 300,
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SlideTransition(
                            position:
                                koupenPositionAnimation ??
                                AlwaysStoppedAnimation(Offset.zero),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: SizedBox(
                                height: 100,
                                child: koupenAnimation,
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),
                          Text(
                            'Koupen-chan is fetching your data...',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 50),
                          ValueListenableBuilder(
                            valueListenable: dotCounter,
                            builder: (context, value, child) {
                              return loadingDot(value, 1);
                            },
                          ),
                          const SizedBox(height: 50),
                          ValueListenableBuilder(
                            valueListenable: dotCounter,
                            builder: (context, value, child) {
                              return loadingDot(value, 2);
                            },
                          ),
                          const SizedBox(height: 50),
                          ValueListenableBuilder(
                            valueListenable: dotCounter,
                            builder: (context, value, child) {
                              return loadingDot(value, 3);
                            },
                          ),

                          const SizedBox(height: 50),
                          Text(
                            _currentStep,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 24),

                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: TweenAnimationBuilder(
                              tween: Tween<double>(begin: 0, end: _progress),
                              duration: const Duration(milliseconds: 1200),
                              curve: Curves.easeOutCirc,
                              builder: (context, value, child) {
                                return LinearProgressIndicator(
                                  value: value,
                                  minHeight: 7,
                                  backgroundColor: const Color.fromARGB(
                                    89,
                                    255,
                                    255,
                                    255,
                                  ),
                                  color: Colors.white,
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 14),

                          Text(
                            "${(_progress * 100).toInt()}%",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),

                          const SizedBox(height: 14),

                          ValueListenableBuilder(
                            valueListenable: showEnableAudioBool,
                            builder: (context, show, child) {
                              return AnimatedScale(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOutBack,
                                scale: show ? 1 : 0,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    const Text(
                                      "enable audio....?",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            _audioCompleter?.complete(true);
                                          },
                                          icon: Icon(
                                            Icons.volume_up_rounded,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        IconButton(
                                          onPressed: () {
                                            _audioCompleter?.complete(false);
                                          },
                                          icon: Icon(
                                            Icons.volume_off_rounded,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: showDebugSwitcherDialog,
                          icon: Icon(
                            Icons.computer_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
