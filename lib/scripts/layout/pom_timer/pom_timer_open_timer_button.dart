import 'dart:async';
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
  Timer? timer;

  void buttonHold() {
    timer?.cancel();
    timer = Timer.periodic(Duration(milliseconds: 16), (timer) {
      setState(() {
        openIndicator = (openIndicator + 0.05).clamp(0.0, 1.0);
        if (openIndicator == 1.0) {
          pomTimerDisplayStateManager.openPomTimer();
          pomTimerDisplayStateManager.pomTimerState.value = 'idle';
          timer.cancel();
        }
      });
    });
  }

  void buttonCancel() {
    timer?.cancel();
    timer = Timer.periodic(Duration(milliseconds: 16), (timer) {
      setState(() {
        openIndicator = (openIndicator - 0.05).clamp(0.0, 1.0);
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
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
                  color: const Color.fromARGB(110, 255, 219, 99),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(31, 173, 50, 50),
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
            Text(
              "ready when you are",
              style: TextStyle(
                fontFamily: 'Fredoka',
                fontSize: 15,
                color: Colors.white,
                shadows: [Shadow(color: Colors.black12, offset: Offset(2, 2))],
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
