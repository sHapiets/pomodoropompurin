import 'package:pomodoropompurin/scripts/foundation/client_version.dart';

class ClientVersionManager {
  ClientVersionManager._();
  static final singleton = ClientVersionManager._();

  final clientVersion = ClientVersion.blackWingedMyna;
  ClientVersion recordedClientVersion = ClientVersion.goldenRetriever;
  bool get wasOutdated =>
      clientVersion.recencyTag > recordedClientVersion.recencyTag;

  void initialize(ClientVersion databaseClientVersion) {
    recordedClientVersion = databaseClientVersion;
  }
}
