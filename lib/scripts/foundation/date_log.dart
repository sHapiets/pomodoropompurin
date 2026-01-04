// DateLog object, instantiated for one day
import 'package:cloud_firestore/cloud_firestore.dart';

/// For now, contains its
/// 1. date
/// 2. time (seconds) as count for heatmap
/// 3. etc idk pa
class DateLog {
  DateTime dateLogDate;
  int timeSeconds;

  DateLog({required this.dateLogDate, required this.timeSeconds});

  factory DateLog.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    int month,
    int year,
  ) {
    final data = doc.data();

    return DateLog(
      dateLogDate: DateTime(year, month, int.parse(doc.id)),
      timeSeconds: data?['timeSeconds'],
    );
  }
}
