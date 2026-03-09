enum Consumable {
  pudding(
    displayName: "Mama's Pudding",
    price: 0,
    totalBites: 2,
    oshiriPointsPerBite: 400,
    spriteFlutterKey: 'pP_icon',
    biteSpritesFlamePath: [
      'consumable_sprites/pudding/1.png',
      'consumable_sprites/pudding/2.png',
    ],
  ),
  pizza(
    displayName: "Pizza",
    price: 0,
    totalBites: 4,
    oshiriPointsPerBite: 300,
    spriteFlutterKey: 'pP_icon',
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
    oshiriPointsPerBite: 250,
    spriteFlutterKey: 'pP_icon',
    biteSpritesFlamePath: [
      'consumable_sprites/pudding/1.png',
      'consumable_sprites/pudding/2.png',
      'consumable_sprites/pudding/1.png',
    ],
  ),
  hamburgSteak(
    displayName: "Hamburg Steak",
    price: 0,
    totalBites: 5,
    oshiriPointsPerBite: 250,
    spriteFlutterKey: 'pP_icon',
    biteSpritesFlamePath: [
      'consumable_sprites/pudding/1.png',
      'consumable_sprites/pudding/2.png',
      'consumable_sprites/pudding/1.png',
      'consumable_sprites/pudding/2.png',
      'consumable_sprites/pudding/1.png',
    ],
  );

  const Consumable({
    required this.displayName,
    required this.price,
    required this.totalBites,
    required this.oshiriPointsPerBite,
    required this.spriteFlutterKey,
    required this.biteSpritesFlamePath,
  });
  final String displayName;
  final int price;
  final int totalBites;
  final int oshiriPointsPerBite;

  final String spriteFlutterKey;
  final List<String> biteSpritesFlamePath;
}
