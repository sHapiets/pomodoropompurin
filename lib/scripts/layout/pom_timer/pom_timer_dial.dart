import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';

GlobalKey<CircularMenuState> keyPomTimerDial = GlobalKey<CircularMenuState>();

class PomTimerDial extends StatefulWidget {
  const PomTimerDial({super.key});

  @override
  State<PomTimerDial> createState() => _PomTimerDialState();
}

class _PomTimerDialState extends State<PomTimerDial> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(40),
      child: CircularMenu(
        key: keyPomTimerDial,
        // menu alignment
        alignment: Alignment.bottomCenter,
        // menu radius
        radius: 120,
        // animation duration
        animationDuration: Duration(milliseconds: 500),
        // animation curve in forward
        curve: Curves.bounceOut,
        // animation curve in reverse
        reverseCurve: Curves.fastOutSlowIn,
        // first item angle
        startingAngleInRadian: 3.14,
        // last item angle
        endingAngleInRadian: 6.28,
        // toggle button callback
        toggleButtonOnPressed: () {
          //callback
        },
        // toggle button appearance properties
        toggleButtonColor: Colors.transparent,
        toggleButtonIconColor: Colors.white,
        toggleButtonMargin: 10,
        toggleButtonPadding: 10.0,
        toggleButtonSize: 40.0,
        items: [
          CircularMenuItem(
            // menu item callback
            onTap: () {
              // callback
            },
            // menu item appearance properties
            icon: Icons.home,
            color: Colors.blue,
            iconColor: Colors.white,
            iconSize: 30.0,
            margin: 10.0,
            padding: 10.0,
          ),
          CircularMenuItem(
            icon: Icons.search,
            onTap: () {
              //callback
            },
          ),
          CircularMenuItem(
            icon: Icons.settings,
            onTap: () {
              //callback
            },
          ),
          CircularMenuItem(
            icon: Icons.star,
            onTap: () {
              //callback
            },
          ),
          CircularMenuItem(
            icon: Icons.pages,
            onTap: () {
              //callback
            },
          ),
        ],
      ),
    );
    ;
  }
}
