import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/layout/item_display/item_display_manager.dart';

/// A layout widget that builds the area where Items could be placed and move around.
/// Uses the ItemDisplayManager singleton to provide ItemDisplayEntities to the area.
class ItemDisplayArea extends StatefulWidget {
  const ItemDisplayArea({super.key});

  @override
  State<ItemDisplayArea> createState() => _ItemDisplayAreaState();
}

class _ItemDisplayAreaState extends State<ItemDisplayArea> {
  final _itemDisplayedEntities =
      ItemDisplayManager.singleton.itemDisplayedEntities;

  @override
  Widget build(BuildContext context) {
    // TODO: Edit area and design (floor) of this widget
    return Scaffold(
      body: Center(
        child: Container(
          width: 800,
          height: 400,
          color: Colors.grey.shade300,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(children: _itemDisplayedEntities);
            },
          ),
        ),
      ),
    );
  }
}
