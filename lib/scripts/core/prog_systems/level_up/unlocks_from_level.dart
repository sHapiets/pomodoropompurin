import 'package:pomodoropompurin/scripts/core/acquirables.dart';
import 'package:pomodoropompurin/scripts/foundation/ingridient.dart';
import 'package:pomodoropompurin/scripts/foundation/snack.dart';

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
    2: [Ingridient.eggs, Ingridient.milk, Ingridient.butter],
    3: [Ingridient.flour],
    6: [Ingridient.onion, Ingridient.groundPork, Ingridient.riceGrains],
    7: [Ingridient.puddingCream, Ingridient.pancakeBatter],
    8: [Ingridient.choppedOnions, Ingridient.cookedRice],
    10: [Ingridient.yeast, Ingridient.tomato, Ingridient.olives],
    11: [Ingridient.puddingBatter, Ingridient.patty],
    13: [Ingridient.dough, Ingridient.pizzaToppings],
  };

  static Map<int, List<Snack>> purchaseableSnack = {
    2: [Snack.potatoChips],
    5: [Snack.hotCocoa],
    9: [Snack.cheeseIceCream],
    14: [Snack.chocolateCupcake],
    15: [Snack.strawberryCupcake],
  };

  static Map<int, PurinVars> acquiredPurinVars = {
    1: PurinVars.boku,
    4: PurinVars.pumpkin,
    9: PurinVars.pika,
    12: PurinVars.bee,
    16: PurinVars.summer,
  };
}
