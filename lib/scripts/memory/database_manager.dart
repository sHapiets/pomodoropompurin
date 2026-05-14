import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pomodoropompurin/scripts/authentication/account_manager.dart';
import 'package:pomodoropompurin/scripts/core/acquirables.dart';
import 'package:pomodoropompurin/scripts/core/event_systems/achievement_events/achievement_types/focus_time_achievement.dart';
import 'package:pomodoropompurin/scripts/core/event_systems/achievement_events/achievement_types/pet_achievement.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/purin_var/purin_var.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/shoe_achievement/shoe_achievement.dart';
import 'package:pomodoropompurin/scripts/core/version_control/client_version_manager.dart';
import 'package:pomodoropompurin/scripts/foundation/client_version.dart';
import 'package:pomodoropompurin/scripts/foundation/consumable.dart';
import 'package:pomodoropompurin/scripts/foundation/date_log.dart';
import 'package:pomodoropompurin/scripts/foundation/ingridient.dart';
import 'package:pomodoropompurin/scripts/foundation/snack.dart';

class DatabaseManager {
  DatabaseManager._();
  static final singleton = DatabaseManager._();

  final accountManager = AccountManager.singleton;

  // Easy access references, if ever needed...
  DocumentReference userRef = FirebaseFirestore.instance
      .collection("users")
      .doc("yana");
  CollectionReference get statusRef => userRef.collection('status');
  CollectionReference get configRef => userRef.collection('config');

  void changeUser(String user) {
    userRef = FirebaseFirestore.instance.collection('users').doc(user);
  }

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

  Future<DateTime> latestActivityLoad() async {
    final dataDoc = await userRef.collection('activity').doc('latest').get();
    final latestActivityDateMap = dataDoc['log'];

    final DateTime latestActivityDateTime = DateTime(
      latestActivityDateMap['year'],
      latestActivityDateMap['month'],
      latestActivityDateMap['day'],
      latestActivityDateMap['hour'],
      latestActivityDateMap['minute'],
    );

    return latestActivityDateTime;
  }

