import 'package:pomodoropompurin/scripts/core/acquirables.dart';
import 'package:pomodoropompurin/scripts/foundation/ingridient.dart';

class UnlocksFromLevel {
  static Map<int, List<Ingridient>> purchasableIngridients = {
    1: [Ingridient.milk, Ingridient.eggs],
    2: [Ingridient.cookedRice],
  };

  static Map<int, PurinVars> acquiredPurinVars = {
    1: PurinVars.boku,
    2: PurinVars.pumpkin,
    12: PurinVars.shrimp,
  };
}
