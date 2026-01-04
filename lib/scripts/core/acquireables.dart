import '../foundation/acquireable.dart';

/// A class that simply holds all acquireables in the app
///
/// .items -> List of Item instances;
/// .hats -> List of Hat instances
/// etc...
class Acquireables {
  Acquireables._();
  final singleton = Acquireables._();

  // All Items
  Map<String, Item> items = {
    '0000': Item(
      id: "0000",
      displayName: "Item 0",
      cost: 100,
      assetPath: "assets/L8.png",
    ),
    '0001': Item(
      id: "0001",
      displayName: "Item 2",
      cost: 100,
      assetPath: "assets/L7.png",
    ),
  };
}
