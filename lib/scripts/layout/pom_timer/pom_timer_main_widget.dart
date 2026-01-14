import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer_display_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:pomodoropompurin/scripts/layout/pom_timer/pom_timer_main_active.dart';
import 'package:pomodoropompurin/scripts/layout/pom_timer/pom_timer_main_idle.dart';
import 'package:pomodoropompurin/scripts/memory/asset_manager.dart';

class PomTimerMainWidget extends StatefulWidget {
  const PomTimerMainWidget({super.key});

  @override
  State<PomTimerMainWidget> createState() => _PomTimerMainWidgetState();
}

class _PomTimerMainWidgetState extends State<PomTimerMainWidget>
    with TickerProviderStateMixin {
  final pomTimerDisplayStateManager = PomTimerDisplayStateManager.singleton;

  final assetManager = AssetManager.singleton;
  final purinAreaStateManager = PurinAreaStateManager.singleton;
  String panelDisplayMode = 'Idle';

  int panelWidth = 400;
  int panelHeight = 400;
  int panelFullHeight = 800;

  late double scale;
  final double inputScale = 0.9;
  final double playScale = 1;
  final double pausedScale = 0.3;

  late double position;
  final double inputPosition = 0;
  final double playPostion = 180;
  final double pausePosition = -120;

  /// A widget placeholder that switches between modes
  Widget get pomTimerWidget {
    switch (panelDisplayMode) {
      case 'Active':
        return PomTimerActiveWidget();
      case 'Paused':
        return PomTimerActiveWidget();
      default: // case Idle (or Input)
        return PomTimerIdleWidget();
    }
  }

  @override
  void initState() {
    super.initState();
    pomTimerDisplayStateManager.switchPomTimerMode = (String mode) {
      setState(() {
        panelDisplayMode = mode;
      });
    };

    scale = inputScale;
    position = inputPosition;

    /// Setup State Manager Callbacks
    pomTimerDisplayStateManager.playPomTimerByMain = () {
      setState(() {
        scale = playScale;
        position = playPostion;
      });
    };

    pomTimerDisplayStateManager.pausePomTimerByMain = () {
      setState(() {
        scale = pausedScale;
        position = pausePosition;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return
    // -- PANEL
    SizedBox(
      width: panelWidth.toDouble(),
      height: panelFullHeight.toDouble(),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 600),
            curve: Curves.easeInOutBack,
            left: 0,
            right: 0,
            bottom: position,
            child: AnimatedScale(
              duration: Duration(milliseconds: 600),
              scale: scale,
              curve: Curves.easeInOutBack,
              child: SizedBox(
                width: panelWidth.toDouble(),
                height: panelHeight.toDouble(),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    /// Pudding Background
                    Positioned(
                      right: 0,
                      left: 0,
                      bottom: 0,
                      child: SizedBox(
                        width: panelWidth.toDouble(),
                        height: panelHeight.toDouble(),
                        child: Image.asset(
                          assetManager.flutterAssetPaths['pT_BG']!,
                        ),
                      ),
                    ),

                    /// PomTimerWidget
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: SizedBox(
                        width: panelWidth.toDouble(),
                        height: panelHeight.toDouble(),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          switchInCurve: Curves.easeOut,
                          switchOutCurve: Curves.easeIn,
                          layoutBuilder: (currentChild, previousChildren) {
                            return Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                ...previousChildren,
                                if (currentChild != null) currentChild,
                              ],
                            );
                          },
                          transitionBuilder: (child, animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: ScaleTransition(
                                alignment: Alignment.bottomCenter,
                                scale: Tween(
                                  begin: 0.95,
                                  end: 1.0,
                                ).animate(animation),
                                child: child,
                              ),
                            );
                          },
                          child: pomTimerWidget,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
