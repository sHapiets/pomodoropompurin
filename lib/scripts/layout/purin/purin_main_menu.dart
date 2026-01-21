import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/page/main_page.dart';

class PurinMainMenu extends StatefulWidget {
  const PurinMainMenu({super.key});

  @override
  State<PurinMainMenu> createState() => _PurinMainMenuState();
}

class _PurinMainMenuState extends State<PurinMainMenu>
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
    return Center(
      child: Transform.translate(
        offset: Offset(-50, 0),
        child: AnimatedBuilder(
          animation: loadAnimation,
          builder: (context, child) {
            return ScaleTransition(scale: loadAnimation, child: child);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  purinAreaKey.currentState?.currentGame.overlays.remove(
                    "purinMainMenu",
                  );
                  purinAreaKey.currentState?.currentGame.overlays.add(
                    "purinEquipMenu",
                  );
                },
                icon: Icon(Icons.checkroom),
              ),
              IconButton(
                onPressed: () {
                  purinAreaKey.currentState?.currentGame.overlays.remove(
                    "purinMainMenu",
                  );
                  purinAreaKey.currentState?.currentGame.overlays.add(
                    "purinEquipMenu",
                  );
                },
                icon: Icon(Icons.checkroom),
              ),
              IconButton(
                onPressed: () {
                  purinAreaKey.currentState?.currentGame.overlays.remove(
                    "purinMainMenu",
                  );
                  purinAreaKey.currentState?.currentGame.overlays.add(
                    "purinEquipMenu",
                  );
                },
                icon: Icon(Icons.checkroom),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
