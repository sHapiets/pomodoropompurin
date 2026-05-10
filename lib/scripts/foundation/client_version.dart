enum ClientVersion {
  goldenRetriever(recencyTag: 0, versionNumber: "1.0.0"),
  emperorPenguin(recencyTag: 1, versionNumber: "1.0.1"),
  greatWhiteShark(recencyTag: 2, versionNumber: "1.0.2"),
  blackWingedMyna(recencyTag: 3, versionNumber: "1.0.3"),
  siberianHusky(recencyTag: 4, versionNumber: "1.0.4"),
  whiteTailedDeer(recencyTag: 5, versionNumber: "1.0.5"),
  blueWhale(recencyTag: 6, versionNumber: "1.0.6"),
  violetCrownedHummingbird(recencyTag: 7, versionNumber: "1.0.7");

  const ClientVersion({required this.recencyTag, required this.versionNumber});

  final int recencyTag;
  final String versionNumber;

  static ClientVersion fromVersionNumber(String versionNumber) {
    return ClientVersion.values.firstWhere(
      (clientVersion) => clientVersion.versionNumber == versionNumber,
    );
  }
}
