import 'package:pomodoropompurin/scripts/foundation/client_version.dart';

class ClientVersionManager {
  ClientVersionManager._();
  static final singleton = ClientVersionManager._();

  final clientVersion = ClientVersion.emperorPenguin;
  ClientVersion recordedClientVersion = ClientVersion.goldenRetriever;
  bool get wasOutdated =>
      clientVersion.versionNumber != recordedClientVersion.versionNumber;

  void initialize(ClientVersion databaseClientVersion) {
    recordedClientVersion = databaseClientVersion;
  }
}
