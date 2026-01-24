import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/acquirables.dart';
import 'package:pomodoropompurin/scripts/core/prog_system.dart';
import 'package:pomodoropompurin/scripts/layout/equip_menu/equip_tile.dart';

class PurinEquipMenu extends StatefulWidget {
  const PurinEquipMenu({super.key});

  @override
  State<PurinEquipMenu> createState() => _PurinEquipMenuState();
}

class _PurinEquipMenuState extends State<PurinEquipMenu> {
  final progSystem = ProgSystem.singleton;
  final acquirables = Acquirables.singleton;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.translate(
        offset: Offset(100, -100),
        child: Container(
          width: 200,
          height: 250,
          color: Colors.amber,
          child: Stack(
            children: [
              Positioned(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1.0,
                  ),
                  itemBuilder: (context, index) {
                    return EquipTile(
                      item: acquirables
                          .purinVars[progSystem.acquiredPurinVars[index]]!,
                    );
                  },
                  itemCount: progSystem.acquiredPurinVars.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
