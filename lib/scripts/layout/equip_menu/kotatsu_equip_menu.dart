import 'dart:async';

import 'package:flutter/material.dart';

class KotatsuEquipMenu extends StatefulWidget {
  const KotatsuEquipMenu({super.key});

  @override
  State<KotatsuEquipMenu> createState() => _KotatsuEquipMenuState();
}

class _KotatsuEquipMenuState extends State<KotatsuEquipMenu>
    with TickerProviderStateMixin {
  late Timer loadTimer;
  late final loadAnimController = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );
  late final loadAnimation = CurvedAnimation(
    parent: loadAnimController,
    curve: Curves.ease,
  );

  @override
  void initState() {
    super.initState();
    loadTimer = Timer.periodic(Duration(milliseconds: 300), (timer) {
      loadAnimController.forward();
      timer.cancel();
    });
  }

  @override
  void dispose() {
    loadTimer.cancel();
    loadAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: loadAnimController,
      builder: (context, child) {
        return ScaleTransition(scale: loadAnimation, child: child);
      },
      child: Stack(
        children: [
          Center(
            child: MaterialButton(
              onPressed: () {},
              child: Container(width: 100, height: 100, color: Colors.amber),
            ),
          ),
        ],
      ),
    );
  }
}
