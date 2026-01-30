import 'package:flame/game.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin_equip_manager.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin_state_manager.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/purin_area_selectable.dart';

import '../foundation/acquirable.dart';

/// A class that simply holds all acquirables.
///
/// Each acquirable has their respective enums, which is mapped
/// to an [Acquirable] object. I highly recommend you check the [Acquirable] class
/// first.
///
/// Each mapping is created to optimize space, such that all objects are
/// created only once, and are only referenced from their respective enums.
/// This also helps in isolating the logic from the items.
///
/// For instance, [PurinEquipManager] references the [purinVars] mapping
/// below, such that it holds object via key reference, instead of instantiating
/// the object.
///
/// Update: As of writing, the scope of the game is reduced to simply having
/// two types of acquirables:
/// [PurinVar] - mapped and enumerated by [PurinVars]
///            - an all-in-one implementation of [PurinEntity] customization
/// [RoomDesign] - enumerated by each type of [PurinAreaSelectable]
///              - IMPORTANT: the position property defines Purin's position from [PurinPosition]
///              - also defines the sprite path, to be used by the selectable entity
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
      id: PurinVars.boku,
      displayName: 'Boku',
      cost: 0,
      iconAssetPath: '',
    ),
    PurinVars.shrimp: PurinVar(
      id: PurinVars.shrimp,
      displayName: "Shrimp",
      cost: 100,
      iconAssetPath: '',
    ),
    PurinVars.pumpkin: PurinVar(
      id: PurinVars.pumpkin,
      displayName: "Pumpkin",
      cost: 200,
      iconAssetPath: '',
    ),
  };

  Map<KotatsuDesigns, RoomDesign> kotatsus = {
    KotatsuDesigns.pudding: RoomDesign(
      id: KotatsuDesigns.pudding,
      displayName: "Pudding",
      cost: 0,
      iconAssetPath: "",

      purinPositionVectors: {
        PurinPosition.kotatsuLeft: Vector2(120, 170),
        PurinPosition.kotatsuRight: Vector2(240, 170),
      },
      spriteFlamePath: "kotatsu_sprites/pudding.png",
    ),
    KotatsuDesigns.aqua: RoomDesign(
      id: KotatsuDesigns.aqua,
      displayName: "Aqua",
      cost: 100,
      iconAssetPath: "",

      purinPositionVectors: {
        PurinPosition.kotatsuLeft: Vector2(120, 170),
        PurinPosition.kotatsuRight: Vector2(120, 170),
      },
      spriteFlamePath: "kotatsu_sprites/aqua.png",
    ),
  };

  Map<FloorDesigns, RoomDesign> floors = {
    FloorDesigns.smooth: RoomDesign(
      id: FloorDesigns.smooth,
      displayName: "Smooth",
      cost: 0,
      iconAssetPath: "",

      purinPositionVectors: {},
      spriteFlamePath: "floor_sprites/smooth.png",
    ),
  };

  Map<InteriorWallDesigns, RoomDesign> interiorWalls = {
    InteriorWallDesigns.smooth: RoomDesign(
      id: InteriorWallDesigns.smooth,
      displayName: "Smooth",
      cost: 0,
      iconAssetPath: "",

      purinPositionVectors: {},
      spriteFlamePath: "interior_wall_sprites/smooth.png",
    ),
  };

  Map<ExteriorDesigns, RoomDesign> exteriors = {
    ExteriorDesigns.plain: RoomDesign(
      id: ExteriorDesigns.plain,
      displayName: "Plain",
      cost: 0,
      iconAssetPath: "",

      purinPositionVectors: {},
      spriteFlamePath: "exterior_sprites/plain.png",
    ),
  };

  Map<BlanketDesigns, RoomDesign> blankets = {
    BlanketDesigns.cyan: RoomDesign(
      id: BlanketDesigns.cyan,
      displayName: "Cyan",
      cost: 0,
      iconAssetPath: "",

      purinPositionVectors: {PurinPosition.futon: Vector2(33, 358)},
      spriteFlamePath: "blanket_sprites/cyan.png",
    ),
  };

  Map<FutonDesigns, RoomDesign> futons = {
    FutonDesigns.cyan: RoomDesign(
      id: FutonDesigns.cyan,
      displayName: "Cyan",
      cost: 0,
      iconAssetPath: "",

      purinPositionVectors: {PurinPosition.futon: Vector2(33, 358)},
      spriteFlamePath: "futon_sprites/cyan.png",
    ),
  };

  Map<RefrigeratorDesigns, RoomDesign> refrigerators = {
    RefrigeratorDesigns.silver: RoomDesign(
      id: RefrigeratorDesigns.silver,
      displayName: "Silver",
      cost: 0,
      iconAssetPath: "",
      purinPositionVectors: {},
      spriteFlamePath: 'refrigerator_sprites/silver.png',
    ),
  };

  Map<StudyTableDesigns, RoomDesign> studyTables = {
    StudyTableDesigns.wooden: RoomDesign(
      id: StudyTableDesigns.wooden,
      displayName: "Wooden",
      cost: 0,
      iconAssetPath: "",
      purinPositionVectors: {},
      spriteFlamePath: "study_table_sprites/wooden.png",
    ),
  };
}

enum PurinVars { boku, shrimp, pumpkin }

enum KotatsuDesigns { pudding, aqua }

enum BlanketDesigns { cyan }

enum FutonDesigns { cyan }

enum RefrigeratorDesigns { silver }

enum StudyTableDesigns { wooden }

enum FloorDesigns { smooth }

enum InteriorWallDesigns { smooth }

enum ExteriorDesigns { plain }
