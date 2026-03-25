import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/dialog/script_dialog/script_manager.dart';
import 'package:pomodoropompurin/scripts/core/ui/purin_metrics_ui_state.dart';
import 'package:pomodoropompurin/scripts/memory/asset_manager.dart';
import 'package:pomodoropompurin/scripts/page/main_page.dart';

class PurinMainMenu extends StatefulWidget {
  const PurinMainMenu({super.key});

  @override
  State<PurinMainMenu> createState() => _PurinMainMenuState();
}

class _PurinMainMenuState extends State<PurinMainMenu>
    with TickerProviderStateMixin {
  late final AnimationController loadAnimController = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  late final Animation<double> loadAnimation = CurvedAnimation(
    parent: loadAnimController,
    curve: Curves.easeOutBack,
  );

  final scriptManager = ScriptManager.singleton;

  @override
  void initState() {
    super.initState();
    loadAnimController.forward();
  }

  @override
  void dispose() {
    loadAnimController.dispose();
    super.dispose();
  }

  void _openOverlay(String overlayName) {
    purinAreaKey.currentState?.currentGame.overlays.remove("purinMainMenu");
    purinAreaKey.currentState?.currentGame.overlays.add(overlayName);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.translate(
        offset: Offset(50, -50),
        child: ScaleTransition(
          scale: loadAnimation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 80,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(175, 245, 200, 68),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(133, 235, 181, 81),
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
                child: Image.asset(
                  AssetManager
                      .singleton
                      .flutterAssetPaths['pumped_purin_icon']!,
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(137, 243, 212, 35),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(103, 216, 163, 57),
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
                child: const Text(
                  "- PURIN -",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    shadows: [
                      Shadow(color: Color(0xFF6D4C41), offset: Offset(2, 2)),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),
              _floatingButton(
                icon: Icons.fastfood_outlined,
                label: "snacks",
                onTap: () {
                  PurinMetricsUIState.singleton.showWidget();
                  _openOverlay("snackMenu");
                },
              ),
              const SizedBox(height: 9),

              _floatingButton(
                icon: Icons.transform_rounded,
                label: "move",
                onTap: () => _openOverlay("purinPositionMenu"),
              ),
              const SizedBox(height: 9),

              _floatingButton(
                icon: Icons.checkroom_rounded,
                label: "collection",
                onTap: () => _openOverlay("purinEquipMenu"),
              ),

              const SizedBox(height: 9),

              _floatingButton(
                icon: Icons.chat_bubble_outline,
                label: "words of wisdom",
                onTap: () => _openOverlay("purinPositionMenu"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _floatingButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE08A),
              borderRadius: BorderRadius.circular(3),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6D4C41).withOpacity(0.20),
                  offset: const Offset(3, 3),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 20, // smaller icon
              color: const Color(0xFF6D4C41),
            ),
          ),

          const SizedBox(width: 10),

          Icon(
            Icons.arrow_right_rounded,
            color: Colors.brown,
            size: 20,
            shadows: [Shadow(color: Colors.black12, offset: Offset(2, 2))],
          ),

          const SizedBox(width: 10),

          Container(
            width: 100,
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(3),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6D4C41).withOpacity(0.20),
                  offset: const Offset(3, 3),
                ),
              ],
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  label,
                  style: const TextStyle(
                    fontFamily: 'Fredoka',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    height: 1.1,
                    color: Color(0xFF6D4C41),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
