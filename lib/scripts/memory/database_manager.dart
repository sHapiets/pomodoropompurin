import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pomodoropompurin/scripts/core/acquirables.dart';
import 'package:pomodoropompurin/scripts/foundation/date_log.dart';

class DatabaseManager {
  DatabaseManager._();
  static final singleton = DatabaseManager._();

  // Easy access references, if ever needed...
  /// NOTE: userRef only points to YANA's data, while debugRef points to JOSEPH
  final userRef = FirebaseFirestore.instance.collection("users").doc("yana");
  // final userRef = FirebaseFirestore.instance.collection("users").doc("jd");

  CollectionReference get statusRef => userRef.collection('status');
  CollectionReference get configRef => userRef.collection('config');

  /// Load Functions
  /// -> future functions that RETURNS the stored value
  /// -> usually called once for preloading (SplashPage)

  Future<dynamic> userDataLoad(String userData) async {
    // Load all necessary values from USER here...
    final dataDoc = await userRef.get();
    return dataDoc[userData];
  }

  Future<dynamic> userConfigTimerLoad(String configTimerData) async {
    final configTimerDoc = await configRef.doc('pomTimer').get();
    return configTimerDoc[configTimerData];
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

  Future<Map<String, dynamic>> configSelectablesLoad() async {
    final selectablesConfigRef = userRef
        .collection('config')
        .doc('selectables');
    final selectablesConfigDoc = await selectablesConfigRef.get();
    return selectablesConfigDoc.data()!;
  }

  /// Save Functions
  /// -> to be called by other classes (mostly core singletons) to save data in Koupen
  /// -> instance of the DatabaseManager must be called before using
  /// -> each function takes the paramaters to be stored

  Future<void> userConfigTimerSave(
    int timeWorkSeconds,
    int timeBreakSeconds,
    int loopsSet,
  ) async {
    final configTimerRef = userRef.collection('config').doc('pomTimer');
    await configTimerRef.set({
      'timeSetWorkSeconds': timeWorkSeconds,
      'timeSetBreakSeconds': timeBreakSeconds,
      'loopsSet': loopsSet,
    });
  }

  Future<void> userDataSave(String user, dynamic data) async {
    await userRef.update({user: data});
  }

  Future<void> statusPomTimerSave(String status, dynamic data) async {
    final statusPomTimerRef = statusRef.doc('pomTimer');
    await statusPomTimerRef.update({status: data});
  }

  Future<void> dayTimeSecondsSave(int timeTotalSeconds) async {
    final dayRef = userRef
        .collection('dates')
        .doc('${DateTime.now().year}')
        .collection('months')
        .doc('${DateTime.now().month}'.padLeft(2, '0'))
        .collection('days')
        .doc('${DateTime.now().day}'.padLeft(2, '0'));
    await dayRef.update({'timeSeconds': timeTotalSeconds});
  }

  Future<void> configKotatsuSave(KotatsuDesigns design) async {
    final selectablesConfigRef = userRef
        .collection('config')
        .doc('selectables');
    await selectablesConfigRef.update({'kotatsuDesign': design.name});
  }
}
