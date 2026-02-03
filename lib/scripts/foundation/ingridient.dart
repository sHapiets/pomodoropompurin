/// This class holds all types of ingridients in the app.
///
/// Ingridients are processed via the Kitchen selectables menus.
/// All processes are predefined given the selectable, which ultimately
/// creates a [Consumable]
///
/// Not all processes end up with
enum Ingridient {
  /// Raw (Purchasable)
  milk(
    displayName: "Milk",
    price: 50,
    spriteFlamePath: "ingridient_sprites/milk.png",
  ),
  eggs(
    displayName: "Eggs",
    price: 20,
    spriteFlamePath: "ingridient_sprites/eggs.png",
  ),
  butter(
    displayName: "Butter",
    price: 30,
    spriteFlamePath: "ingridient_sprites/butter.png",
  ),
  flour(
    displayName: "Flour",
    price: 40,
    spriteFlamePath: "ingridient_sprites/flour.png",
  ),
  yeast(
    displayName: "Yeast",
    price: 10,
    spriteFlamePath: "ingridient_sprites/yeast.png",
  ),
  olives(
    displayName: "Olives",
    price: 20,
    spriteFlamePath: "ingridient_sprites/olives.png",
  ),
  onion(
    displayName: "Onion",
    price: 10,
    spriteFlamePath: "ingridient_sprites/onion.png",
  ),
  tomato(
    displayName: "Tomato",
    price: 10,
    spriteFlamePath: "ingridient_sprites/tomato.png",
  ),
  riceGrains(
    displayName: "Rice Grains",
    price: 15,
    spriteFlamePath: "ingridient_sprites/riceGrains.png",
  ),
  groundPork(
    displayName: "Ground Pork",
    price: 80,
    spriteFlamePath: "ingridient_sprites/groundPork.png",
  ),

  /// Processed
  puddingCream(
    displayName: "Pudding Cream",
    price: 0,
    spriteFlamePath: "ingridient_sprites/puddingCream.png",
  ),
  puddingBatter(
    displayName: "Pudding Batter",
    price: 0,
    spriteFlamePath: "ingridient_sprites/puddingBatter.png",
  ),
  pancakeBatter(
    displayName: "Pancake Batter",
    price: 0,
    spriteFlamePath: "ingridient_sprites/pancakeBatter.png",
  ),
  dough(
    displayName: "Dough",
    price: 0,
    spriteFlamePath: "ingridient_sprites/dough.png",
  ),
  pizzaToppings(
    displayName: "Pizza Toppings",
    price: 0,
    spriteFlamePath: "ingridient_sprites/pizzaToppings.png",
  ),
  washedRice(
    displayName: "Washed Rice",
    price: 0,
    spriteFlamePath: "ingridient_sprites/washedRice.png",
  ),
  cookedRice(
    displayName: "Cooked Rice",
    price: 0,
    spriteFlamePath: "ingridient_sprites/cookedRice.png",
  ),
  choppedOnions(
    displayName: "Chopped Onions",
    price: 0,
    spriteFlamePath: "ingridient_sprites/choppedOnions.png",
  ),
  patty(
    displayName: "Patty",
    price: 0,
    spriteFlamePath: "ingridient_sprites/patty.png",
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
