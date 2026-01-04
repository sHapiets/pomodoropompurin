abstract class Acquirable {
  final String id;
  final String displayName;
  final int cost;
  final String assetPath;

  Acquirable({
    required this.id,
    required this.displayName,
    required this.cost,
    required this.assetPath,
  });
}

class Item extends Acquirable {
  Item({
    required super.id,
    required super.displayName,
    required super.cost,
    required super.assetPath,
  });
}

class Hat extends Acquirable {
  Hat({
    required super.id,
    required super.displayName,
    required super.cost,
    required super.assetPath,
  });
}

class Top extends Acquirable {
  Top({
    required super.id,
    required super.displayName,
    required super.cost,
    required super.assetPath,
  });
}

class Bottom extends Acquirable {
  Bottom({
    required super.id,
    required super.displayName,
    required super.cost,
    required super.assetPath,
  });
}

class Purin extends Acquirable {
  Purin({
    required super.id,
    required super.displayName,
    required super.cost,
    required super.assetPath,
  });
}

class RoomDesign extends Acquirable {
  RoomDesign({
    required super.id,
    required super.displayName,
    required super.cost,
    required super.assetPath,
  });
}
