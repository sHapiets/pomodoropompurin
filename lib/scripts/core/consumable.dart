enum Consumable {
  pudding(
    price: 100,
    totalBites: 3,
    oshiriPointsPerBite: 10,
    spriteFlutterKey: 'pP_icon',
    biteSpritesFlamePath: [],
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
