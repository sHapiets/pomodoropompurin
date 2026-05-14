import 'package:pomodoropompurin/scripts/core/acquirables.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/purin_var/purin_var.dart';

/// ----------------------------------------------------------------------------------
/// ----- Purin, despite his obnoxiously 'spherical' shape, certainly loves style
/// and fashion! I am not quite sure if I will be able to maximize this
/// feature, but I am adding it nonetheless. -------
///
///------------------------------------------------------------------------------------
/// This is a singleton manager that mainly oversees equipped outfits/clothes,
/// which reflects on display. Includes Acquireables objects for each equippable
/// part, and also methods and rules that govern the said Aquireables.
///
/// IMPORTANT:
/// In order to control the equipment conflict between OutfitSets and individual
/// outfit acquirables (Hat, Top, Bottom), the keyword 'Three' refers to the collection
/// of the three individual outfit acquirables.
class PurinEquipManager {
  PurinEquipManager._();
  static final singleton = PurinEquipManager._(); /* 
  final acquirables = Acquirables.singleton;

  final _acquireables = Acquirables.singleton; */
  /*   Hat? equippedHat = Acquirables.singleton.acquirableHats['defaultHat'];
  Top? equippedTop;
  Bottom? equippedBottom;
  OutfitSet? equippedOutfitSet; */
  PurinVar equippedPurinVar = PurinVar.boku;

  /*  bool get isHatEquipped => (equippedHat == null) ? false : true;
  bool get isTopEquipped => (equippedTop == null) ? false : true;
  bool get isBottomEquipped => (equippedBottom == null) ? false : true;
  bool get isOutfitSetEquipped => (equippedOutfitSet == null) ? false : true;
  bool get isAnyThreeEquipped =>
      (isHatEquipped || isTopEquipped || isBottomEquipped) ? true : false;
 */ /* 
  /// A method to be called when changing or setting equipped objects.
  void equip({required PurinEquippable equipType, required String newEquipId}) {
    switch (equipType) {
      case PurinEquippable.hat:
        equippedHat = _acquireables.acquirableHats[newEquipId];
      case PurinEquippable.top:
        equippedTop = _acquireables.acquirableTops[newEquipId];
      case PurinEquippable.bottom:
        equippedBottom = _acquireables.acquirableBottoms[newEquipId];
      case PurinEquippable.outfitSet:
        equippedOutfitSet = _acquireables.acquirableOutfitSets[newEquipId];
        removeEquippedThree();
      case PurinEquippable.purinVar:
        equippedPurinVar = _acquireables.acquirablePurinVars[newEquipId];
      default:
        debugPrint(
          'Invalid EquipType or EquipId passed to PurinEquipManager.equip!',
        );
    }
  } */

  void equip(PurinVar purinVar) {
    equippedPurinVar = purinVar;
  }

  /* 

  /// All remove methods simply sets equipped objects to null.
  /// (Also means..... Purin could just be naked!!!)
  void removeEquippedHat() => equippedHat = null;
  void removeEquippedTop() => equippedTop = null;
  void removeEquippedBottom() => equippedBottom = null;
  void removeEquippedOutfitSet() => equippedOutfitSet = null;
  void removeEquippedThree() {
    removeEquippedHat();
    removeEquippedTop();
    removeEquippedBottom();
  } */
}

enum PurinEquippable { hat, top, bottom, outfitSet, purinVar }
