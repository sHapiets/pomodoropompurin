import 'package:pomodoropompurin/scripts/core/acquirables.dart';
import 'package:pomodoropompurin/scripts/foundation/ingridient.dart';

/// A class collection of unlock maps that are awarded to the user
/// after reaching a certain oshiriLevel
///
/// Each map is constructed int the form
///
///               {oshiriLevelRequirement : unlockable}
///
/// This is to be used mostly for acquirables, where the available
/// items are listed here, and displayed by iterating over the map.
/// As an example, refer to [PurchasableMenu], and how it handles
/// the logic of only showing [PurchaseTile] that are listed in its
/// respective map below (purchasableIngridents)
///
/// Ideally, this data is better consturcted uisng a .json file, and
/// simply read before runtime to lessen build size. For the meantime,
/// this class does the job, and is quite convinient for all other
/// classes to access.
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
