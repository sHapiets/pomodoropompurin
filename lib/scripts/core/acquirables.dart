import 'package:flame/game.dart';

import '../foundation/acquirable.dart';

/// A class that simply holds all acquirables in the app
///
/// .items -> List of Item instances;
/// .hats -> List of Hat instances
/// etc...
///
/// In order to add a new Acquirable,
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

  Map<PurinVars, PurinVar> purinVars = {
    PurinVars.boku: PurinVar(
      id: 'boku',
      displayName: 'Boku',
      cost: 0,
      iconAssetPath: '',
    ),
    PurinVars.shrimp: PurinVar(
      id: 'shrimp',
      displayName: "Shrimp",
      cost: 100,
      iconAssetPath: '',
    ),
    PurinVars.pumpkin: PurinVar(
      id: 'pumpkin',
      displayName: "Pumpkin",
      cost: 200,
      iconAssetPath: '',
    ),
  };

  Map<KotatsuDesigns, RoomDesign> kotatsus = {
    KotatsuDesigns.pudding: RoomDesign(
      id: "0000",
      displayName: "Pudding",
      cost: 0,
      iconAssetPath: "",

      position: Vector2(120, 170),
      spriteFlamePath: "kotatsu_sprites/pudding.png",
    ),
    KotatsuDesigns.aqua: RoomDesign(
      id: "0000",
      displayName: "Aqua",
      cost: 100,
      iconAssetPath: "",

      position: Vector2(120, 170),
      spriteFlamePath: "kotatsu_sprites/aqua.png",
    ),
  };

  Map<FloorDesigns, RoomDesign> floors = {
    FloorDesigns.smooth: RoomDesign(
      id: "0000",
      displayName: "Smooth",
      cost: 0,
      iconAssetPath: "",

      position: Vector2(0, 0),
      spriteFlamePath: "floor_sprites/smooth.png",
    ),
  };

  Map<InteriorWallDesigns, RoomDesign> interiorWalls = {
    InteriorWallDesigns.smooth: RoomDesign(
      id: "0000",
      displayName: "Smooth",
      cost: 0,
      iconAssetPath: "",

      position: Vector2(0, 0),
      spriteFlamePath: "interior_wall_sprites/smooth.png",
    ),
  };

  Map<ExteriorDesigns, RoomDesign> exteriors = {
    ExteriorDesigns.plain: RoomDesign(
      id: "0000",
      displayName: "Plain",
      cost: 0,
      iconAssetPath: "",

      position: Vector2(0, 0),
      spriteFlamePath: "exterior_sprites/plain.png",
    ),
  };

  Map<BlanketDesigns, RoomDesign> blankets = {
    BlanketDesigns.cyan: RoomDesign(
      id: "0000",
      displayName: "Cyan",
      cost: 0,
      iconAssetPath: "",

      position: Vector2(-80, 260),
      spriteFlamePath: "blanket_sprites/cyan.png",
    ),
  };

  Map<FutonDesigns, RoomDesign> futons = {
    FutonDesigns.cyan: RoomDesign(
      id: "0000",
      displayName: "Cyan",
      cost: 0,
      iconAssetPath: "",

      position: Vector2(33, 358),
      spriteFlamePath: "futon_sprites/cyan.png",
    ),
  };
}

enum PurinVars { boku, shrimp, pumpkin }

enum KotatsuDesigns { pudding, aqua }

enum BlanketDesigns { cyan }

enum FutonDesigns { cyan }

enum FloorDesigns { smooth }

enum InteriorWallDesigns { smooth }

enum ExteriorDesigns { plain }
