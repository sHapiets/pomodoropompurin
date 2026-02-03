import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/prog_system.dart';
import 'package:pomodoropompurin/scripts/foundation/ingridient.dart';

class IngridientTile extends StatelessWidget {
  IngridientTile({
    super.key,
    required this.ingridient,
    required this.ingridientIngridients,
  });

  final Ingridient ingridient;
  final Map<Ingridient, int> ingridientIngridients;

  final progSystem = ProgSystem.singleton;

  final ValueNotifier<int> processableCount = ValueNotifier(1000);

  void updateProcessableCount() {
    for (Ingridient requiredIngridient in ingridientIngridients.keys) {
      final int ingridientInventoryCount =
          progSystem.ingridientInventory[requiredIngridient]!;
      final int requiredIngridientCount =
          ingridientIngridients[requiredIngridient]!;
      final int processableCountFromIngridient =
          ingridientInventoryCount ~/ requiredIngridientCount;
      (processableCount.value > processableCountFromIngridient)
          ? processableCount.value = processableCountFromIngridient
          : null;
    }
  }

  @override
  Widget build(BuildContext context) {
    updateProcessableCount();
    return Text("${processableCount.value}");
  }
}
