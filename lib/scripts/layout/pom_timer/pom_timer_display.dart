import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer_display_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class PomTimerDisplay extends StatefulWidget {
  const PomTimerDisplay({super.key});

  @override
  State<PomTimerDisplay> createState() => _PomTimerDisplayState();
}

class _PomTimerDisplayState extends State<PomTimerDisplay> {
  final PomTimer _pomTimer = PomTimer.singleton;
  final purinAreaStateManager = PurinAreaStateManager.singleton;
  final pomTimerDisplayStateManager = PomTimerDisplayStateManager.singleton;
  late Widget pomTimerAtDisplay;

  @override
  void initState() {
    super.initState();
    pomTimerAtDisplay = PomTimerOpenButton();
    pomTimerDisplayStateManager.openPomTimer = () {
      setState(() {
        pomTimerAtDisplay = PomTimerMainWidget();
      });
    };
    pomTimerDisplayStateManager.closePomTimer = () {
      setState(() {
        pomTimerAtDisplay = PomTimerOpenButton();
      });
    };
  }

  /// >>>>>>>>>>>>>>>>>>>>>
  ///
  /// >>>>>>>>>>>>>>>>>>>>>
  @override
  Widget build(BuildContext context) {
    // Animation for Opening Widget
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 1000),
        switchInCurve: Curves.easeOutExpo,
        switchOutCurve: Curves.linear,
        layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ...previousChildren,
              if (currentChild != null) currentChild,
            ],
          );
        },
        transitionBuilder: (Widget child, Animation<double> animation) {
          final slideAnimation = Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation);

          return FadeTransition(
            opacity: animation,
            child: SlideTransition(position: slideAnimation, child: child),
          );
        },
        child: pomTimerAtDisplay, // MUST have a Key
      ),
    );
  }
}

class PomTimerOpenButton extends StatefulWidget {
  const PomTimerOpenButton({super.key});

  @override
  State<PomTimerOpenButton> createState() => _PomTimerOpenButtonState();
}

class _PomTimerOpenButtonState extends State<PomTimerOpenButton> {
  final pomTimerDisplayStateManager = PomTimerDisplayStateManager.singleton;
  @override
  Widget build(BuildContext context) {
    return // -- TAB
    Container(
      height: 400,
      width: 400,
      padding: EdgeInsets.fromLTRB(150, 250, 150, 50),
      child: Center(
        child: MaterialButton(
          onPressed: () => pomTimerDisplayStateManager.openPomTimer(),
          child: Image.asset('assets/images/L8.jpg'),
        ),
      ),
    );
  }
}

class PomTimerMainWidget extends StatefulWidget {
  const PomTimerMainWidget({super.key});

  @override
  State<PomTimerMainWidget> createState() => _PomTimerMainWidgetState();
}

class _PomTimerMainWidgetState extends State<PomTimerMainWidget> {
  late PomTimer _pomTimer;
  final purinAreaStateManager = PurinAreaStateManager.singleton;
  double displayTime = 0;
  int maxTime = 1;
  String panelDisplayMode = 'Idle';
  String widgetPositionState = 'Tab';

  int panelWidth = 400;
  int panelHeight = 400;
  int tabWidth = 100;

  double gaugeRadius = 400;

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
    _pomTimer = PomTimer.singleton;
    _pomTimer.updatePomTimerCount = () {
      setState(() {
        displayTime = _pomTimer.timeLeftSeconds.toDouble();
      });
    };
    _pomTimer.updatePomTimerGauge = () {
      setState(() {
        maxTime = (_pomTimer.onBreak)
            ? _pomTimer.timeSetBreakSeconds
            : _pomTimer.timeSetWorkSeconds;
      });
    };
    _pomTimer.switchPomTimerMode = (String mode) {
      setState(() {
        panelDisplayMode = mode;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return
    // -- PANEL
    SizedBox(
      width: panelWidth.toDouble(),
      height: panelHeight.toDouble(),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: -gaugeRadius / 2,
            child: SizedBox(
              width: gaugeRadius,
              height: gaugeRadius,
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    radiusFactor: 0.95,
                    minimum: 0,
                    maximum: maxTime.toDouble(),
                    showLabels: false,
                    showTicks: false,
                    startAngle: 180,
                    endAngle: 0,
                    axisLineStyle: AxisLineStyle(
                      thickness: 1,
                      color: const Color.fromARGB(255, 255, 209, 145),
                      thicknessUnit: GaugeSizeUnit.factor,
                    ),
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: _pomTimer.timeLeftSeconds.toDouble(),
                        width: 0.3,
                        color: const Color.fromARGB(255, 255, 255, 255),
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
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
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
                    scale: Tween(begin: 0.95, end: 1.0).animate(animation),
                    child: child,
                  ),
                );
              },
              child: pomTimerWidget,
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
    return Align(
      alignment: Alignment.bottomCenter,
      child: Text(
        PomTimerExtensions.formatDuration(_pomTimer.timeLeftSeconds),
        style: PomTimerTextStyles.digitTextStyle,
      ),
    );

    // PomTimerActive Buttons
    /* SizedBox(
          height: 200,
          width: 50,
          child: Center(
            child: Row(
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
        ), */
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
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
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

          MaterialButton(
            onPressed: () {
              PomTimerDisplayStateManager.singleton.closePomTimer();
            },
            child: Icon(Icons.accessible_forward),
          ),
        ],
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
