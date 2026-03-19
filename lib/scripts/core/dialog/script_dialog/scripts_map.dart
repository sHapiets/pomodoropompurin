import 'package:flame/game.dart';
import 'package:pomodoropompurin/scripts/core/audio/background_music.dart';
import 'package:pomodoropompurin/scripts/core/dialog/script_dialog/script_dialog.dart';
import 'package:pomodoropompurin/scripts/core/dialog/script_dialog/script_manager.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/shoe_achievement/shoe_achievement.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/tutorial/tutorial_manager.dart';
import 'package:pomodoropompurin/scripts/memory/asset_manager.dart';

class ScriptsMap {
  static Map<int, ScriptDialog> fromLevelUp = {
    3: ScriptDialog(
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['thinking_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['thinking_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
      ],
      dialogues: [
        {"Purin": "Hmm...."},
        {
          "Purin":
              "I think that snacks are the solution to ALL problems in the world.",
        },
        {"Purin": "Problems like..."},
        {"Purin": "...."},
        {"Purin": "...hunger?"},
        {"Purin": "And maybe.... uhmmm...."},
        {"Purin": "I guess snacks don't really solve much after all..."},
        {"Purin": "But then again, getting hungry is the ONLY problem I have."},
        {"Purin": "..."},
        {"Purin": "....."},
        {"Purin": "Talking about being hungry makes me hungry even more!"},
      ],
      onFinished: () {
        ScriptManager.singleton.removeLevelUpDialog();
      },
    ),

    4: ScriptDialog(
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['thinking_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
      ],
      dialogues: [
        {"Purin": "I heard the fridge humming again."},
        {
          "Purin":
              "Even though it's a bit loud, it does have a soothing feel to it.",
        },
        {"Purin": "It's almost like it's calling for my attention..."},
        {"Purin": "I wonder if it ever gets tired though."},
        {"Purin": "Maybe eating a lot more of its food helps it rest?"},
        {"Purin": "..."},
        {"Purin": "......"},
        {"Purin": "HELP IS ON THE WAY!!!"},
      ],
      onFinished: () {
        ScriptManager.singleton.removeLevelUpDialog();
      },
    ),

    5: ScriptDialog(
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['thinking_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['thinking_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['down_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
      ],
      dialogues: [
        {"Purin": "Do shoes ever feel lonely?"},
        {"Purin": "Like, maybe if one of them loses their pair-mate?"},
        {"Purin": "Hmm...."},
        {
          "Purin":
              "They probably do, the same way for me whenever mama-owner or Muffin isn't around...",
        },
        {"Purin": "...."},
        {"Purin": "ALRIGHTY! From now on, ..."},
        {
          "Purin":
              "...whenever I hide mama-owner's shoes, I'll never leave either of them by themselves.",
        },
        {
          "Purin":
              "Orrrr... at least I keep one of them company while we find for the other one!",
        },
      ],
      onBegin: () {
        Purin.singleton.changePosition(PurinPosition.futon);
        PurinAreaStateManager.singleton.jumpToPosition(
          Purin.singleton.purinPositionVect2,
          Vector2.zero(),
          2.2,
        );
      },
      onFinished: () {
        ScriptManager.singleton.removeLevelUpDialog();
      },
    ),

    6: ScriptDialog(
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['thinking_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
      ],
      dialogues: [
        {
          "Purin":
              "One day, I'll become extreeeeemely BIG! Just like my Mama and Papa.",
        },
        {"Purin": "That's why eating will forever be my favorite sport!"},
        {"Purin": "Though I wonder if it's my favorite one of all-time..."},
        {"Purin": "Sleeping might be a strong contender..."},
        {"Purin": "But I can't eat while sleeping, can I?"},
        {"Purin": "Hmm..."},
        {"Purin": "Well, I do become bigger in my dreams sometimes..."},
        {"Purin": "...but I get disappointed waking up."},
        {"Purin": "Hmm..."},
        {"Purin": "Let's make it a draw for now!"},
      ],
      onFinished: () {
        ScriptManager.singleton.removeLevelUpDialog();
      },
    ),

    7: ScriptDialog(
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['thinking_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
      ],
      dialogues: [
        {
          "Purin":
              'They say that, "Life is about the journey, not the destination."',
        },
        {
          "Purin":
              "But whenever I travel from the couch to the fridge, I'd always think about the fridge the entire time anyways.",
        },
        {
          "Purin":
              "I would wonder what snacks await me, surging towards my quest for nom~noms.",
        },
        {"Purin": "Though I sure hoped the journey was always worth it."},
        {
          "Purin":
              "Because it was the journey that made me look forward on what I had set myself to achieve...",
        },
        {"Purin": "...which is why I end up taking TWO snacks instead!"},
      ],
      onFinished: () {
        ScriptManager.singleton.removeLevelUpDialog();
      },
    ),

    8: ScriptDialog(
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['down_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['down_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['down_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['please_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['please_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['down_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['please_purin_icon']!,
      ],
      dialogues: [
        {"Purin": "..."},
        {"Purin": "I'm a bit sad right now..."},
        {
          "Purin":
              "Just a while ago, I was saving this perfect slice of porkchop.",
        },
        {
          "Purin":
              "I hid it somewhere in the fridge, but now, I couldn't find it...",
        },
        {
          "Purin":
              "I'm thinking that maybe I should have eaten it while I had the chance",
        },
        {"Purin": "Or maybe it was just never meant to fill me up..."},
        {"Purin": "...."},
        {"Purin": "Thinking about this porkchop makes me just as hungry!"},
        {"Purin": "A pizza right now would be nice ~pom-u~."},
      ],
      onFinished: () {
        ScriptManager.singleton.removeLevelUpDialog();
      },
    ),

    9: ScriptDialog(
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
      ],
      dialogues: [
        {"Purin": "I wonder if clouds get tired from traveling."},
        {
          "Purin":
              "I enjoy going out from time to time, but staying and relaxing at home is just unbeatable.",
        },
        {
          "Purin":
              "And it just becomes extremely cozy especially when it rains...",
        },
        {"Purin": "..."},
        {"Purin": "If clouds travel so much..."},
        {"Purin": "...is rain... just clouds taking a bath?...."},
        {"Purin": "...or their sweat dropping from the sky?"},
        {"Purin": "..."},
        {"Purin": "I hope mama-owner gets us raincoats soon."},
      ],
      onFinished: () {
        ScriptManager.singleton.removeLevelUpDialog();
      },
    ),

    10: ScriptDialog(
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['thinking_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
      ],
      dialogues: [
        {"Purin": "I like going to bed early."},
        {
          "Purin":
              "Though it's kinda because there's not much for me to do anyways.",
        },
        {
          "Purin":
              "Maybe if I get a job someday, I would get to do lots of things during the day.",
        },
        {
          "Purin":
              "It would be... such a good use.... of my several talents.....",
        },
        {"Purin": "....but until then....."},
        {"Purin": "..........Zz....."},
        {"Purin": "...ZzZzzZzzZ....ZzzzZ...."},
      ],
      onBegin: () {
        Purin.singleton.changePosition(PurinPosition.futon);
        PurinAreaStateManager.singleton.jumpToPosition(
          Purin.singleton.purinPositionVect2,
          Vector2.zero(),
          2.2,
        );
      },
      onFinished: () {
        ScriptManager.singleton.removeLevelUpDialog();
      },
    ),

    11: ScriptDialog(
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
      ],
      dialogues: [
        {"Purin": "There's been a rumor that cheese is just processed milk."},
        {
          "Purin":
              "But I've never really thought about where cheese comes from before the milk bit.",
        },
        {
          "Purin":
              "Then I realized that if cheese needs milk, then you would also need cows.",
        },
        {"Purin": "Aliens don't have cows, don't they?"},
        {
          "Purin":
              "Imagine going through life without having eaten at least a slice of pizza.",
        },
        {
          "Purin":
              "If I become president one day, and aliens happen to be invading us....",
        },
        {
          "Purin":
              "I would gladly serve them the cheesiest pizza the world has ever seen!",
        },
        {
          "Purin":
              "Then, we would celebrate Pizza Day as a remembrance of our peace treaty!",
        },
        {"Purin": "..."},
        {"Purin": "I think... I'm getting ahead of myself."},
        {"Purin": "I mean, it's kinda unlikely after all...."},
        {"Purin": "..that cheese is made of processed milk."},
      ],
      onFinished: () {
        ScriptManager.singleton.removeLevelUpDialog();
      },
    ),

    12: ScriptDialog(
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
      ],
      dialogues: [
        {"Purin": "I don't really get how trees work."},
        {"Purin": "You just give them water, and they get really, REALLY BIG."},
        {
          "Purin":
              "I've been eating all my life, and yet I don't grow as myuch...",
        },
        {"Purin": "Maybe drinking water is the trick?"},
        {
          "Purin":
              "But I just lose my appetite real quick, and end up not eating much anyways.",
        },
        {"Purin": "Hmmm...."},
        {"Purin": "Well now, I kinda feel lucky not being a tree then."},
        {
          "Purin":
              "Anyone would rather be smol than only drink water for the rest of their lives.",
        },
        {"Purin": "Though it WOULD have been nice to have both!"},
      ],
      onFinished: () {
        ScriptManager.singleton.removeLevelUpDialog();
      },
    ),
  };

