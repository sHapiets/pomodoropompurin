import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/foundation/acquirable.dart';

class EquipTile extends StatelessWidget {
  const EquipTile({super.key, required this.item});

  /// pass an item upon instantiation
  final Acquirable item;

  final double iconSides = 80;
  final double tileHeight = 150;
  final double tileWidth = 100;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: tileWidth,
      height: tileHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [BoxShadow(color: Colors.black12)],
      ),
      child: Stack(
        children: [
          Align(
            alignment: AlignmentGeometry.topCenter,
            child: Container(
              width: iconSides,
              height: iconSides,
              color: Colors.white,
            ),
          ),
          Align(
            alignment: AlignmentGeometry.topCenter,
            child: SizedBox(child: Text(item.displayName)),
          ),
        ],
      ),
    );
  }
}
