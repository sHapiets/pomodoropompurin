enum Consumable {
  pudding(
    displayName: "Mama's Pudding",
    price: 0,
    totalBites: 2,
    oshiriPointsPerBite: 350,
    hungerPointsPerBite: 10,
    energyPointsPerBite: 15,
    iconFlutterPath: 'assets/images/consumable_sprites/pudding/2.png',
    biteSpritesFlamePath: [
      'consumable_sprites/pudding/1.png',
      'consumable_sprites/pudding/2.png',
    ],
  ),
  pizza(
    displayName: "Pizza",
    price: 0,
    totalBites: 4,
    oshiriPointsPerBite: 250,
    hungerPointsPerBite: 10,
    energyPointsPerBite: 8,
    iconFlutterPath: 'assets/images/consumable_sprites/pizza/4.png',
    biteSpritesFlamePath: [
      'consumable_sprites/pizza/1.png',
      'consumable_sprites/pizza/2.png',
      'consumable_sprites/pizza/3.png',
      'consumable_sprites/pizza/4.png',
    ],
  ),
  pancake(
    displayName: "Pancakes",
    price: 0,
    totalBites: 3,
    oshiriPointsPerBite: 200,
    hungerPointsPerBite: 8,
    energyPointsPerBite: 10,
    iconFlutterPath: 'assets/images/consumable_sprites/pancakes/3.png',
    biteSpritesFlamePath: [
      'consumable_sprites/pancakes/1.png',
      'consumable_sprites/pancakes/2.png',
      'consumable_sprites/pancakes/3.png',
    ],
  ),
  hamburgSteak(
    displayName: "Hamburg Steak",
    price: 0,
    totalBites: 5,
    oshiriPointsPerBite: 160,
    hungerPointsPerBite: 5,
    energyPointsPerBite: 5,
    iconFlutterPath: 'assets/images/consumable_sprites/hamburg_steak/5.png',
    biteSpritesFlamePath: [
      'consumable_sprites/hamburg_steak/1.png',
      'consumable_sprites/hamburg_steak/2.png',
      'consumable_sprites/hamburg_steak/3.png',
      'consumable_sprites/hamburg_steak/4.png',
      'consumable_sprites/hamburg_steak/5.png',
    ],
  ),
  omurice(
    displayName: "Omurice",
    price: 0,
    totalBites: 5,
    oshiriPointsPerBite: 120,
    hungerPointsPerBite: 5,
    energyPointsPerBite: 5,
    iconFlutterPath: 'assets/images/consumable_sprites/omurice/5.png',
    biteSpritesFlamePath: [
      'consumable_sprites/omurice/1.png',
      'consumable_sprites/omurice/2.png',
      'consumable_sprites/omurice/3.png',
      'consumable_sprites/omurice/4.png',
      'consumable_sprites/omurice/5.png',
    ],
  ),
  hamburger(
    displayName: "Hamburger",
    price: 0,
    totalBites: 4,
    oshiriPointsPerBite: 300,
    hungerPointsPerBite: 10,
    energyPointsPerBite: 8,
    iconFlutterPath: 'assets/images/consumable_sprites/hamburger/4.png',
    biteSpritesFlamePath: [
      'consumable_sprites/hamburger/1.png',
      'consumable_sprites/hamburger/2.png',
      'consumable_sprites/hamburger/3.png',
      'consumable_sprites/hamburger/4.png',
    ],
  ),
  lasagna(
    displayName: "Lasagna",
    price: 0,
    totalBites: 4,
    oshiriPointsPerBite: 300,
    hungerPointsPerBite: 20,
    energyPointsPerBite: 5,
    iconFlutterPath: 'assets/images/consumable_sprites/lasagna/4.png',
    biteSpritesFlamePath: [
      'consumable_sprites/lasagna/1.png',
      'consumable_sprites/lasagna/2.png',
      'consumable_sprites/lasagna/3.png',
      'consumable_sprites/lasagna/4.png',
    ],
  ),
  pomodoro(
    displayName: "Pomodoro Pasta",
    price: 0,
    totalBites: 4,
    oshiriPointsPerBite: 160,
    hungerPointsPerBite: 15,
    energyPointsPerBite: 5,
    iconFlutterPath: 'assets/images/consumable_sprites/pomodoro/4.png',
    biteSpritesFlamePath: [
      'consumable_sprites/pomodoro/1.png',
      'consumable_sprites/pomodoro/2.png',
      'consumable_sprites/pomodoro/3.png',
      'consumable_sprites/pomodoro/4.png',
    ],
  ),
  bechamel(
    displayName: "Béchamel Pasta",
    price: 0,
    totalBites: 4,
    oshiriPointsPerBite: 160,
    hungerPointsPerBite: 15,
    energyPointsPerBite: 5,
    iconFlutterPath: 'assets/images/consumable_sprites/bechamel/4.png',
    biteSpritesFlamePath: [
      'consumable_sprites/bechamel/1.png',
      'consumable_sprites/bechamel/2.png',
      'consumable_sprites/bechamel/3.png',
      'consumable_sprites/bechamel/4.png',
    ],
  );

  const Consumable({
    required this.displayName,
    required this.price,
    required this.totalBites,
    required this.oshiriPointsPerBite,
    required this.hungerPointsPerBite,
    required this.energyPointsPerBite,
    required this.iconFlutterPath,
    required this.biteSpritesFlamePath,
  });
  final String displayName;
  final int price;
  final int totalBites;
  final int oshiriPointsPerBite;
  final int hungerPointsPerBite;
  final int energyPointsPerBite;

  final String iconFlutterPath;
  final List<String> biteSpritesFlamePath;
}