  Future<Map<ShoeAchievement, bool>> acquiredShoeAchievementLoad() async {
    final Map<ShoeAchievement, bool> shoeAchievementMap = {};

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

  Future<Map<Snack, int>> snacksInventoryLoad() async {
    Map<Snack, int> loadedInventory = {};

    final amountMap = await userDataLoad('snacksInventory');
    for (final amountMapEntry in amountMap.entries) {
      final snack = Snack.values.asNameMap()[amountMapEntry.key]!;
      loadedInventory.addAll({snack: amountMapEntry.value});
    }

    return loadedInventory;
  }

  Future<Map<String, dynamic>> statusPurinMetricsLoad() async {
    final purinStatusRef = statusRef.doc('purin');
    final purinStatusDoc = await purinStatusRef.get();

    final purinStatus = {
      'hunger': purinStatusDoc['hunger'],
      'energy': purinStatusDoc['energy'],
    };

    return purinStatus;
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

  Future<DocumentSnapshot> statusDailyAchievementLoad() async {
    final statusDailyAchievementRef = statusRef.doc('dailyAchievement');
    final statusDailyAchievementDoc = await statusDailyAchievementRef.get();

    return statusDailyAchievementDoc;
  }

  Future<DocumentSnapshot> statusStreakLoad() async {
    final statusStreakRef = statusRef.doc('streak');
    final statusStreakDoc = await statusStreakRef.get();

    return statusStreakDoc;
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

  Future<dynamic> configVolumeLoad() async {
    final audioRef = userRef.collection('config').doc('audio');
    final audioDoc = await audioRef.get();
    return audioDoc['volume'];
  }

  Future<dynamic> statusLoadTutorialLoad() async {
    final statusTutorialRef = statusRef.doc('tutorial');
    final statusTutorialDoc = await statusTutorialRef.get();
    return statusTutorialDoc['loadTutorial'];
  }

  Future<dynamic> versionClientLoad() async {
    final clientVCSDoc = await userRef.collection('vcs').doc('client').get();
    return clientVCSDoc['version'];
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

  Future<void> snacksInventorySave(Map<Snack, int> amountMap) async {
    Map<String, int> updateMap = {};

    for (MapEntry<Snack, int> snackEntry in amountMap.entries) {
      final snack = snackEntry.key;
      final amount = snackEntry.value;

      updateMap.addAll({'snacksInventory.${snack.name}': amount});
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

  Future<void> statusHungerSave(int hungerPoints) async {
    final purinStatusRef = statusRef.doc('purin');
    purinStatusRef.update({'hunger': hungerPoints});
  }

  Future<void> statusEnergySave(int energyPoints) async {
    final purinStatusRef = statusRef.doc('purin');
    purinStatusRef.update({'energy': energyPoints});
  }

  Future<void> statusPomTimerSave({
    required bool wasActive,
    required int wasTimeTotalSeconds,
    required double wasMultiplierTotal,
  }) async {
    final statusPomTimerRef = statusRef.doc('pomTimer');
    await statusPomTimerRef.update({
      'wasActive': wasActive,
      'wasTimeTotalSeconds': wasTimeTotalSeconds,
      'wasMultiplierTotal': wasMultiplierTotal,
    });
  }

  Future<void> statusDailyAchievementLatestRefreshSave(
    DateTime latestRefresh,
  ) async {
    final dailyAchievementRef = statusRef.doc('dailyAchievement');
    final refreshTimestamp = Timestamp.fromDate(latestRefresh);
    dailyAchievementRef.update({'latestRefresh': refreshTimestamp});
  }

  Future<void> statusDailyAchievementFocusTimeSave(
    FocusTimeAchievement focusTimeAchievement,
  ) async {
    final dailyAchievementRef = statusRef.doc('dailyAchievement');
    dailyAchievementRef.update({
      'focusTime': {
        'claimed': focusTimeAchievement.claimed,
        'goalSeconds': focusTimeAchievement.goal,
        'progress': focusTimeAchievement.progress,
      },
    });
  }

  Future<void> statusDailyAchievementPetSave(
    PetAchievement petAchievement,
  ) async {
    final dailyAchievementRef = statusRef.doc('dailyAchievement');
    dailyAchievementRef.update({
      'petEnergy': {
        'claimed': petAchievement.claimed,
        'goalEnergy': petAchievement.goal,
        'progress': petAchievement.progress,
      },
    });
  }

  Future<void> statusStreakSave(
    bool claimed,
    int current,
    int focusTime,
    DateTime latestCompletion,
  ) async {
    Timestamp latestCompletionTimestamp = Timestamp.fromDate(latestCompletion);
    final statusStreakRef = statusRef.doc('streak');
    statusStreakRef.update({
      'claimed': claimed,
      'current': current,
      'focusTime': focusTime,
      'latestCompletion': latestCompletionTimestamp,
    });
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

  Future<void> latestActivitySave() async {
    final now = DateTime.now();
    final latestActivityDateMap = {
      'year': now.year,
      'month': now.month,
      'day': now.day,
      'hour': now.hour,
      'minute': now.minute,
    };
    final latestActivityRef = userRef.collection('activity').doc('latest');

    await latestActivityRef.update({'log': latestActivityDateMap});
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

  Future<void> configPurinVarSave(PurinVar purinVar) async {
    final purinVarConfigRef = userRef.collection('config').doc('purin');
    await purinVarConfigRef.update({'purinVar': purinVar.name});
  }

  Future<void> configVolumeSave(double volume) async {
    final audioRef = userRef.collection('config').doc('audio');
    await audioRef.update({'volume': volume});
  }

  Future<void> statusLoadTutorialSave(bool loadTutorial) async {
    final statusTutorialRef = statusRef.doc('tutorial');
    await statusTutorialRef.update({'loadTutorial': loadTutorial});
  }

  Future<void> versionClientSave(ClientVersion clientVersion) async {
    final clientVCSRef = userRef.collection('vcs').doc('client');
    await clientVCSRef.update({'version': clientVersion.versionNumber});
  }
}