  static Map<ShoeAchievement, ScriptDialog> fromShoeAchievement = {
    ShoeAchievement.slippers: ScriptDialog(
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
      ],
      dialogues: [
        {"Purin": "I love mama-owner a lot!"},
        {
          "Purin":
              "She does study a lot these days, and I'm super proud of her!",
        },
        {"Purin": "Though I'd like to get her attention from time to time..."},
        {"Purin": "Sooooo...."},
        {"Purin": "I may or may not have taken in some of her shoes."},
      ],
    ),
  };

  static Map<int, ScriptDialog> fromTutorialSections = {
    1: ScriptDialog(
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
      ],
      dialogues: [
        {"....": "...zZzzZZzz...."},
        {"....": "..zZzz.... What..do you mean ..zZ.."},
        {"....": "....all the snacks... Zzzz.. are gone?..."},
        {"....": "..zZz.... there's... no need.. ZzZ.. to panic..."},
        {"....": "...I'll rescue them... ZzZ.. no matter the odds..."},
        {"....": "... I swear... ZzzZz... on my bu--"},
      ],
      onFinished: () {
        Purin.singleton.changePosition(PurinPosition.futon);
        PurinAreaStateManager.singleton.jumpToPosition(
          Purin.singleton.purinPositionVect2,
          Vector2.zero(),
          2.2,
        );
        TutorialManager.singleton.nextTutorialSection();
      },
    ),

    2: ScriptDialog(
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
      ],
      dialogues: [
        {"!!!": "**whirring noises**"},
        {"....": "... huh? What's that sound? "},
        {"!!!": "**whirring noises continues...**"},
        {"....": "Could it be my snacks crying for help!?"},
        {"!!!": "**whirring noises continues...**"},
        {"....": "No, it sounds a bit too familiar...."},
        {"....": "It kinda sounds like...."},
      ],
      onFinished: () {
        TutorialManager.singleton.nextTutorialSection();
      },
    ),

    3: ScriptDialog(
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
      ],
      dialogues: [
        {"....": "....that it might just be the mixer."},
        {"Mixer": "**whirring noises continues...**"},
        {"....": "**deep sigh of relief**"},
        {
          "Purin":
              "So about the snacks getting lost. It was all just a dream...",
        },
        {
          "Purin":
              "Thank goodness.... for a second, I really thought they're in danger.",
        },
        {"Purin": "No one harms Purin's snacks!"},
        {"Purin": "...."},
        {"Purin": "Or at least, no one eats them without me!"},
        {"Mixer": "**whirring noises continues...**"},
        {"Purin": "Wait a second..."},
        {"Purin": "...if the mixer is making noises, that could only mean..."},
        {"Purin": "MAMA-OWNER'S HOME!"},
      ],
      onBegin: () {
        BackgroundMusic().play('audio/track_playful.mp3');
      },
      onFinished: () {
        TutorialManager.singleton.nextTutorialSection(delayMs: 1000);
      },
    ),

    4: ScriptDialog(
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
      ],
      dialogues: [
        {"....": "Let me explain..."},
        {"....": "...in this alternate dimension..."},
        {"....": "...you are..."},
        {"....": "...~dun ~dun ~dun ~dun ~dunnnn~..."},
        {"....": "...Purin's MAMA-OWNER!"},
        {"....": "Oh, I forgot to introduce myself..."},
        {"....": "Hi there! Im Koupen-chan!"},
        {
          "Koupen":
              "My hobby is colleting four-leaf clovers, smelling flowers, and playing with my friends!",
        },
        {
          "Koupen":
              "Speaking of friends, yesterday, I met up with my friend, Yokoshima Enaga-san...",
        },
        {
          "Koupen":
              "He was talking about 'taking over the world' or something...",
        },
        {"Koupen": ".... and that's...."},
        {"Koupen": "... ACTUALLY SO COOL!"},
        {
          "Koupen":
              "I don't really know what that means, but he really seems into it, so I'm really happy for him.",
        },
        {
          "Koupen":
              "A lot of people think he's evil for that, but Koupen doesn't think so.",
        },
        {
          "Koupen":
              "Just the other day, I was waddling around with Ballon-san...",
        },
        {
          "Koupen":
              "...while Enaga-san was telling me something about 'eliminating' it or whatever.",
        },
        {
          "Koupen":
              "But suddenly, my hand slipped, and Ballon-san started flying!",
        },
        {
          "Koupen":
              "Thankfully, unlike Koupen, Enaga-san could fly, and brought Ballon-san back to me!",
        },
        {"Koupen": "Which is why I think---"},
        {"Koupen": "....."},
        {"Koupen": "Uhm, I feel like I lost track of something important..."},
        {"Koupen": "OH, I completely forgot."},
        {
          "Koupen":
              "That's right! Today, I will waddle you through the different things you could do as Mama-owner.",
        },
        {"Koupen": "And yes. In this dimension..."},
        {
          "Koupen":
              "...you get to take care of the most pudding-shaped creature in the universe, Purin-chan!",
        },
        {
          "Koupen":
              "You can prepare him MEALS, and PET him anytime to show your affection.",
        },
        {"Koupen": "To start, how about we make some pancakes"},
      ],

      onFinished: () {
        TutorialManager.singleton.nextTutorialSection();
      },
    ),

    10: ScriptDialog(
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
      ],
      dialogues: [
        {"Koupen": "..."},
        {"Koupen": "In this alternate dimension..."},
        {"Koupen": "...TIME is your best friend!"},
        {"Koupen": "Take it from me. I play with TIME everyday, too."},
        {
          "Koupen":
              "I spend a lot of my time with my friends, my family, and myself.",
        },
        {"Koupen": "I always get to do a lot of exciting things!"},
        {"Koupen": "Like smelling the fragrant flowers during spring..."},
        {"Koupen": "...sometimes playing games with my fellow penguins..."},
        {"Koupen": "...or maybe going for a walk to sniff on some flowers..."},
        {"Koupen": "...helping Adelie-san in the farm is also fun..."},
        {
          "Koupen":
              "...I also get in the mood to gather flowers to smell them...",
        },
        {"Koupen": "...hmmm..."},
        {"Koupen": "...did I mention smelling flowers?"},
        {"Koupen": "Anyways, TIME is always a joy to have."},
        {
          "Koupen":
              "But TIME is not only our best friend during the fun times...",
        },
        {"Koupen": "...but also our best friend to achieve our goals."},
      ],
    ),
  };
}
