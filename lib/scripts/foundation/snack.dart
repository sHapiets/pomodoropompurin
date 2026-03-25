enum Snack {
  potatoChips(
    displayName: "Potato Chips",
    price: 10,
    oshiriPoints: 10,
    hungerPoints: 15,
    energyPoints: 5,
    iconFlutterPath: 'assets/images/consumable_sprites/pudding/2.png',
  ),
  hotCocoa(
    displayName: "Hot Cocoa",
    price: 15,
    oshiriPoints: 5,
    hungerPoints: 3,
    energyPoints: 20,
    iconFlutterPath: 'assets/images/consumable_sprites/pudding/2.png',
  ),
  cheeseIceCream(
    displayName: "Cheese Ice Cream",
    price: 30,
    oshiriPoints: 20,
    hungerPoints: 10,
    energyPoints: 15,
    iconFlutterPath: 'assets/images/consumable_sprites/pudding/2.png',
  ),
  chocolateCupcake(
    displayName: "Chocolate Cupcake",
    price: 50,
    oshiriPoints: 10,
    hungerPoints: 30,
    energyPoints: 20,
    iconFlutterPath: 'assets/images/consumable_sprites/pudding/2.png',
  ),
  strawberryCupcake(
    displayName: "Strawberry Cupcake",
    price: 50,
    oshiriPoints: 10,
    hungerPoints: 20,
    energyPoints: 30,
    iconFlutterPath: 'assets/images/consumable_sprites/pudding/2.png',
  );

  const Snack({
    required this.displayName,
    required this.price,
    required this.oshiriPoints,
    required this.hungerPoints,
    required this.energyPoints,
    required this.iconFlutterPath,
  });
  final String displayName;
  final int price;
  final int oshiriPoints;
  final int hungerPoints;
  final int energyPoints;

  final String iconFlutterPath;
}
