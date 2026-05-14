import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:pomodoropompurin/scripts/memory/database_manager.dart';

class Sanrio2026Voting {
  Sanrio2026Voting._();
  static final singleton = Sanrio2026Voting._();

  final databaseManager = DatabaseManager.singleton;

  DateTime latestVote = DateTime.now();

  DateTime toDateOnly(DateTime dt) {
    return DateTime(dt.year, dt.month, dt.day);
  }

  bool get isActive {
    final DateTime votingDeadline = DateTime(2026, 5, 24, 23, 59);
    return DateTime.now().isBefore(votingDeadline);
  }

  bool get votableToday {
    final today = toDateOnly(DateTime.now());
    final lastVoteDay = toDateOnly(latestVote);

    return today.difference(lastVoteDay).inDays >= 1;
  }

  ValueNotifier<int> votes = ValueNotifier(0);

  void initialize(DocumentSnapshot eventDoc) {
    if (!isActive) {
      return;
    }

    votes.value = eventDoc["votes"];
    final Timestamp latestVoteTimestamp = eventDoc["latestVote"];
    latestVote = latestVoteTimestamp.toDate();

    votes.addListener(award);
  }

  void addVote() {
    votes.value += 1;
    latestVote = DateTime.now();
    databaseSave();
  }

  void award() {}

  void databaseSave() {
    databaseManager.statusSanrio2026Save(votes.value, latestVote);
  }
}
