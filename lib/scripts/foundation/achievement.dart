abstract class Achievement {
  Achievement({required this.goal});

  final int goal;
  int progress = 0;

  bool get achieved => progress >= goal;

  void setProgress(int progress) {
    this.progress = progress;
  }

  void addProgress(int progress) {
    this.progress += progress;
    if (this.progress > goal) {
      this.progress = goal;
    }
  }
}
