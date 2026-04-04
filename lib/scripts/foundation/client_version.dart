enum ClientVersion {
  goldenRetriever(recencyTag: 0, versionNumber: "1.0.0"),
  emperorPenguin(recencyTag: 1, versionNumber: "1.0.1"),
  greatWhiteShark(recencyTag: 2, versionNumber: "1.0.2");

  const ClientVersion({required this.recencyTag, required this.versionNumber});

  final int recencyTag;
  final String versionNumber;

  static ClientVersion fromVersionNumber(String versionNumber) {
    return ClientVersion.values.firstWhere(
      (clientVersion) => clientVersion.versionNumber == versionNumber,
    );
  }
}
