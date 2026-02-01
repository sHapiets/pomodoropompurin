import 'package:pomodoropompurin/scripts/foundation/ingridient.dart';

enum Consumable {
  pudding(
    displayName: "Mama's Pudding",
    price: 100,
    totalBites: 2,
    oshiriPointsPerBite: 10,
    spriteFlutterKey: 'pP_icon',
    biteSpritesFlamePath: [
      'consumable_sprites/pudding/1.png',
      'consumable_sprites/pudding/2.png',
    ],
    ingridients: {Ingridient.milk: 1, Ingridient.eggs: 1},
  );

  const Consumable({
    required this.displayName,
    required this.price,
    required this.totalBites,
    required this.oshiriPointsPerBite,
    required this.spriteFlutterKey,
    required this.biteSpritesFlamePath,
    required this.ingridients,
  });
  final String displayName;
  final int price;
  final int totalBites;
  final int oshiriPointsPerBite;

  final String spriteFlutterKey;
  final List<String> biteSpritesFlamePath;

  final Map<Ingridient, int> ingridients;
}
