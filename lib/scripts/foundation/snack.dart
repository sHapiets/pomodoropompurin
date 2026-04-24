enum Snack {
  potatoChips(
    displayName: "Potato Chips",
    price: 5,
    oshiriPoints: 10,
    hungerPoints: 15,
    energyPoints: 5,
    iconFlutterPath: 'assets/images/snack_sprites/potatoChips.png',
  ),
  hotCocoa(
    displayName: "Hot Cocoa",
    price: 10,
    oshiriPoints: 5,
    hungerPoints: 3,
    energyPoints: 20,
    iconFlutterPath: 'assets/images/snack_sprites/hotCocoa.png',
  ),
  cheeseIceCream(
    displayName: "Cheese Ice Cream",
    price: 20,
    oshiriPoints: 20,
    hungerPoints: 10,
    energyPoints: 15,
    iconFlutterPath: 'assets/images/snack_sprites/cheeseIceCream.png',
  ),
  chocloateIceCream(
    displayName: "Chocolate Ice Cream",
    price: 20,
    oshiriPoints: 20,
    hungerPoints: 25,
    energyPoints: 0,
    iconFlutterPath: 'assets/images/snack_sprites/chocolateIceCream.png',
  ),
  cncIceCream(
    displayName: "C&C Ice Cream",
    price: 20,
    oshiriPoints: 20,
    hungerPoints: 0,
    energyPoints: 25,
    iconFlutterPath: 'assets/images/snack_sprites/cncIceCream.png',
  ),
  caramelPretzel(
    displayName: "Caramel Pretzel",
    price: 25,
    oshiriPoints: 20,
    hungerPoints: 30,
    energyPoints: 5,
    iconFlutterPath: 'assets/images/snack_sprites/caramelPretzel.png',
  ),
  creamPretzel(
    displayName: "Cream Pretzel",
    price: 25,
    oshiriPoints: 20,
    hungerPoints: 5,
    energyPoints: 30,
    iconFlutterPath: 'assets/images/snack_sprites/creamPretzel.png',
  ),
  chocolateCupcake(
    displayName: "Chocolate Cupcake",
    price: 30,
    oshiriPoints: 10,
    hungerPoints: 30,
    energyPoints: 20,
    iconFlutterPath: 'assets/images/snack_sprites/chocolateCupcake.png',
  ),
  strawberryCupcake(
    displayName: "Strawberry Cupcake",
    price: 30,
    oshiriPoints: 10,
    hungerPoints: 20,
    energyPoints: 30,
    iconFlutterPath: 'assets/images/snack_sprites/strawberryCupcake.png',
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
