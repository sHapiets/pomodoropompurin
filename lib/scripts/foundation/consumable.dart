enum Consumable {
  pudding(
    price: 100,
    totalBites: 2,
    oshiriPointsPerBite: 10,
    spriteFlutterKey: 'pP_icon',
    biteSpritesFlamePath: [
      'consumable_sprites/pudding/1.png',
      'consumable_sprites/pudding/2.png',
    ],
  );

  const Consumable({
    required this.price,
    required this.totalBites,
    required this.oshiriPointsPerBite,
    required this.spriteFlutterKey,
    required this.biteSpritesFlamePath,
  });
  final int price;
  final int totalBites;
  final int oshiriPointsPerBite;

  final String spriteFlutterKey;
  final List<String> biteSpritesFlamePath;
}
