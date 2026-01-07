/// This sets of classes defines all objects in the app that are used
/// for customizing. This includes items, clothes for Purin, Purin
/// variations, and room designs.
///
/// It sets a foundation/template
/// for the app for routing proper display management, making my
/// process a bit easier when passing instances around the app.
///
///
/// Acquirable is a abstract class in which all obtainable items
/// in the app inherits. Since most Acquirable is arguably purchaseable,
/// a Purchasable class is no longer needed, and instead has optional
/// properties.
abstract class Acquirable {
  final String id;
  final String displayName;
  final String iconAssetPath;

  final int? cost;

  Acquirable({
    required this.id,
    required this.displayName,
    required this.iconAssetPath,
    this.cost,
  });
}

class Item extends Acquirable {
  Item({
    required super.id,
    required super.displayName,
    required super.cost,
    required super.iconAssetPath,
  });
}

class Hat extends Acquirable {
  Hat({
    required super.id,
    required super.displayName,
    required super.cost,
    required super.iconAssetPath,
  });
}

class Top extends Acquirable {
  Top({
    required super.id,
    required super.displayName,
    required super.cost,
    required super.iconAssetPath,
  });
}

class Bottom extends Acquirable {
  Bottom({
    required super.id,
    required super.displayName,
    required super.cost,
    required super.iconAssetPath,
  });
}

class OutfitSet extends Acquirable {
  OutfitSet({
    required super.id,
    required super.displayName,
    required super.cost,
    required super.iconAssetPath,
  });
}

class PurinVar extends Acquirable {
  PurinVar({
    required super.id,
    required super.displayName,
    required super.cost,
    required super.iconAssetPath,
  });
}

class RoomDesign extends Acquirable {
  RoomDesign({
    required super.id,
    required super.displayName,
    required super.cost,
    required super.iconAssetPath,
  });
}
