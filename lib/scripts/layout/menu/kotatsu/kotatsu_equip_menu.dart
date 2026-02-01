import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/acquirables.dart';
import 'package:pomodoropompurin/scripts/core/prog_system.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:pomodoropompurin/scripts/layout/menu/kotatsu/kotatsu_equip_tile.dart';

class KotatsuEquipMenu extends StatefulWidget {
  const KotatsuEquipMenu({super.key});

  @override
  State<KotatsuEquipMenu> createState() => _KotatsuEquipMenuState();
}

class _KotatsuEquipMenuState extends State<KotatsuEquipMenu> {
  final purinAreaStateManager = PurinAreaStateManager.singleton;
  final progSystem = ProgSystem.singleton;
  final acquirables = Acquirables.singleton;

  final double menuWidth = 200;
  final double menuHeight = 250;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.translate(
        offset: Offset(50, -50),
        child: Container(
          width: menuWidth,
          height: menuHeight,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(91, 255, 255, 255),
          ),

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
                    return KotatsuEquipTile(
                      item:
                          acquirables.kotatsus[progSystem.acquiredKotatsus
                              .toList()[index]]!,
                    );
                  },
                  itemCount: progSystem.acquiredKotatsus.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
