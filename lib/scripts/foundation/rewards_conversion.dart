class PomPointsConversion {
  static int fromSeconds(int seconds, double multiplier) {
    final basePoints = (seconds / 9).floor();
    return (basePoints * multiplier).floor();
  }
}

class OshiriPointsConversion {
  static int fromSeconds(int seconds, double multiplier) {
    final basePoints = (seconds / 15).floor();
    return (basePoints * multiplier).floor();
  }
}

class PointMultiplier {
  static double fromEnergy(int energy) {
    if (energy <= 20) return 0.5;
    if (energy <= 40) return 0.7;
    if (energy <= 60) return 0.9;
    if (energy <= 80) return 1.0;
    return 1.15;
  }
}
