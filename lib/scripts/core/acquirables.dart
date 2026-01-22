import 'package:flame/game.dart';

import '../foundation/acquirable.dart';

/// A class that simply holds all acquirables in the app
///
/// .items -> List of Item instances;
/// .hats -> List of Hat instances
/// etc...
class Acquirables {
  Acquirables._();
  static final singleton = Acquirables._();
  /* 
  // All Items
  Map<String, Item> acquirableItems = {
    '0000': Item(
      id: "0000",
      displayName: "Item 0",
      cost: 100,
      iconAssetPath: "assets/sprites/L8.jpg",
    ),
    '0001': Item(
      id: "0001",
      displayName: "Item 2",
      cost: 100,
      iconAssetPath: "assets/sprites/L7.png",
    ),
  };

  Map<String, Hat> acquirableHats = {
    'defaultHat': Hat(
      id: "0000",
      displayName: "Item 0",
      cost: 0,
      iconAssetPath: "assets/L8.jpg",
    ),
  }; 

  Map<String, Top> acquirableTops = {};
  Map<String, Bottom> acquirableBottoms = {};
  Map<String, OutfitSet> acquirableOutfitSets = {}; */

  Map<String, PurinVar> acquirablePurinVars = {
    'default': PurinVar(
      id: 'default',
      displayName: 'Boku',
      cost: 0,
      iconAssetPath: '',
    ),
    'shrimp': PurinVar(
      id: 'shrimp',
      displayName: "Shrimp",
      cost: 100,
      iconAssetPath: '',
    ),
  };

  Map<String, RoomDesign> acquirableRoomDesign = {
    'default': RoomDesign(
      id: "0000",
      displayName: "Pudding",
      cost: 0,
      iconAssetPath: "Kotatsu_default.png",
      position: Vector2(130, 160),
    ),
    'blue': RoomDesign(
      id: "0000",
      displayName: "Blue Pudding",
      cost: 0,
      iconAssetPath: "Kotatsu_blue.png",
      position: Vector2(130, 160),
    ),
  };
}
