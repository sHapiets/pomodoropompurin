import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pomodoropompurin/scripts/authentication/account_manager.dart';
import 'package:pomodoropompurin/scripts/core/acquirables.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/shoe_achievement/shoe_achievement.dart';
import 'package:pomodoropompurin/scripts/foundation/consumable.dart';
import 'package:pomodoropompurin/scripts/foundation/date_log.dart';
import 'package:pomodoropompurin/scripts/foundation/ingridient.dart';

class DatabaseManager {
  DatabaseManager._();
  static final singleton = DatabaseManager._();

  final accountManager = AccountManager.singleton;

  // Easy access references, if ever needed...
  /// NOTE: userRef only points to YANA's data, while debugRef points to JOSEPH
  DocumentReference userRef = FirebaseFirestore.instance
      .collection("users")
      .doc("yana");
  // final userRef = FirebaseFirestore.instance.collection("users").doc("jd");

  CollectionReference get statusRef => userRef.collection('status');
  CollectionReference get configRef => userRef.collection('config');

  void reloadUserDocRef() {
    if (accountManager.currentUser == null) {
      return;
    }

    final userID = accountManager.currentUser!.uid;
    userRef = FirebaseFirestore.instance.collection("users").doc(userID);
  }

  Future<void> createUserDatabase() async {}

  /// Load Functions
  /// -> future functions that RETURNS the stored value
  /// -> usually called once for preloading (SplashPage)

  Future<dynamic> userDataLoad(String userData) async {
    // Load all necessary values from USER here...
    final dataDoc = await userRef.get();
    return dataDoc[userData];
  }

  Future<Map<ShoeAchievement, bool>> acquiredShoeAchievementLoad() async {
    final Map<ShoeAchievement, bool> shoeAchievementMap = {};
    shoeAchievementMap.addAll({ShoeAchievement.none: true});

    final acquiredShoeAchievementDoc = await userRef
        .collection('acquired')
        .doc('shoeAchievement')
        .get();

    final loadedShoeAchievementMap =
        acquiredShoeAchievementDoc['acquiredBoolMap'];

    for (final shoeAchievementMapEntry in loadedShoeAchievementMap.entries) {
      final shoeAchievement = ShoeAchievement.values.byName(
        shoeAchievementMapEntry.key,
      );
      final acquiredBool = shoeAchievementMapEntry.value;
      shoeAchievementMap.addAll({shoeAchievement: acquiredBool});
    }

    return shoeAchievementMap;
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

  Future<DocumentSnapshot> statusPomTimerLoad() async {
    final statusPomTimerRef = statusRef.doc('pomTimer');
    final statusPomTimerDoc = await statusPomTimerRef.get();

    return statusPomTimerDoc;
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

  Future<dynamic> configPurinVarLoad() async {
    final purinVarConfigRef = userRef.collection('config').doc('purin');
    final purinVarConfigDoc = await purinVarConfigRef.get();
    return purinVarConfigDoc['purinVar'];
  }

  Future<dynamic> statusLoadTutorialLoad() async {
    final statusTutorialRef = statusRef.doc('tutorial');
    final statusTutorialDoc = await statusTutorialRef.get();
    return statusTutorialDoc['loadTutorial'];
  }

  /// Save Functions
  /// -> to be called by other classes (mostly core singletons) to save data in Koupen
  /// -> instance of the DatabaseManager must be called before using
  /// -> each function takes the paramaters to be stored

  Future<void> userDataSave(String userData, dynamic data) async {
    await userRef.update({userData: data});
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

  Future<void> acquireShoeAchievementSave(
    ShoeAchievement acquiredShoeAchievement,
  ) async {
    final shoeAchievementMapRef = userRef
        .collection('acquired')
        .doc('shoeAchievement');

    shoeAchievementMapRef.update({
      'acquiredBoolMap.${acquiredShoeAchievement.name}': true,
    });
  }

  Future<void> statusPomTimerSave(String status, dynamic data) async {
    final statusPomTimerRef = statusRef.doc('pomTimer');
    await statusPomTimerRef.update({status: data});
  }

  Future<void> dayTimeSecondsSave(int timeTotalSeconds) async {
    final now = DateTime.now();

    final yearId = '${now.year}';
    final monthId = '${now.month}'.padLeft(2, '0');
    final dayId = '${now.day}'.padLeft(2, '0');

    final yearRef = userRef.collection('dates').doc(yearId);
    final monthRef = yearRef.collection('months').doc(monthId);
    final dayRef = monthRef.collection('days').doc(dayId);

    final yearSnap = await yearRef.get();
    if (!yearSnap.exists) {
      await yearRef.set({});
    }

    final monthSnap = await monthRef.get();
    if (!monthSnap.exists) {
      await monthRef.set({});
    }

    final daySnap = await dayRef.get();
    if (!daySnap.exists) {
      await dayRef.set({'timeSeconds': timeTotalSeconds});
    } else {
      await dayRef.update({'timeSeconds': timeTotalSeconds});
    }
  }

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

  Future<void> configKotatsuSave(KotatsuDesigns design) async {
    final selectablesConfigRef = userRef
        .collection('config')
        .doc('selectables');
    await selectablesConfigRef.update({'kotatsuDesign': design.name});
  }

  Future<void> configFeedableSave(Consumable consumable, int bitesLeft) async {
    final selectablesConfigRef = userRef
        .collection('config')
        .doc('selectables');
    await selectablesConfigRef.update({'feedable': consumable.name});
    await selectablesConfigRef.update({'feedableBitesLeft': bitesLeft});
  }

  Future<void> configPurinVarSave(PurinVars purinVar) async {
    final purinVarConfigRef = userRef.collection('config').doc('purin');
    await purinVarConfigRef.set({'purinVar': purinVar.name});
  }

  Future<void> statusLoadTutorialSave(bool loadTutorial) async {
    final statusTutorialRef = statusRef.doc('tutorial');
    await statusTutorialRef.set({'loadTutorial': loadTutorial});
  }
}
