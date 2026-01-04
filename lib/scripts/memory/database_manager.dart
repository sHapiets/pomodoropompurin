import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pomodoropompurin/scripts/foundation/date_log.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer.dart';
import 'package:pomodoropompurin/scripts/core/prog_system.dart';

class DatabaseManager {
  DatabaseManager._();
  static final singleton = DatabaseManager._();

  final progSystem = ProgSystem.singleton;
  final _pomTimer = PomTimer.singleton;

  // Easy access references, if ever needed...
  /// NOTE: userRef only points to YANA's data
  final userRef = FirebaseFirestore.instance.collection("users").doc("yana");

  Future<dynamic> userDataLoad(String userData) async {
    // These are temporary constant loads for the timer to works, SHOULD BE DELETED soon!
    _pomTimer.timeSetWorkSeconds = 5;
    _pomTimer.timeSetBreakSeconds = 3;

    // Load all necessary values from USER here...
    final dataDoc = await userRef.get();
    return dataDoc[userData];
  }

  Future<void> userDataSave(String userData, dynamic data) async {
    await userRef.set({userData: data}).then((onValue) => debugPrint('nice'));
  }

  //
  Future<List<DateLog>> calendarMonthLoad(int year, int month) async {
    final year_ = year.toString().padLeft(4, '0');
    final month_ = month.toString().padLeft(2, '0');

    final daysRef = userRef
        .collection("dates")
        .doc(year_)
        .collection('months')
        .doc(month_)
        .collection("days");
    final daysList = await daysRef.get();

    final logs = daysList.docs
        .map((doc) => DateLog.fromFirestore(doc, month, year))
        .toList();
    return logs;
  }
}
