import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer_display_state_manager.dart';

class PomTimerOpenButton extends StatefulWidget {
  const PomTimerOpenButton({super.key});

  @override
  State<PomTimerOpenButton> createState() => _PomTimerOpenButtonState();
}

class _PomTimerOpenButtonState extends State<PomTimerOpenButton>
    with TickerProviderStateMixin {
  final pomTimerDisplayStateManager = PomTimerDisplayStateManager.singleton;
  double openIndicator = 0.0;
  Timer? openTimer;

  late String encourageText;
  late Timer encourageTextChanger;
  final randomForEncourageTexts = Random();
  late int randomEncourageTextIndex = 0;
  List<String> encourageTexts = [
    'ready when you are',
    'little progress counts',
    'one thing at a time',
    '...small steps...',
    'let Purin handle the rest(ing)',
    'what would Purin do?',
  ];

  ///'doing your best is plenty', 'no rush, just focus', 'you can do it',

  @override
  void initState() {
    super.initState();

    /// Initial randomET selection
    encourageText = encourageTexts[0];

    /// Timed ET changer
    encourageTextChanger = Timer.periodic(Duration(seconds: 10), (timer) {
      randomEncourageTextIndex = randomForEncourageTexts.nextInt(
        encourageTexts.length,
      );
      encourageText = encourageTexts[randomEncourageTextIndex];
      setState(() {});
    });
  }

  void buttonHold() {
    openTimer?.cancel();
    openTimer = Timer.periodic(Duration(milliseconds: 16), (openTimer) {
      setState(() {
        openIndicator = (openIndicator + 0.05).clamp(0.0, 1.0);
        if (openIndicator == 1.0) {
          pomTimerDisplayStateManager.openPomTimer();
          pomTimerDisplayStateManager.pomTimerState.value = PomTimerStates.idle;
          openTimer.cancel();
        }
      });
    });
  }

  void buttonCancel() {
    openTimer?.cancel();
    openTimer = Timer.periodic(Duration(milliseconds: 16), (openTimer) {
      setState(() {
        openIndicator = (openIndicator - 0.05).clamp(0.0, 1.0);
      });
    });
  }

  @override
  void dispose() {
    openTimer?.cancel();
    encourageTextChanger.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return // -- TAB
    Container(
      height: 800,
      width: 400,
      padding: EdgeInsets.fromLTRB(0, 650, 0, 30),
      child: Center(
        child: Column(
          children: [
            /* 
            Text(
              "HOLD",
              style: TextStyle(
                fontFamily: 'Fredoka',
                fontSize: 10,
                color: Colors.white,
                shadows: [Shadow(color: Colors.black12, offset: Offset(2, 2))],
              ),
            ), */
            GestureDetector(
              onTapDown: (details) {
                buttonHold();
              },
              onTapUp: (details) {
                buttonCancel();
              },
              onTapCancel: () {
                buttonCancel();
              },
              child: Container(
                width: 50,
                height: 50,
                margin: EdgeInsetsGeometry.only(bottom: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(154, 254, 221, 113),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(100, 209, 92, 29),
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
                child: IconButton(
                  alignment: Alignment.center,

                  iconSize: 35,
                  onPressed: () {},
                  icon: Icon(Icons.timer_sharp, color: Colors.white),
                ),
              ),
            ),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              switchInCurve: Curves.linear,
              switchOutCurve: Curves.linear,
              transitionBuilder: (child, animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: Text(
                encourageText,
                key: Key(encourageText),
                style: TextStyle(
                  fontFamily: 'Fredoka',
                  fontSize: 15,
                  color: Colors.white,
                  shadows: [
                    Shadow(color: Colors.black12, offset: Offset(2, 2)),
                  ],
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 10),
              width: 60,
              child: LinearProgressIndicator(
                value: openIndicator,
                color: Colors.white,
                backgroundColor: const Color.fromARGB(130, 51, 91, 111),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
