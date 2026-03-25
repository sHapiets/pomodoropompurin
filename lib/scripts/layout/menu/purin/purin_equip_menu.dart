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

  final List<PurinVars> acquiredPurinVars = [];
  final unlockPurinVarsMap = UnlocksFromLevel.acquiredPurinVars;

  @override
  void initState() {
    super.initState();

    final oshiriLevel = progSystem.oshiriLevel.value;

    for (final entry in unlockPurinVarsMap.entries) {
      if (entry.key > oshiriLevel) continue;
      acquiredPurinVars.add(entry.value);
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
          decoration: BoxDecoration(
            color: const Color.fromARGB(223, 255, 255, 255),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),

          child: Column(
            children: [
              /// HEADER
              Row(
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 255, 193, 7),
                    ),
                    child: const Icon(
                      Icons.pets_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'variant collection',
                      style: TextStyle(
                        fontFamily: 'Fredoka',
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                        color: Color.fromARGB(255, 42, 42, 42),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              /// GRID AREA
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: GridView.builder(
                    itemCount: acquiredPurinVars.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.9,
                        ),
                    itemBuilder: (context, index) {
                      final purinVar = acquiredPurinVars[index];
                      return PurinEquipTile(
                        purinVar: acquirables.purinVars[purinVar]!,
                      );
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
}
