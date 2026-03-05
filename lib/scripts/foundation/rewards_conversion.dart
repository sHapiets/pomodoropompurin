class PomPointsConversion {
  static int fromSeconds(int seconds) {
    final points = (seconds / 30).ceil();
    return points;
  }
}

class OshiriPointsConversion {
  static int fromSeconds(int seconds) {
    final points = (seconds / 30).ceil();
    return points;
  }
}
