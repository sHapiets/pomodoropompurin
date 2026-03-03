import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:pomodoropompurin/scripts/core/acquirables.dart';
import 'package:pomodoropompurin/scripts/foundation/consumable.dart';
import 'package:pomodoropompurin/scripts/foundation/date_log.dart';
import 'package:pomodoropompurin/scripts/foundation/ingridient.dart';

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

  Future<Map<Ingridient, int>> ingridientInventoryLoad() async {
    Map<Ingridient, int> loadedInventory = {};

    final amountMap = await userDataLoad('ingridientInventory');
    for (final amountMapEntry in amountMap.entries) {
      final ingridient = Ingridient.values.asNameMap()[amountMapEntry.key]!;
      loadedInventory.addAll({ingridient: amountMapEntry.value});
    }

    return loadedInventory;
  }

  Future<Map<Consumable, int>> consumableInventoryLoad() async {
    Map<Consumable, int> loadedInventory = {};

    final amountMap = await userDataLoad('consumableInventory');
    for (final amountMapEntry in amountMap.entries) {
      final consumable = Consumable.values.asNameMap()[amountMapEntry.key]!;
      loadedInventory.addAll({consumable: amountMapEntry.value});
    }

    return loadedInventory;
  }

  Future<dynamic> userConfigTimerLoad(String configTimerData) async {
    final configTimerDoc = await configRef.doc('pomTimer').get();
    return configTimerDoc[configTimerData];
  }

  //
  Future<Map<int, Map<int, List<DateLog>>>> calendarLoad() async {
    Map<int, Map<int, List<DateLog>>> calendarMap = {};

    final yearsStored = await userRef.collection("dates").get();
    for (final year in yearsStored.docs) {
      final year_ = year.id.toString().padLeft(4, '0');
      final yearNum = int.parse(year_);
      final monthsStored = await userRef
          .collection("dates")
          .doc(year_)
          .collection('months')
          .get();

      calendarMap.addAll({yearNum: {}});

      for (final month in monthsStored.docs) {
        final month_ = month.id.toString().padLeft(2, '0');
        final monthNum = int.parse(month_);
        final daysStored = await userRef
            .collection("dates")
            .doc(year_)
            .collection('months')
            .doc(month_)
            .collection("days")
            .get();

        final logs = daysStored.docs
            .map((doc) => DateLog.fromFirestore(doc, monthNum, yearNum))
            .toList();

        calendarMap[yearNum]!.addAll({monthNum: logs});
      }
    }
    return calendarMap;
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

  Future<void> ingridientInventorySave(Map<Ingridient, int> amountMap) async {
    Map<String, int> updateMap = {};

    for (MapEntry<Ingridient, int> ingridientEntry in amountMap.entries) {
      final ingridient = ingridientEntry.key;
      final amount = ingridientEntry.value;

      updateMap.addAll({'ingridientInventory.${ingridient.name}': amount});
    }

    await userRef.update(updateMap);
  }

  Future<void> consumableInventorySave(Map<Consumable, int> amountMap) async {
    Map<String, int> updateMap = {};

    for (MapEntry<Consumable, int> consumableEntry in amountMap.entries) {
      final consumable = consumableEntry.key;
      final amount = consumableEntry.value;

      updateMap.addAll({'consumableInventory.${consumable.name}': amount});
    }

    await userRef.update(updateMap);
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
    await dayRef.set({'timeSeconds': timeTotalSeconds});
  }

  Future<void> configKotatsuSave(KotatsuDesigns design) async {
    final selectablesConfigRef = userRef
        .collection('config')
        .doc('selectables');
    await selectablesConfigRef.update({'kotatsuDesign': design.name});
  }
}
