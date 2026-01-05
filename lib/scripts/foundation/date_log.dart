import 'package:cloud_firestore/cloud_firestore.dart';

/// A foundation class which represents a collection of data for
/// one particular day.
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
