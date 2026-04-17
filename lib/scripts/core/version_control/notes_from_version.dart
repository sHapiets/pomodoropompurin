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
            "especially when switching between FOCUS and BREAK times.",
      ],
    },
  };

  Map<ClientVersion, Map<String, List<String>>> changes = {
    ClientVersion.emperorPenguin: {
      "UI Improvements": [
        "Improved PomTimer input UI: fixed overlapping dials and buttons",
        "Stylized Menus: Purin menus have a more unified appearance",
      ],
    },
    ClientVersion.greatWhiteShark: {
      "Menu Updates": ["ConsumablesMenu: matches unified appearance"],
      "Version Log Dialog": ["bulleted 'changes' and 'additions'"],
    },
  };

  Map<ClientVersion, Map<String, List<String>>> additions = {
    ClientVersion.emperorPenguin: {
      "Systems": [
        "VCS: client-based",
        "DevMode: switches current session to developer mode.",
      ],
    },
    ClientVersion.greatWhiteShark: {
      "Daily Achievements": [
        "beta - may be prone to bugs, so kindly report if such occurs",
        "random focus time and pet energy goals",
        "resets every 24hrs, but retains until the current session ends.",
      ],
      "Streak System": [
        "beta - linear rewards",
        "requirement time: 15 mins",
        "resets only after 48hrs of non-completion of the requirement time ",
      ],
    },
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
    ClientVersion.greatWhiteShark:
        "Heloo Yana!\n\n"
        "Sorry for the delayed update :(( \n\n"
        "I was focusing too much on several new features that I knew might not pass this week, and plenty of unecessary refactoring that the app won't need yet. "
        "A lot of time was wasted on some planned features that ended up getting scrapped anyways. "
        "So, I really feel bad "
        "because this week's update only has two new stuff that I could test and push to production. And both of them are still technically "
        "unfinished....\n\n"
        "I was sort of shocked on how much you were using it. I've never really visited your "
        "side of database, which I had since I was testing the new update. I'm both happy, but also frustrated; frustrated "
        "on myself for not keeping up with the development. Seeing how much you were using it made me feel that the app "
        "really deserves a better programmer.\n\n"
        "But still, I'm really happy that you're still using it. I'm really trying to create new stuff for the app, so "
        "I actually tried playing some random idle-progression games to get some ideas I could add. Most of them, I plan for 1.2.0, so it's "
        "gonna take a while for a lot of them. Until then, I hope the regular updates will continue to make the app "
        "much to your liking.",
  };
}
