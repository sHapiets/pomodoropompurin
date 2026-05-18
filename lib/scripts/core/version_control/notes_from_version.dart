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
    ClientVersion.blackWingedMyna: {
      "Achievements Rewards Dialog": ["Fixed: disabled confirmation button"],
      "Streak System": ["Fixed: progress overshooting bug"],
    },
    ClientVersion.siberianHusky: {
      "PurinVars": ["Fixed: Pol-Purin spritesheet corruption"],
    },
    ClientVersion.blueWhale: {
      "Scripts Map": [
        "Fixed: Lvl 13 - 15 Purin Scripts, kindly replay under the Words of Wisdom if missed!",
      ],
    },
    ClientVersion.violetCrownedHummingbird: {
      "Scripts Map": ["Fixed: Lvl 19 Purin Script duplication"],
      "Shoe Achievements": ["Fixed: Total time format display miscalc."],
      "Streak System": ["Fixed: New streak verification bug"],
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
    ClientVersion.blackWingedMyna: {
      "Snack Price": [
        "Deflation: Re-evaluation suggests slight imbalance. Price decrease ranged around 20~50%",
      ],
      "Icon Changes": [
        "Event System: Sligthly saturated shadow for more visibility.",
      ],
    },
    ClientVersion.blueWhale: {
      "Purchase Menu": [
        "Ingridient Types: arranged for better QOL",
        "Tiling: IMPORTANT - click the tiles to open the Purchase Panel to purchase an item.",
        "Non-purchasables: incl. locked items for inventory count",
      ],
    },
    ClientVersion.violetCrownedHummingbird: {
      "Streak System": [
        "2-day grace period: as originally intended, streak is only reset after missing 2 days instead of 1.",
      ],
      "Daily Achievement": [
        "Petting: temporarily disabled (until next update)",
      ],
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
        "resets after day of non-completion of the requirement time ",
      ],
    },
    ClientVersion.blackWingedMyna: {
      "Event Notification Dot": [
        "added for event systems",
        "simply creates a visual red dot on icons for claimable rewards",
      ],
    },
    ClientVersion.siberianHusky: {
      "3 Unlockable PurinVars": [
        "*******-Purin",
        "*****-Purin",
        "******-Purin",
      ],
      "1 Gifted PurinVars": ["Fragaria-Purin"],
      "4 Snacks": ["Ice Cream: Chcolate and C&C", "Pretzel: Cream and Caramel"],
    },
    ClientVersion.whiteTailedDeer: {
      "PomTimer: Record Async. Session": [
        "1: Input the focus time / loops of your unrecorded session, as you normally would in a PomTimer session",
        "2: Select the button on the bottom right (pen-like icon) to open the record confirmation window.",
        "3: Check the displayed focus time before confirming.",
      ],
      "5 Consumable Meals:": [
        "Omurice: a homey, Japanese-style omelette rice bowl",
        "Hamburger: the sandwich version....",
        "Lasagna: finally, REAL food!",
        "Pomodoro Pasta: coincidentally, a tomato-sauce pasta",
        "Béchamel Pasta: an Italian creamy spaghetti, it just sounds fancy",
      ],
      "6 'Ingridients'": [
        "Omelette",
        "Spaghetti",
        "Lasagna Sheets",
        "Tomato Sauce",
        "Creamy Sauce",
        "Lasagna Sauce",
      ],
      "Scripts Map": ["5 Level-up Dialogs: Lv: 16 - 20"],
    },
    ClientVersion.blueWhale: {
      "5 Unlockable PurinVars": [
        "********-Purin",
        "*****-Purin",
        "****-Purin",
        "******-Purin",
        "*******-Purin",
      ],
      "1 Gifted PurinVars": ["Mama-Purin"],
      "'Ingridient' Types": [
        "simple categorization of ingridients, slightly akin to actual groceries",
      ],
    },
    ClientVersion.violetCrownedHummingbird: {
      "Sanrio 2026 Voting": [
        "Voting: Daily popup to vote for Purin in this final week.",
      ],
      "Daily Achievement": [
        "Snacking: Completed by feeding a certain amount of snacks!",
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
    ClientVersion.blackWingedMyna:
        "Helloo Yana!\n\n"
        "These are just immediate patches from the previous update. It feels kind of weird "
        "having to release this in a seperate version, but I also intend to follow the development "
        "workflow quite strictly, just to make my life a bit less messy. \n\n"
        "As always, thank you and sorry if you had already encountered the bugs.",
    ClientVersion.siberianHusky:
        "Helloo Yana!\n\n"
        "This update marks the beginning of the Content Extension Pack.\n\n"
        "To give ample time towards developing 1.1.0, this month will only revolve around new content "
        "for existing features and functionalities. This extension pack consists of four weekly updates, "
        "mostly providing unlockables beyond the previous maximum level (Lv. 15). Kindly refer to the "
        "version notes every week to see what's new!\n\n"
        "Also, I just noticed that its been a month since the intial release (based on how many updates have "
        "gone). As a token of appreciation, I have gifted you a special Purin in your collection. The original "
        "design is from some game I saw online, but it was a too cool to pass on. Please consider it as a "
        "reward for your efforts from the previous weeks as well.\n\n"
        "As always, thank you for everything.\n\n",
    /* "PS: To give you a bit of a tease for 1.1.0, I'm adding more stuff that you could do with Purin. "
        "As I mentioned, the stuff like petting and feeding Purin was never "
        "part of the original idea. It only hit me later in development when I vaguely remembered that you were into some "
        "raising - digital - pet - thingies, which you reminded me were called Tamagotchis. Since these features "
        "were least planned, I felt that the system for Purin interactions were half-baked and needed an immediate revamp. "
        "Though I won't promise to meet the same level of experiences you may have with Tamagotchis, I will "
        "certainly mark its own identity as part of the app for you to enjoy.", */
    ClientVersion.whiteTailedDeer:
        "Helloo Yana!\n\n"
        "This release delivers the 2nd installment of the Content Extension Pack.\n\n"
        "In contrast to the previous update, this week focuses on new Consumable Meals, with additional 'Ingridients'. "
        "Although, these do not necessarily 'extend' the content to future levels (since most of these "
        "are already preparable), it is a partial set-up to the anticipated 1.1.0 update. "
        "Additionally, new Level-up Scripts were added on top of the previous level cap.\n\n"
        "As requested, the PomTimer is now allowing asynchronous records. Honestly, I don't think "
        "you would ever 'exploit' this feature; and it's simply because you have been reasonably eager yet patient "
        "throughout everything this app has to offer. That alone shows that you genuinely value "
        "your experience. On top of that, it also makes the development process sustainable and "
        "quite enjoyable, so I'm really glad that you do.\n\n"
        "(PS: Though I say this, I may have made the confirmation window.... a bit silly. "
        "I just found it kinda funny that you proposed some honesty-policy thing, sooooo I'm rolling with it. "
        "You're welcome in advance mwahahaha)",
    ClientVersion.blueWhale:
        "Helloo Yana!\n\n"
        "This release delivers the 3rd installment of the Content Extension Pack.\n\n"
        "In terms of content, only new unlockable Purins have been added. UI changes are also made for the Purchase "
        "Menu, so kindly refer to the notes below. Purin Scripts for Level 13-15 apparently bugged out, so "
        "you can now watch them under the Words of Wisdom had you missed them.\n\n"
        "To celebrate MOTHER'S DAY, Mama-Purin has been invited to the Purin's home! (Check your Purin collection...) \n\n"
        "Kindly send my greetings to your mom as well! Wishing Tita good health, and all the love she deserves! "
        "Hope she continues being the endearing and lovable person that she is! <3",
    ClientVersion.violetCrownedHummingbird:
        "Helloo Yana!\n\n"
        "This week focuses only on Event-Systems.\n\n"
        "Unfortunately, the 4th installment of Content Extension Pack will be moved next week; "
        "which also means that the release of 1.1.0, supposedly for next week, is also moved :(( .\n\n"
        "The 1.1.X Purin-Systems Update really needs a bit more time to develop. So far, the balance between "
        "weekly updates, the major 1.1.0 update, and personal stuff, have worked well until recently. "
        "Due to their shifts in work volume, time allocation changes were inevitable. So, I sincerely hope you understand. \n\n"
        "As always, thank you for everything so far!\n\n"
        "(PS: As I was testing this update earlier, I happened to notice the lost 7-day streak. Your recorded session "
        "suggested, however, that the latest activity was most probably intended for the previous day. "
        "Unfortunately, there's nothing I can do..... *wink *wink ) \n\n"
        "(Kindly check your streak progress once more!)",
  };
}
