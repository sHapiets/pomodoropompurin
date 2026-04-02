import 'package:pomodoropompurin/scripts/foundation/client_version.dart';

class NotesFromVersion {
  static final Map<ClientVersion, Map<String, List<String>>> patches = {
    ClientVersion.emperorPenguin: {
      "PomTimer now uses official time deltas.": [
        "Important: This only bypasses the issue "
            "of timer disposal, allowing it to simulate a synchronous tick while "
            "running in the background.",
        "Note: Unfortunately, timer state updates still rely on the program being active, so it is still "
            "necessary for the program to be viewed once in a while, "
            "especially when switching between FOCUS and BREAK times. ",
        "",
      ],
    },
  };

  Map<ClientVersion, List<String>> changes = {
    ClientVersion.emperorPenguin: [
      "Improved PomTimer input UI: fixed overlapping dials and buttons",
      "Stylized Menus: Purin menus have a more unified appearance",
    ],
  };

  Map<ClientVersion, List<String>> additions = {
    ClientVersion.emperorPenguin: [
      "VCS: client-based, ",
      "DevMode: switches current session to developer mode.",
    ],
  };

  Map<ClientVersion, String> foreword = {
    ClientVersion.emperorPenguin:
        "Heloo Yana!\n\n"
        "Took me a while to get a bit of patches going. No new content for now though; "
        "primarily focused on UX and UI changes. It's more of the 'day-one patch', "
        "which is kinda off given that its already been a week. \n\n"
        "I also needed my own space to work on, so I built a DevMode to the system. It simply allows me "
        "to test new features and content, basically like an uglier sandbox version that I can mess around with. \n\n"
        "Anyhow, thank you for using this app! Always let me know if there are stuff "
        "you want changed or fix.",
  };
}
