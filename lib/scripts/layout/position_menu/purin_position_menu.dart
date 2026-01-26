import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/acquirables.dart';
import 'package:pomodoropompurin/scripts/core/prog_system.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin_state_manager.dart';
import 'package:pomodoropompurin/scripts/layout/equip_menu/purin/purin_equip_tile.dart';
import 'package:pomodoropompurin/scripts/layout/position_menu/purin_position_tile.dart';

class PurinPositionMenu extends StatefulWidget {
  const PurinPositionMenu({super.key});

  @override
  State<PurinPositionMenu> createState() => _PurinPositionMenuState();
}

class _PurinPositionMenuState extends State<PurinPositionMenu> {
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
                    return PurinPositionTile(
                      purinPosition: PurinPosition.values[index],
                    );
                  },
                  itemCount: PurinPosition.values.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
