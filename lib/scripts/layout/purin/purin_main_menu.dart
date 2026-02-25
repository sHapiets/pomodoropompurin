import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/page/main_page.dart';

class PurinMainMenu extends StatefulWidget {
  const PurinMainMenu({super.key});

  @override
  State<PurinMainMenu> createState() => _PurinMainMenuState();
}

class _PurinMainMenuState extends State<PurinMainMenu>
    with TickerProviderStateMixin {
  late final AnimationController loadAnimController = AnimationController(
    duration: const Duration(milliseconds: 450),
    vsync: this,
  );

  late final Animation<double> loadAnimation = CurvedAnimation(
    parent: loadAnimController,
    curve: Curves.easeOutBack,
  );

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () {
      loadAnimController.forward();
    });
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
      child: ScaleTransition(
        scale: loadAnimation,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3B0), // pudding yellow
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6D4C41).withOpacity(0.35),
                blurRadius: 25,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// TITLE
              const Text(
                "Purin Menu 🍮",
                style: TextStyle(
                  fontFamily: 'Fredoka',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6D4C41),
                ),
              ),

              const SizedBox(height: 18),

              /// BUTTONS
              _menuButton(
                icon: Icons.transform_rounded,
                label: "Move",
                onTap: () => _openOverlay("purinPositionMenu"),
              ),
              const SizedBox(height: 12),
              _menuButton(
                icon: Icons.checkroom,
                label: "Outfits",
                onTap: () => _openOverlay("purinEquipMenu"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0xFFFFE08A),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: const Color(0xFF6D4C41)),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Fredoka',
                fontWeight: FontWeight.w500,
                color: Color(0xFF6D4C41),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
