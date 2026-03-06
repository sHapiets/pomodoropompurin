class PomPointsConversion {
  static int fromSeconds(int seconds) {
    final points = (seconds / 9).floor();
    return points;
  }
}

class OshiriPointsConversion {
  static int fromSeconds(int seconds) {
    final points = (seconds / 15).floor();
    return points;
  }
}
