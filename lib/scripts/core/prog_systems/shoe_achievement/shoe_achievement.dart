enum ShoeAchievement {
  none(secondsRequirement: 0, displayName: "None"),
  slippers(secondsRequirement: 600, displayName: "Ol' Inddor Slippers"),
  sneakers(secondsRequirement: 36000, displayName: "Volleyball Sneakers");

  const ShoeAchievement({
    required this.secondsRequirement,
    required this.displayName,
  });
  final int secondsRequirement;
  final String displayName;
}
