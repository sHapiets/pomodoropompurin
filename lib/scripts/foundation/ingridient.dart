import 'package:flutter/material.dart';

/// This class holds all types of ingridients in the app.
///
/// Ingridients are processed via the Kitchen selectables menus.
/// All processes are predefined given the selectable, which ultimately
/// creates a [Consumable]
///
/// Not all processes end up with
enum Ingridient {
  /// RAW INGREDIENTS
  milk(
    displayName: "Milk",
    type: IngridientType.dairy,
    price: 150,
    spriteFlutterPath: "assets/images/ingridient_sprites/milk.png",
  ),
  eggs(
    displayName: "Eggs",
    type: IngridientType.protein,
    price: 35,
    spriteFlutterPath: "assets/images/ingridient_sprites/eggs.png",
  ),
  butter(
    displayName: "Butter",
    type: IngridientType.dairy,
    price: 120,
    spriteFlutterPath: "assets/images/ingridient_sprites/butter.png",
  ),
  flour(
    displayName: "Flour",
    type: IngridientType.carbs,
    price: 135,
    spriteFlutterPath: "assets/images/ingridient_sprites/flour.png",
  ),
  yeast(
    displayName: "Yeast",
    type: IngridientType.carbs,
    price: 15,
    spriteFlutterPath: "assets/images/ingridient_sprites/yeast.png",
  ),
  olives(
    displayName: "Olives",
    type: IngridientType.veggies,
    price: 55,
    spriteFlutterPath: "assets/images/ingridient_sprites/olives.png",
  ),
  onion(
    displayName: "Onion",
    type: IngridientType.veggies,
    price: 35,
    spriteFlutterPath: "assets/images/ingridient_sprites/onion.png",
  ),
  tomato(
    displayName: "Tomato",
    type: IngridientType.veggies,
    price: 50,
    spriteFlutterPath: "assets/images/ingridient_sprites/tomato.png",
  ),
  riceGrains(
    displayName: "Rice Grains",
    type: IngridientType.carbs,
    price: 60,
    spriteFlutterPath: "assets/images/ingridient_sprites/riceGrains.png",
  ),
  groundPork(
    displayName: "Ground Pork",
    type: IngridientType.protein,
    price: 270,
    spriteFlutterPath: "assets/images/ingridient_sprites/groundPork.png",
  ),

  /// PROCESSED / INTERMEDIATE
  puddingCream(
    displayName: "Pudding Cream",
    type: IngridientType.dairy,
    price: 240,
    spriteFlutterPath: "assets/images/ingridient_sprites/puddingCream.png",
  ),
  puddingBatter(
    displayName: "Pudding Batter",
    type: IngridientType.dairy,
    price: 360,
    spriteFlutterPath: "assets/images/ingridient_sprites/puddingBatter.png",
  ),
  pancakeBatter(
    displayName: "Pancake Batter",
    type: IngridientType.carbs,
    price: 220,
    spriteFlutterPath: "assets/images/ingridient_sprites/pancakeBatter.png",
  ),
  dough(
    displayName: "Dough",
    type: IngridientType.carbs,
    price: 180,
    spriteFlutterPath: "assets/images/ingridient_sprites/dough.png",
  ),
  pizzaToppings(
    displayName: "Pizza Toppings",
    type: IngridientType.veggies,
    price: 240,
    spriteFlutterPath: "assets/images/ingridient_sprites/pizzaToppings.png",
  ),
  washedRice(
    displayName: "Washed Rice",
    type: IngridientType.carbs,
    price: 80,
    spriteFlutterPath: "assets/images/ingridient_sprites/washedRice.png",
  ),
  cookedRice(
    displayName: "Cooked Rice",
    type: IngridientType.carbs,
    price: 80,
    spriteFlutterPath: "assets/images/ingridient_sprites/cookedRice.png",
  ),
  choppedOnions(
    displayName: "Chopped Onions",
    type: IngridientType.veggies,
    price: 50,
    spriteFlutterPath: "assets/images/ingridient_sprites/choppedOnions.png",
  ),
  patty(
    displayName: "Patty",
    type: IngridientType.protein,
    price: 320,
    spriteFlutterPath: "assets/images/ingridient_sprites/patty.png",
  ),
  omelette(
    displayName: "Omelette",
    type: IngridientType.protein,
    price: 230,
    spriteFlutterPath: "assets/images/ingridient_sprites/omelette.png",
  ),
  tomatoSauce(
    displayName: "Tomato Sauce",
    type: IngridientType.sauce,
    price: 160,
    spriteFlutterPath: "assets/images/ingridient_sprites/tomatoSauce.png",
  ),
  creamySauce(
    displayName: "Creamy Sauce",
    type: IngridientType.sauce,
    price: 160,
    spriteFlutterPath: "assets/images/ingridient_sprites/creamySauce.png",
  ),
  lasagnaSauce(
    displayName: "Lasagna Sauce",
    type: IngridientType.sauce,
    price: 320,
    spriteFlutterPath: "assets/images/ingridient_sprites/lasagnaSauce.png",
  ),
  lasagnaSheets(
    displayName: "Lasagna Sheets",
    type: IngridientType.carbs,
    price: 200,
    spriteFlutterPath: "assets/images/ingridient_sprites/lasagnaSheets.png",
  ),
  spaghetti(
    displayName: "Spaghetti",
    type: IngridientType.carbs,
    price: 200,
    spriteFlutterPath: "assets/images/ingridient_sprites/spaghetti.png",
  );

  const Ingridient({
    required this.displayName,
    required this.type,
    required this.price,
    required this.spriteFlutterPath,
  });

  final String displayName;
  final IngridientType type;
  final int price;
  final String spriteFlutterPath;
}

enum IngridientType {
  dairy(displayName: "Dairy", icon: Icons.local_drink),
  protein(displayName: "Protein", icon: Icons.egg),
  carbs(displayName: "Carbs", icon: Icons.bakery_dining_rounded),
  veggies(displayName: "Veggies", icon: Icons.grass_rounded),
  sauce(displayName: "Sauce", icon: Icons.soup_kitchen_rounded);

  const IngridientType({required this.displayName, required this.icon});

  final String displayName;
  final IconData icon;
}
