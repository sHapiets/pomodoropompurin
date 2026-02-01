enum Ingridient {
  milk(
    displayName: "Milk",
    price: 50,
    spriteFlamePath: "ingridient_sprites/milk.png",
  ),
  eggs(
    displayName: "Eggs",
    price: 20,
    spriteFlamePath: "ingridient_sprites/eggs.png",
  );

  const Ingridient({
    required this.displayName,
    required this.price,
    required this.spriteFlamePath,
  });

  final String displayName;
  final int price;
  final String spriteFlamePath;
}
