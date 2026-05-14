import 'package:flutter/foundation.dart';

class Sanrio2026Voting {
  bool isActive = false;
  ValueNotifier<int> votes = ValueNotifier(0);

  void initialize(int initVotes) {
    final DateTime votingDeadline = DateTime(2026, 5, 24, 23, 59);
    isActive = votingDeadline.difference(DateTime.now()).inSeconds >= 0;
    if (!isActive) {
      return;
    }

    votes.addListener(award);
  }

  void addVote() {
    votes.value += 1;
  }

  void award() {}
}
