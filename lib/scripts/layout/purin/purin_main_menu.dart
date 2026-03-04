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
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  late final Animation<double> loadAnimation = CurvedAnimation(
    parent: loadAnimController,
    curve: Curves.easeOutBack,
  );

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
      child: ScaleTransition(
        scale: loadAnimation,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _floatingButton(
              icon: Icons.transform_rounded,
              label: "Move",
              onTap: () => _openOverlay("purinPositionMenu"),
            ),

            const SizedBox(height: 12),

            _floatingButton(
              icon: Icons.checkroom,
              label: "Outfits",
              onTap: () => _openOverlay("purinEquipMenu"),
            ),
          ],
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
      borderRadius: BorderRadius.circular(30),
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Smaller circular icon background
          Container(
            padding: const EdgeInsets.all(9), // reduced from 12–14
            decoration: BoxDecoration(
              color: const Color(0xFFFFE08A),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6D4C41).withOpacity(0.20),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 20, // smaller icon
              color: const Color(0xFF6D4C41),
            ),
          ),

          const SizedBox(width: 10), // tighter spacing
          /// Better vertically centered label
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Fredoka',
              fontWeight: FontWeight.w600,
              fontSize: 14, // slightly smaller
              height: 1.1,
              color: Color(0xFF6D4C41),
            ),
          ),
        ],
      ),
    );
  }
}
