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
  /* 
  Map<PurinVars, PurinVar> purinVars = {
    PurinVars.boku: PurinVar(
      id: PurinVars.boku,
      displayName: 'Boku-Purin',
      cost: 0,
      iconAssetPath: 'assets/images/purin_sprites/boku_icon.png',
    ),
    PurinVars.pumpkin: PurinVar(
      id: PurinVars.pumpkin,
      displayName: "Pumpkin-Purin",
      cost: 0,
      iconAssetPath: 'assets/images/purin_sprites/pumpkin_icon.png',
    ),
    PurinVars.summer: PurinVar(
      id: PurinVars.summer,
      displayName: "Summer-Purin",
      cost: 0,
      iconAssetPath: 'assets/images/purin_sprites/summer_icon.png',
    ),
    PurinVars.bee: PurinVar(
      id: PurinVars.bee,
      displayName: "Bee-Purin",
      cost: 0,
      iconAssetPath: 'assets/images/purin_sprites/bee_icon.png',
    ),
    PurinVars.pika: PurinVar(
      id: PurinVars.pika,
      displayName: "Pika-Purin",
      cost: 0,
      iconAssetPath: 'assets/images/purin_sprites/pika_icon.png',
    ),
    PurinVars.yana: PurinVar(
      id: PurinVars.yana,
      displayName: "Yana-Purin",
      cost: 0,
      iconAssetPath: 'assets/images/purin_sprites/yana_icon.png',
    ),
    PurinVars.pol: PurinVar(
      id: PurinVars.pol,
      displayName: "Pol-Purin",
      cost: 0,
      iconAssetPath: 'assets/images/purin_sprites/pol_icon.png',
    ),
    PurinVars.atenean: PurinVar(
      id: PurinVars.atenean,
      displayName: "Atenean-Purin",
      cost: 0,
      iconAssetPath: 'assets/images/purin_sprites/atenean_icon.png',
    ),
    PurinVars.beach: PurinVar(
      id: PurinVars.beach,
      displayName: "Beach-Purin",
      cost: 0,
      iconAssetPath: 'assets/images/purin_sprites/beach_icon.png',
    ),
    PurinVars.fragaria: PurinVar(
      id: PurinVars.fragaria,
      displayName: "Fragaria-Purin",
      cost: 0,
      iconAssetPath: 'assets/images/purin_sprites/fragaria_icon.png',
    ),
    PurinVars.winter: PurinVar(
      id: PurinVars.winter,
      displayName: "Winter-Purin",
      cost: 0,
      iconAssetPath: 'assets/images/purin_sprites/winter_icon.png',
    ),
    PurinVars.tokimeki: PurinVar(
      id: PurinVars.tokimeki,
      displayName: "Tokimeki-Purin",
      cost: 0,
      iconAssetPath: 'assets/images/purin_sprites/tokimeki_icon.png',
    ),
    PurinVars.angel: PurinVar(
      id: PurinVars.angel,
      displayName: "Angel-Purin",
      cost: 0,
      iconAssetPath: 'assets/images/purin_sprites/angel_icon.png',
    ),
    PurinVars.chef: PurinVar(
      id: PurinVars.chef,
      displayName: "Chef-Purin",
      cost: 0,
      iconAssetPath: 'assets/images/purin_sprites/chef_icon.png',
    ),
    PurinVars.kimono: PurinVar(
      id: PurinVars.kimono,
      displayName: "Kimono-Purin",
      cost: 0,
      iconAssetPath: 'assets/images/purin_sprites/kimono_icon.png',
    ),
    PurinVars.vampire: PurinVar(
      id: PurinVars.vampire,
      displayName: "Vampire-Purin",
      cost: 0,
      iconAssetPath: 'assets/images/purin_sprites/vampire_icon.png',
    ),
    PurinVars.mama: PurinVar(
      id: PurinVars.mama,
      displayName: "Mama-Purin",
      cost: 0,
      iconAssetPath: 'assets/images/purin_sprites/mama_icon.png',
    ),
  }; */

  Map<KotatsuDesigns, RoomDesign> kotatsus = {
    KotatsuDesigns.pudding: RoomDesign(
      id: KotatsuDesigns.pudding,
      displayName: "Pudding",
      cost: 0,
      iconAssetPath: "",

      purinPositionVectors: {
        PurinPosition.kotatsuLeft: Vector2(110, 130),
        PurinPosition.kotatsuRight: Vector2(250, 130),
      },
      spriteFlamePath: "kotatsu_sprites/pudding.png",
    ),
    KotatsuDesigns.aqua: RoomDesign(
      id: KotatsuDesigns.aqua,
      displayName: "Aqua",
      cost: 100,
      iconAssetPath: "",

      purinPositionVectors: {
        PurinPosition.kotatsuLeft: Vector2(110, 130),
        PurinPosition.kotatsuRight: Vector2(250, 130),
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
      purinPositionVectors: {PurinPosition.study: Vector2(-170, 410)},
      spriteFlamePath: "study_table_sprites/wooden.png",
    ),
  };

  Map<SofaDesigns, RoomDesign> sofas = {
    SofaDesigns.pink: RoomDesign(
      id: SofaDesigns.pink,
      displayName: "Pink",
      cost: 0,
      iconAssetPath: "",
      purinPositionVectors: {
        PurinPosition.sofaSitLeft: Vector2(-315, 260),
        PurinPosition.sofaSitRight: Vector2(-280, 250),
        PurinPosition.sofaRest: Vector2(-305, 275),
      },
      spriteFlamePath: "sofa_sprites/default.png",
    ),
  };
}

enum PurinVar {
  boku,
  pumpkin,
  summer,
  bee,
  pika,
  yana,
  pol,
  fragaria,
  winter,
  atenean,
  beach,
  tokimeki,
  angel,
  chef,
  kimono,
  vampire,
  mama;

  const PurinVar();

  String get displayName =>
      "${name[0].toUpperCase() + name.substring(1)}-Purin";
  String get purinSpritesheetDir => 'purin_sprites/${name}_spritesheet.png';
  String get iconAssetPath => 'assets/images/purin_sprites/${name}_icon.png';
}

enum KotatsuDesigns { pudding, aqua }

enum BlanketDesigns { cyan }

enum FutonDesigns { cyan }

enum RefrigeratorDesigns { silver }

enum StudyTableDesigns { wooden }

enum SofaDesigns { pink }

enum FloorDesigns { smooth }

enum InteriorWallDesigns { smooth }

enum ExteriorDesigns { plain }
