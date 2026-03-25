class HungerPointsConversion {
  static int fromInactiveDuration(int currentHungerPoints, Duration duration) {
    final int totalMinutes = duration.inMinutes;
    const int minutesPerHungerPoint = 4;

    const int minInactiveHunger = 25;
    const int maxInactiveHunger = 100;

    final consumedHungerPoints = (totalMinutes / minutesPerHungerPoint).floor();
    final newHungerPoints = (currentHungerPoints - consumedHungerPoints).clamp(
      minInactiveHunger,
      maxInactiveHunger,
    );
    return newHungerPoints;
  }
}

class EnergyPointsConversion {
  static int fromInactiveDuration(int currentEnergyPoints, Duration duration) {
    final int totalMinutes = duration.inMinutes;
    const int minutesPerEnergyPoint = 1;

    const int minInactiveEnergy = 0;
    const int maxInactiveEnergy = 100;

    final consumedEnergyPoints = (totalMinutes / minutesPerEnergyPoint).floor();
    final newEnergyPoints = (currentEnergyPoints + consumedEnergyPoints).clamp(
      minInactiveEnergy,
      maxInactiveEnergy,
    );
    return newEnergyPoints;
  }
}
