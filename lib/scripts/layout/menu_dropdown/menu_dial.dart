import 'package:flutter/material.dart';
import 'package:freestyle_speed_dial/freestyle_speed_dial.dart';

class MenuDial extends StatefulWidget {
  const MenuDial({super.key});

  @override
  State<MenuDial> createState() => _MenuDialState();
}

class _MenuDialState extends State<MenuDial> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 500),
      top: 40,
      right: 40,
      child: SpeedDialBuilder(
        buttonAnchor: Alignment.bottomCenter,
        itemAnchor: Alignment.topCenter,
        buttonBuilder: (context, isActive, toggle) {
          return Container(
            width: 70,
            height: 70,
            child: MaterialButton(
              onPressed: toggle,
              child: Image.asset('assets/images/L8.jpg'),
            ),
          );
        },
        itemBuilder: (context, Widget item, i, animation) =>
            FractionalTranslation(
              translation: Offset(0, i.toDouble()),
              child: ScaleTransition(scale: animation, child: item),
            ),
        items: [
          Container(
            margin: EdgeInsets.only(top: 20),
            width: 50,
            height: 50,
            child: MaterialButton(
              onPressed: () {},
              child: const Icon(Icons.hub),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            width: 50,
            height: 50,
            child: MaterialButton(
              onPressed: () {},
              child: const Icon(Icons.file_download),
            ),
          ),
        ],
      ),
    );
  }
}
