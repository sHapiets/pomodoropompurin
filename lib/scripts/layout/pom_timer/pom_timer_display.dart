import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class PomTimerDisplay extends StatefulWidget {
  const PomTimerDisplay({super.key});

  @override
  State<PomTimerDisplay> createState() => _PomTimerDisplayState();
}

class _PomTimerDisplayState extends State<PomTimerDisplay> {
  late PomTimer _pomTimer;
  final purinAreaStateManager = PurinAreaStateManager.singleton;
  double displayTime = 0;
  String panelDisplayMode = 'Idle';
  String widgetPositionState = 'Tab';

  int panelWidth = 300;
  int panelHeight = 250;
  int tabWidth = 100;

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

  double get positionFromState {
    switch (widgetPositionState) {
      case 'Tab':
        return (-panelWidth).toDouble();
      case 'Show':
        return 10;
      case 'Hidden':
        return (panelWidth + tabWidth).toDouble();
      default:
        return 10;
    }
  }

  @override
  void initState() {
    super.initState();
    _pomTimer = PomTimer.singleton;
    _pomTimer.updatePomTimerCount = () {
      setState(() {
        displayTime = _pomTimer.timeLeftSeconds.toDouble();
      });
    };
    _pomTimer.switchPomTimerMode = (String mode) {
      setState(() {
        panelDisplayMode = mode;
      });
    };
  }

