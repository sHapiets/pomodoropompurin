enum ShoeAchievement {
  slippers(
    secondsRequirement: 18000,
    displayName: "Ol' Inddor Slippers",
    flutterAssetPath: "assets/images/shoe_achievement_icons/slippers.png",
  ),
  sneakers(
    secondsRequirement: 72000,
    displayName: "Casual Sneakers",
    flutterAssetPath: "assets/images/shoe_achievement_icons/sneakers.png",
  );

  const ShoeAchievement({
    required this.secondsRequirement,
    required this.displayName,
    required this.flutterAssetPath,
  });
  final int secondsRequirement;
  final String displayName;
  final String flutterAssetPath;
}
