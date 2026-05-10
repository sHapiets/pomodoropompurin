import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/acquirables.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/prog_system.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/level_up/unlocks_from_level.dart';
import 'package:pomodoropompurin/scripts/layout/menu/purin/purin_equip_tile.dart';

class PurinEquipMenu extends StatefulWidget {
  const PurinEquipMenu({super.key});

  @override
  State<PurinEquipMenu> createState() => _PurinEquipMenuState();
}

class _PurinEquipMenuState extends State<PurinEquipMenu> {
  final progSystem = ProgSystem.singleton;
  final acquirables = Acquirables.singleton;

  final List<PurinVar> acquiredPurinVars = [];
  final unlockPurinVarsMap = UnlocksFromLevel.acquiredPurinVars;

  @override
  void initState() {
    super.initState();

    final oshiriLevel = progSystem.oshiriLevel.value;

    for (final entry in unlockPurinVarsMap.entries) {
      if (entry.key > oshiriLevel) continue;
      acquiredPurinVars.addAll(entry.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    const double menuWidth = 260;
    const double menuHeight = 320;

    return Center(
      child: Transform.translate(
        offset: const Offset(50, -50),
        child: Container(
          width: menuWidth,
          height: menuHeight,
          padding: const EdgeInsets.all(14),

          child: Column(
            children: [
              /// HEADER
              _header(
                'variant collection',
                Icons.pets_rounded,
                Color.fromARGB(255, 192, 145, 75),
              ),
              const SizedBox(height: 14),

              /// GRID AREA
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(195, 218, 146, 54),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: GridView.builder(
                    itemCount: acquiredPurinVars.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.75,
                        ),
                    itemBuilder: (context, index) {
                      final purinVar = acquiredPurinVars[index];
                      return PurinEquipTile(purinVar: purinVar);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(String menuTitle, IconData menuIcon, Color menuColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: menuColor.withOpacity(0.2).darken(0.3),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(spreadRadius: 4, color: menuColor.withOpacity(0.2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(shape: BoxShape.circle, color: menuColor),
            child: Icon(menuIcon, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              menuTitle,
              style: const TextStyle(
                fontFamily: 'Fredoka',
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.white,
                shadows: [Shadow(color: Colors.black38, offset: Offset(2, 2))],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
