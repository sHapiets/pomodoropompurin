import 'package:flutter/material.dart';

enum PurinAttributes {
  insight(
    icon: Icons.remove_red_eye_rounded,
    baseAttributeValueFromLevel: _baseInsightFromLevel,
  ),
  diligence(
    icon: Icons.manage_search_rounded,
    baseAttributeValueFromLevel: _baseDiligenceFromLevel,
  ),
  comfort(
    icon: Icons.king_bed,
    baseAttributeValueFromLevel: _baseComfortFromLevel,
  ),
  endurance(
    icon: Icons.battery_5_bar_rounded,
    baseAttributeValueFromLevel: _baseEnduranceFromLevel,
  ),
  metabolism(
    icon: Icons.autorenew_rounded,
    baseAttributeValueFromLevel: _baseMetabolismFromLevel,
  ),
  nutrition(
    icon: Icons.apple,
    baseAttributeValueFromLevel: _baseNutritionFromLevel,
  ),
  palate(
    icon: Icons.icecream_rounded,
    baseAttributeValueFromLevel: _basePalateFromLevel,
  ),
  bargaining(
    icon: Icons.monetization_on_rounded,
    baseAttributeValueFromLevel: _baseBargainingFromLevel,
  );

  const PurinAttributes({
    required this.baseAttributeValueFromLevel,
    required this.icon,
  });

  final int Function(int level) baseAttributeValueFromLevel;
  final IconData icon;

  // Focus scales well early for rewarding study consistency
  static int _baseInsightFromLevel(int level) {
    return 40 + (level * 2);
  }

  // Slow but steady growth
  static int _baseDiligenceFromLevel(int level) {
    return 30 + level;
  }

  // Comfort should rise moderately
  static int _baseComfortFromLevel(int level) {
    return 20 + ((level * 3) ~/ 2);
  }

  // Endurance benefits long-term players more
  static int _baseEnduranceFromLevel(int level) {
    return 25 + ((level * level) ~/ 20);
  }

  // Metabolism should scale gently to avoid zero hunger drain
  static int _baseMetabolismFromLevel(int level) {
    return 15 + ((level * 4) ~/ 5);
  }

  // Nutrition tied heavily to progression
  static int _baseNutritionFromLevel(int level) {
    return 10 + (level * 3);
  }

  // Palate grows slowly and elegantly
  static int _basePalateFromLevel(int level) {
    return 5 + ((level * level) ~/ 25);
  }

  // Bargaining becomes strong later-game
  static int _baseBargainingFromLevel(int level) {
    return 10 + ((level * 5) ~/ 2);
  }
}
