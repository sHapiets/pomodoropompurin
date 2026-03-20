import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer_display_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:pomodoropompurin/scripts/layout/pom_timer/pom_timer_main_active.dart';
import 'package:pomodoropompurin/scripts/layout/pom_timer/pom_timer_main_break.dart';
import 'package:pomodoropompurin/scripts/layout/pom_timer/pom_timer_main_idle.dart';
import 'package:pomodoropompurin/scripts/layout/pom_timer/pom_timer_main_pause.dart';
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

  late void Function() updatePomTimerWidget;

  int panelWidth = 400;
  int panelHeight = 400;
  int panelFullHeight = 800;

  late double scale;
  final double inputScale = 0.9;
  final double playScale = 1;
  final double pausedScale = 0.3;

  late double position;
  final double inputPosition = 0;
  double get playPositionDynamic {
    final screenHeight = MediaQuery.of(context).size.height;
    return (screenHeight - panelHeight) / 2;
  }

  final double pausePosition = -120;

  double get backgroundPostion {
    switch (pomTimerDisplayStateManager.pomTimerState.value) {
      case PomTimerStates.play:
        return 35;
      default:
        return 0;
    }
  }

  /// A widget placeholder that switches between modes
  Widget pomTimerWidget = PomTimerIdleWidget();

  @override
  void initState() {
    super.initState();

    scale = inputScale;
    position = inputPosition;

    updatePomTimerWidget = () {
      setState(() {
        switch (pomTimerDisplayStateManager.pomTimerState.value) {
          case PomTimerStates.exit:
            pomTimerWidget = PomTimerIdleWidget();
            scale = inputScale;
            position = inputPosition;
          case PomTimerStates.idle:
            pomTimerWidget = PomTimerIdleWidget();
            scale = inputScale;
            position = inputPosition;
          case PomTimerStates.pause:
            pomTimerWidget = PomTimerPauseWidget();
            scale = pausedScale;
            position = pausePosition;
          case PomTimerStates.play:
            pomTimerWidget = PomTimerActiveWidget();
            scale = playScale;
            position = playPositionDynamic;
          case PomTimerStates.onBreak:
            pomTimerWidget = PomTimerBreakWidget();
            scale = pausedScale;
            position = pausePosition;
        }
      });
    };

    pomTimerDisplayStateManager.pomTimerState.addListener(updatePomTimerWidget);
  }

  @override
  void dispose() {
    pomTimerDisplayStateManager.pomTimerState.removeListener(
      updatePomTimerWidget,
    );
    super.dispose();
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
            curve: Curves.easeInOut,
            left: 0,
            right: 0,
            bottom: position,
            child: AnimatedScale(
              duration: Duration(milliseconds: 600),
              scale: scale,
              curve: Curves.easeInOutCirc,
              child: SizedBox(
                width: panelWidth.toDouble(),
                height: panelHeight.toDouble(),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    /// Pudding BACKGROUND
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 600),
                      curve: Curves.easeInOut,
                      right: 0,
                      left: 0,
                      bottom: backgroundPostion,
                      child: SizedBox(
                        width: panelWidth.toDouble(),
                        height: panelHeight.toDouble(),
                        child: Image.asset(
                          assetManager.flutterAssetPaths['pT_BG']!,
                        ),
                      ),
                    ),

                    /// Pudding FOREGROUND
                    Positioned(
                      right: 0,
                      left: 0,
                      bottom: 0,
                      child: SizedBox(
                        width: panelWidth.toDouble(),
                        height: panelHeight.toDouble(),
                        child: Image.asset(
                          assetManager.flutterAssetPaths['pT_FG']!,
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
                                  begin: 0.1,
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