  /// >>>>>>>>>>>>>>>>>>>>>
  /// PomTimer Widget Build
  /// >>>>>>>>>>>>>>>>>>>>>
  @override
  Widget build(BuildContext context) {
    // Animation for TABSLIDING
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubicEmphasized,
      top: 100,
      right: positionFromState,
      child: Row(
        children: [
          // -- TAB
          GestureDetector(
            onTap: () {
              if (widgetPositionState == 'Tab') {
                widgetPositionState = 'Show';
              } else if (widgetPositionState == 'Show') {
                widgetPositionState = 'Tab';
              }
              setState(() {});
            },
            child: SizedBox(
              height: 100,
              width: 100,
              child: Image.asset('assets/images/L8.jpg'),
            ),
          ),

          // -- PANEL
          Container(
            width: panelWidth.toDouble(),
            height: panelHeight.toDouble(),
            color: Colors.blueGrey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //
                SizedBox(
                  width: panelWidth.toDouble(),
                  height: panelHeight.toDouble(),
                  // Animation for MODE SWITCHING (not Panel)
                  child: AnimatedSwitcher(
                    switchInCurve: Curves.linearToEaseOut,
                    switchOutCurve: Curves.linear,
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: ScaleTransition(
                              scale: Tween<double>(
                                begin: 0.8,
                                end: 1.0,
                              ).animate(animation),
                              child: child,
                            ),
                          );
                        },
                    child: pomTimerWidget,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PomTimerActiveWidget extends StatefulWidget {
  const PomTimerActiveWidget({super.key});

  @override
  State<PomTimerActiveWidget> createState() => _PomTimerActiveWidgetState();
}

class _PomTimerActiveWidgetState extends State<PomTimerActiveWidget>
    with TickerProviderStateMixin {
  late PomTimer _pomTimer;
  double displayTime = 0;
  Widget get playOrPauseButton {
    return _pomTimer.isPlaying ? PomTimerPauseButton() : PomTimerPlayButton();
  }

  @override
  void initState() {
    super.initState();
    _pomTimer = PomTimer.singleton;
    _pomTimer.updatePomTimerGauge = () {
      setState(() {
        displayTime = _pomTimer.timeLeftSeconds.toDouble();
      });
    };
  }

  void showWarningEndTimerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(0), // optional
            child: Stack(
              children: [
                Image.asset('assets/images/L8.jpg'),
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Clipped original'),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _pomTimer.endTimer();
                          },
                          child: Text('yes,stop'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _pomTimer.playTimer();
                          },
                          child: Text("cancel"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // PomTimerActive Buttons
        SizedBox(
          height: 200,
          width: 50,
          child: Center(
            child: Column(
              spacing: 30,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: ScaleTransition(
                            scale: Tween<double>(
                              begin: 0.8,
                              end: 1.0,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                  child: playOrPauseButton,
                ),
                GestureDetector(
                  onTap: () {
                    _pomTimer.pauseTimer(); // Pause first
                    showWarningEndTimerDialog();
                  },
                  child: Text("End"), // change to icons...
                ),
              ],
            ),
          ),
        ),

        /// PomTimerActive Gauge
        SizedBox(
          width: 200,
          height: 200,
          child: Stack(
            children: [
              SfRadialGauge(
                key: Key(
                  'Active',
                ), // Just used to see different SfRadialGauges switching
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: _pomTimer.timeSetWorkSeconds.toDouble(),
                    showLabels: false,
                    showTicks: false,
                    startAngle: 270,
                    endAngle: 270,
                    axisLineStyle: AxisLineStyle(
                      thickness: 1,
                      color: Colors.orangeAccent.shade100,
                      thicknessUnit: GaugeSizeUnit.factor,
                    ),
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: _pomTimer.timeLeftSeconds.toDouble(),
                        width: 0.3,
                        color: Colors.white,
                        pointerOffset: 0.1,
                        cornerStyle: CornerStyle.bothFlat,
                        sizeUnit: GaugeSizeUnit.factor,
                        enableAnimation: true,
                        animationDuration: 1000,
                        animationType: AnimationType.bounceOut,
                      ),
                    ],
                  ),
                ],
              ),

              Center(
                child: Text(
                  PomTimerExtensions.formatDuration(_pomTimer.timeLeftSeconds),
                  style: PomTimerTextStyles.digitTextStyle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PomTimerPlayButton extends StatefulWidget {
  const PomTimerPlayButton({super.key});

  @override
  State<PomTimerPlayButton> createState() => _PomTimerPlayButtonState();
}

class _PomTimerPlayButtonState extends State<PomTimerPlayButton> {
  final _pomTimer = PomTimer.singleton;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _pomTimer.playTimer();
      },
      child: Text("Resume"), // TODO change to icons...
    );
  }
}

class PomTimerPauseButton extends StatefulWidget {
  const PomTimerPauseButton({super.key});

  @override
  State<PomTimerPauseButton> createState() => _PomTimerPauseButtonState();
}

class _PomTimerPauseButtonState extends State<PomTimerPauseButton> {
  final _pomTimer = PomTimer.singleton;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _pomTimer.pauseTimer();
      },
      child: Text("Pause"), // change to icons...
    );
  }
}

/// >>>>>>>>>>>>>>>>>>>>
/// POM TIMER IDLE WIDGET
/// >>>>>>>>>>>>>>>>>>>>
class PomTimerIdleWidget extends StatefulWidget {
  const PomTimerIdleWidget({super.key});

  @override
  State<PomTimerIdleWidget> createState() => _PomTimerIdleWidgetState();
}

class _PomTimerIdleWidgetState extends State<PomTimerIdleWidget> {
  late PomTimer _pomTimer;
  double displayTime = 0;

  @override
  void initState() {
    super.initState();
    _pomTimer = PomTimer.singleton;
    _pomTimer.updatePomTimerGauge = () {
      setState(() {
        displayTime = _pomTimer.timeLeftSeconds.toDouble();
      });
    };
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  PomTimerInputField(type: 'Work'),
                  PomTimerInputField(type: 'Break'),
                ],
              ),

              TextButton(
                onPressed: () {
                  _pomTimer.playTimer();
                },
                child: Text('play'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PomTimerInputField extends StatefulWidget {
  final String type;

  const PomTimerInputField({super.key, required this.type});

  @override
  State<PomTimerInputField> createState() => _PomTimerInputFieldState();
}

class _PomTimerInputFieldState extends State<PomTimerInputField> {
  final _pomTimer = PomTimer.singleton;
  int _input = 0;
  String get _inputString => _input.toString().padLeft(2, '0');
  int maxValue = 0;

  @override
  void initState() {
    super.initState();
    maxValue = (widget.type == 'Work') ? 360 : 120;
    _input = (widget.type == 'Work')
        ? _pomTimer.timeSetWorkSeconds
        : _pomTimer.timeSetBreakSeconds;
  }

  void updateSetTimer() {
    switch (widget.type) {
      case 'Work':
        _pomTimer.timeSetWorkSeconds = _input;
      case 'Break':
        _pomTimer.timeSetBreakSeconds = _input;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Row(
            spacing: 5,
            children: [
              GestureDetector(
                onTap: () {
                  if (_input > 4) {
                    _input -= 5;
                    updateSetTimer();
                    setState(() {});
                  }
                },
                child: (_input > 4)
                    ? Text('-5')
                    : Text(''), // TODO: Change to Image button or smthing
              ),
              Text(_inputString),
              GestureDetector(
                onTap: () {
                  if (_input < maxValue - 4) {
                    _input += 5;
                    updateSetTimer();
                    setState(() {});
                  }
                },
                child: (_input < maxValue - 4)
                    ? Text('+5')
                    : Text(''), // TODO: Change to Image button or smthing
              ),
            ],
          ),
          Row(spacing: 10, children: [Text('-1'), Text('+1')]),
        ],
      ),
    );
  }
}

// List of Extra Methods
abstract class PomTimerExtensions {
  static String formatDuration(int totalSeconds) {
    final int hours = (totalSeconds ~/ 3600) % 24;
    final int minutes = (totalSeconds ~/ 60) % 60;
    final int seconds = totalSeconds % 60;

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr';
  }
}

// List of Text Styles for PomTimer
abstract class PomTimerTextStyles {
  static final digitTextStyle = TextStyle(
    fontSize: 20,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );
}
