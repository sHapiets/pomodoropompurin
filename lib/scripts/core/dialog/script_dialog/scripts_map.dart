import 'dart:async';

import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'package:pomodoropompurin/scripts/core/audio/background_music.dart';
import 'package:pomodoropompurin/scripts/core/dialog/script_dialog/script_dialog.dart';
import 'package:pomodoropompurin/scripts/core/dialog/script_dialog/script_manager.dart';
import 'package:pomodoropompurin/scripts/core/pom_timer/pom_timer_display_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/prog_system.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/shoe_achievement/shoe_achievement.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_equip_manager.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/tutorial/tutorial_manager.dart';
import 'package:pomodoropompurin/scripts/core/ui/ui_display_state.dart';
import 'package:pomodoropompurin/scripts/foundation/consumable.dart';
import 'package:pomodoropompurin/scripts/foundation/ingridient.dart';
import 'package:pomodoropompurin/scripts/memory/asset_manager.dart';
import 'package:pomodoropompurin/scripts/page/main_page.dart';

class ScriptsMap {
  static Map<int, ScriptDialog> fromLevelUp = {
    3: ScriptDialog(
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['thinking_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['thinking_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['thinking_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['pumped_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['pumped_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['excited_purin_icon']!,
      ],
      dialogues: [
        {"Purin": "Hmm...."},
        {
          "Purin":
              "Don't you think that snacks are the solution to EVERY problem in the world?",
        },
        {"Purin": "Problems like..."},
        {"Purin": "...."},
        {"Purin": "...hunger?"},
        {"Purin": "And maybe.... uhmmm....let's see...."},
        {
          "Purin":
              "Hmmm... I guess snacks don't really solve much after all...",
        },
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
        AssetManager.singleton.flutterAssetPaths['excited_purin_icon']!,
      ],
      dialogues: [
        {"Purin": "I heard the fridge humming again."},
        {
          "Purin":
              "Even though it's a bit loud, it does have a soothing feel to it.",
        },
        {"Purin": "It's almost like it's calling for my attention..."},
        {"Purin": "I wonder if it ever gets tired though."},
        {"Purin": "Maybe eating a lot of its food helps it rest?"},
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
        AssetManager.singleton.flutterAssetPaths['pumped_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
      ],
      dialogues: [
        {"Purin": "Do shoes ever feel lonely?"},
        {"Purin": "Like, maybe if one of them loses their pair-mate?"},
        {"Purin": "Hmm...."},
        {
          "Purin":
              "They probably do, the same way for me whenever Mama-owner or Muffin isn't around...",
        },
        {"Purin": "...."},
        {"Purin": "ALRIGHTY! From now on, ..."},
        {
          "Purin":
              "...whenever I hide Mama-owner's shoes, I'll never leave either of them by themselves.",
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
        AssetManager.singleton.flutterAssetPaths['excited_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['pumped_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['thinking_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['down_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['pumped_purin_icon']!,
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
        AssetManager.singleton.flutterAssetPaths['calm_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['thinking_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['excited_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['calm_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['pumped_purin_icon']!,
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
        AssetManager.singleton.flutterAssetPaths['calm_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['please_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['please_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['down_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['excited_purin_icon']!,
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
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['pumped_purin_icon']!,
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
        AssetManager.singleton.flutterAssetPaths['pumped_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['calm_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['calm_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['calm_purin_icon']!,
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
        AssetManager.singleton.flutterAssetPaths['calm_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['thinking_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['thinking_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['down_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['pumped_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['eating_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['excited_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['excited_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['pumped_purin_icon']!,
      ],
      dialogues: [
        {"Purin": "There's been a rumor that cheese is just processed milk."},
        {
          "Purin":
              "I've never really thought about it, only that pizza wouldn't be as yummy if it weren't for cheese.",
        },
        {
          "Purin":
              "Then I realized that if cheese needs milk, then you would also need cows.",
        },
        {"Purin": "But aliens don't have cows, don't they?"},
        {
          "Purin":
              "Imagine going through life without having eaten at least a slice of pizza....",
        },
        {
          "Purin":
              "If I become president one day, and aliens plan to invade us....",
        },
        {
          "Purin":
              "I would gladly respond..... with a full-serving of the CHEESIEST pizza the world has ever seen!",
        },
        {
          "Purin":
              "Then, we would celebrate Pizza Day every year as a memorial of our peace treaty!",
        },
        {
          "Purin":
              "So that Purin is honored as a hero, and gets a lifetime supply of pizza!",
        },
        {"Purin": "..."},
        {"Purin": "I think... I'm getting ahead of myself."},
        {"Purin": "I mean, it's kinda unlikely after all...."},
        {"Purin": "...that cheese is made of processed milk."},
      ],
      onFinished: () {
        ScriptManager.singleton.removeLevelUpDialog();
      },
    ),

    12: ScriptDialog(
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['calm_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['down_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['thinking_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['down_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['calm_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['pumped_purin_icon']!,
      ],
      dialogues: [
        {"Purin": "I don't really get how trees work."},
        {"Purin": "You just give them water, and they get really, REALLY BIG."},
        {
          "Purin":
              "I've been eating all my life, and yet I don't grow as much...",
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
        {"Purin": "....."},
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
        AssetManager.singleton.flutterAssetPaths['shadow_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['shadow_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['shadow_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['shadow_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['shadow_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['shadow_purin_icon']!,
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
        AssetManager.singleton.flutterAssetPaths['mixer_shadow_objects_icon']!,
        AssetManager.singleton.flutterAssetPaths['shadow_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['mixer_shadow_objects_icon']!,
        AssetManager.singleton.flutterAssetPaths['shadow_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['mixer_shadow_objects_icon']!,
        AssetManager.singleton.flutterAssetPaths['shadow_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['shadow_purin_icon']!,
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
      onBegin: () {
        BackgroundMusic().play('assets/audio/track_playful.mp3');
      },
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['mixer_objects_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['please_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['pumped_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['pumped_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['mixer_objects_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['thinking_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['excited_purin_icon']!,
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
      onFinished: () {
        TutorialManager.singleton.nextTutorialSection(delayMs: 1000);
      },
    ),

    4: ScriptDialog(
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['shadow_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['shadow_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['shadow_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['shadow_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['dazzle_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['shocked_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['thinking_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['thinking_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['dazzle_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['dazzle_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['troubled_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['thinking_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['shocked_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['dazzle_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['shocked_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['dazzle_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['thinking_koupen_icon']!,
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
              "My hobby is collecting four-leaf clovers, smelling flowers, and playing with my friends!",
        },
        {
          "Koupen":
              "Speaking of friends, yesterday, I met up with Yokoshima Enaga-san...",
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
              "A lot of people think he's an evil bird, but Koupen doesn't think so.",
        },
        {
          "Koupen":
              "Just the other day, I was waddling around with Balloon-san...",
        },
        {
          "Koupen":
              "...while Enaga-san was telling me something about 'eliminating' it or whatever.",
        },
        {
          "Koupen":
              "But suddenly, my hand slipped, and Balloon-san started flying!",
        },
        {
          "Koupen":
              "Thankfully, unlike Koupen, Enaga-san could fly, and brought Balloon-san back to me!",
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
        {"Koupen": "To start, how about we take a quick tour..."},
      ],
      onFinished: () {
        TutorialManager.singleton.nextTutorialSection(delayMs: 500);
      },
    ),

    5: ScriptDialog(
      onBegin: () {
        PurinAreaStateManager.singleton.jumpToPosition(
          Vector2.zero(),
          Vector2.zero(),
          0.4,
        );
      },
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['dazzle_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['shocked_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_koupen_icon']!,
      ],
      dialogues: [
        {"Koupen": "Welcome to Purin's lovely home!"},
        {"Koupen": "...."},
        {
          "Koupen":
              "... what do you mean dog houses in your dimension aren't this fancy?",
        },
        {"Koupen": "Isn't it common to have...."},
      ],
      onFinished: () {
        TutorialManager.singleton.nextTutorialSection(delayMs: 100);
      },
    ),
    /*
    6: ScriptDialog(
      onBegin: () {
        PurinAreaStateManager.singleton.jumpToPosition(
          Vector2(190, 30),
          Vector2.zero(),
          1.0,
        );
      },
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['happy_koupen_icon']!,
      ],
      dialogues: [
        {"Koupen": "....a fully-functioning KITCHEN,..."},
      ],
      onFinished: () {
        TutorialManager.singleton.nextTutorialSection(delayMs: 100);
      },
    ),

    7: ScriptDialog(
      onBegin: () {
        PurinAreaStateManager.singleton.jumpToPosition(
          Vector2(180, 190),
          Vector2.zero(),
          1.0,
        );
      },
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['dazzle_koupen_icon']!,
      ],
      dialogues: [
        {"Koupen": "....a KOTATSU to eat and relax..."},
      ],
      onFinished: () {
        TutorialManager.singleton.nextTutorialSection(delayMs: 100);
      },
    ),

    8: ScriptDialog(
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['thinking_koupen_icon']!,
      ],
      dialogues: [
        {"Koupen": "....a room with a cozy FUTON to sleep on..."},
      ],
      onFinished: () {
        TutorialManager.singleton.nextTutorialSection(delayMs: 100);
      },
    ),

    9: ScriptDialog(
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['curious_koupen_icon']!,
      ],
      dialogues: [
        {"Koupen": "....and a STUDY AREA to focus on your work?..."},
      ],
      onFinished: () {
        TutorialManager.singleton.nextTutorialSection(delayMs: 100);
      },
    ),
*/
    10: ScriptDialog(
      onBegin: () {
        PurinAreaStateManager.singleton.jumpToPosition(
          Vector2.zero(),
          Vector2.zero(),
          0.4,
        );
      },
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['thinking_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['dazzle_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['thinking_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_koupen_icon']!,
      ],
      dialogues: [
        {"Koupen": "Hmmm....."},
        {
          "Koupen":
              "Well, at least in this dimension, you have now options to spend your time with Purin!",
        },
        {
          "Koupen":
              "Speaking of TIME, there's also one thing you need to know about this dimension...",
        },
        {
          "Koupen":
              "In order to purchase stuff, you have to acquire PomPoints!",
        },
        {
          "Koupen":
              "PomPoints are really simple to get, and that's by using the---",
        },
      ],
      onFinished: () {
        TutorialManager.singleton.nextTutorialSection(delayMs: 100);
      },
    ),

    11: ScriptDialog(
      onBegin: () {
        Purin.singleton.changePosition(PurinPosition.futon);
        PurinAreaStateManager.singleton.jumpToPosition(
          Purin.singleton.purinPositionVect2,
          Vector2.zero(),
          2.2,
        );
      },
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['calm_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['eating_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['calm_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['troubled_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_koupen_icon']!,
      ],
      dialogues: [
        {"Purin": "**stomach growls**"},
        {"Purin": "~ aaHh ~.. pancakesss ~...."},
        {"Purin": "...aHh ~ zzZZzz.... ZzzZ..."},
        {
          "Koupen":
              "It seems Purin-chan might be a bit too excited to eat now...",
        },
        {
          "Koupen":
              "Let's talk about the rest later. For now, let's try getting familiar on some stuff first...",
        },
      ],
      onFinished: () {
        TutorialManager.singleton.nextTutorialSection(delayMs: 100);
      },
    ),

    12: ScriptDialog(
      onBegin: () {
        PurinAreaStateManager.singleton.jumpToPosition(
          Vector2.zero(),
          Vector2.zero(),
          0.4,
        );
      },
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
        {
          "Koupen":
              "To MOVE around the room, simply TAP DOWN ONCE THEN PAN across the screen.",
        },
        {
          "Koupen":
              "To see more stuff around, you could ZOOM OUT by TAPPING DOWN TWICE THEN SLIDE DOWNWARDS",
        },
        {
          "Koupen":
              "To see Purin's rounded-mushy-fur up close, you can ZOOM IN is by TAPPING DOWN TWICE THEN SLIDE UPWARDS",
        },
        {"Koupen": "Let's try these out!"},
        {
          "Koupen":
              "Once you start feeling comfy moving around, simply LONG PRESS on the MIXER to use it...",
        },
        {"Koupen": "And start making these pancakes!"},
        {"Koupen": ".... at least before Purin-chan eats them in his dream..."},
      ],
      onFinished: () {
        ScriptManager.singleton.removeTutorialScript();
        UIDisplayState.singleton.hide.value = false;
        Timer.periodic(Duration(milliseconds: 200), (timer) {
          if (purinAreaKey.currentState!.currentGame.overlays.activeOverlays
              .contains("mixerMenu")) {
            TutorialManager.singleton.nextTutorialSection();
            timer.cancel();
          }
        });
      },
    ),

    13: ScriptDialog(
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
      ],
      dialogues: [
        {
          "Koupen":
              "Using the mixer, you can make PANCAKE BATTER using the INGREDIENTS in the recipe tile.",
        },
        {
          "Koupen":
              "Try making one PANCAKE BATTER by HOLDING DOWN on the process button.",
        },
      ],
      onFinished: () {
        ScriptManager.singleton.removeTutorialScript();
        final initPancakeBatterCount = ProgSystem
            .singleton
            .ingridientInventory[Ingridient.pancakeBatter]!
            .value;
        Timer.periodic(Duration(milliseconds: 200), (timer) {
          final pancakeBatterCount = ProgSystem
              .singleton
              .ingridientInventory[Ingridient.pancakeBatter]!
              .value;
          if (pancakeBatterCount > initPancakeBatterCount) {
            TutorialManager.singleton.nextTutorialSection();
            timer.cancel();
          }
        });
      },
    ),

    14: ScriptDialog(
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
      ],
      dialogues: [
        {
          "Koupen":
              "Good job! Now, we just need to cook the batter to get our fluffy pancakes!",
        },
        {"Koupen": "Select the stove to start cooking!"},
      ],
      onFinished: () {
        ScriptManager.singleton.removeTutorialScript();
        final initPancakesCount =
            ProgSystem.singleton.consumableInventory[Consumable.pancake]!.value;
        Timer.periodic(Duration(milliseconds: 200), (timer) {
          final pancakesCount = ProgSystem
              .singleton
              .consumableInventory[Consumable.pancake]!
              .value;
          if (pancakesCount > initPancakesCount) {
            TutorialManager.singleton.nextTutorialSection();
            timer.cancel();
          }
        });
      },
    ),

    15: ScriptDialog(
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
      ],
      dialogues: [
        {"Koupen": "Well done!"},
        {
          "Koupen":
              "Now, we just need to place these pancakes in the dining area...",
        },
        {"Koupen": "Do a LONG PRESS on the KOTATSU to set your pancakes"},
      ],
      onFinished: () {
        ScriptManager.singleton.removeTutorialScript();
        Timer.periodic(Duration(milliseconds: 200), (timer) {
          final currentFeedable =
              PurinAreaEquipManager.singleton.feedable.value;
          final currentBitesLeft =
              PurinAreaEquipManager.singleton.feedableBitesLeft.value;
          if (currentFeedable == Consumable.pancake &&
              currentBitesLeft == Consumable.pancake.totalBites) {
            TutorialManager.singleton.nextTutorialSection();
            timer.cancel();
          }
        });
      },
    ),

    16: ScriptDialog(
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_purin_icon']!,
      ],
      dialogues: [
        {"Purin": "YAYY!! ~ ~ PANCAKES!!"},
        {
          "Koupen":
              "To feed Purin, simply TAP on the pancakes, followed by a TAP on Purin-chan!",
        },
        {"Koupen": "And make sure he gets his fill!"},
      ],
      onFinished: () {
        ScriptManager.singleton.removeTutorialScript();
        Timer.periodic(Duration(milliseconds: 200), (timer) {
          final bitesLeft =
              PurinAreaEquipManager.singleton.feedableBitesLeft.value;
          if (bitesLeft == 0) {
            TutorialManager.singleton.nextTutorialSection();
            timer.cancel();
          }
        });
      },
    ),

    17: ScriptDialog(
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['dazzle_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['eating_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['calm_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['troubled_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_koupen_icon']!,
      ],
      dialogues: [
        {
          "Koupen":
              "Way to go! Now, Purin-chan has enough energy to get through the day!",
        },
        {"Purin": "....~ that was delicious ~..."},
        {"Purin": "... I wonder if I could eat that again...."},
        {"Purin": "... if I go back to sleep....ZzzZZz...."},
        {"Koupen": "....."},
        {"Koupen": ".... I might take that back."},
        {"Koupen": "Well, Purin-chan is Purin-chan after all!"},
      ],
      onFinished: () {
        TutorialManager.singleton.nextTutorialSection(delayMs: 100);
      },
    ),

    18: ScriptDialog(
      onBegin: () {
        PurinAreaStateManager.singleton.jumpToPosition(
          Vector2.zero(),
          Vector2.zero(),
          0.4,
        );
      },
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['dazzle_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['thinking_koupen_icon']!,
      ],
      dialogues: [
        {"Koupen": "Now, let's talk about the other stuff you can do here!"},
        {
          "Koupen":
              "How about we start with the stuff that appears in the sides?",
        },
        {"Koupen": "I'm talking about...."},
      ],
      onFinished: () {
        TutorialManager.singleton.nextTutorialSection(delayMs: 100);
      },
    ),

    19: ScriptDialog(
      hideUIonBegin: false,
      onBegin: () {
        Future.delayed(
          Duration(seconds: 1),
          () => UIDisplayState.singleton.hide.value = false,
        );
      },
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['dazzle_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['troubled_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['dazzle_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['dazzle_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['dazzle_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['thinking_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['troubled_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['thinking_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['dazzle_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['troubled_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['blank_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['dazzle_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['dazzle_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['thinking_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['troubled_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['dazzle_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['troubled_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['thinking_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['thinking_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['thinking_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['thinking_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['dazzle_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['dazzle_koupen_icon']!,
      ],
      dialogues: [
        {"Koupen": "... ~ TADA! ~"},
        {"Koupen": "Koupen-chan might not be a fast waddler...."},
        {"Koupen": "...but I have magical talents too!"},
        {
          "Koupen":
              "Anyways, the stuff that just appeared are stuff you might need during your stay....",
        },
        {
          "Koupen":
              "... and they either tell you about different things you have and done so far...",
        },
        {
          "Koupen":
              "... or let you access some tools to use for various purposes.",
        },
        {"Koupen": "At the top left, you can see a circle-y gauge...."},
        {"Koupen": "That is your [*] OSHIRI LEVEL!"},
        {"Koupen": "Its sorta like your affection level with Purin-chan..."},
        {"Koupen": "To level up, different actions grant [*] OSHIRI POINTS."},
        {"Koupen": "Although, to be honest...."},
        {"Koupen": "The 'different' actions mostly refer to FEEDING Purin."},
        {"Koupen": "So, the more you feed him, the more you gain his love!"},
        {
          "Koupen":
              "The Oshiri System is also important because by leveling up...",
        },
        {"Koupen": ".... you also UNLOCK different things as well!"},
        {
          "Koupen":
              "For each level, Purin will also grant you his WORDS OF WISDOM...",
        },
        {
          "Koupen":
              ".... though some would say the wisdom might be subjective...",
        },
        {"Koupen": ".... so kindly accept it with a grain of salt."},
        {"Koupen": "At some levels, you might unlock a new ingridient, or...."},
        {"Koupen": "~ Fufu ~... things that will be revealed later!"},
        {"Koupen": "Next on our list is something I mentioned earlier..."},
        {
          "Koupen":
              "The shiny gold thing under the [*] Oshiri Level is how much POMPOINTS you currently have.",
        },
        {"Koupen": "PomPoints is what you use to BUY ingridients and snacks!"},
        {
          "Koupen":
              "PomPoints could be acquired by using the POMTIMER, which we will waddle through later!",
        },
        {
          "Koupen":
              "Supposedly, PomPoints could be used to buy new furnitures around Purin-chan's house...",
        },
        {
          "Koupen":
              "...but, there's kinda no new furnitures that could be bought....",
        },
        {"Koupen": "....FOR NOW!"},
        {"Koupen": "Lastly, we have the two smol gauges on the left...."},
        {"Koupen": "These icons represents Purin-chan's current state..."},
        {"Koupen": "... namely, his HUNGER points and ENERGY points."},
        {
          "Koupen":
              "Purin-chan always gets hungry, so you can expect his Hunger points to go down over time.",
        },
        {
          "Koupen":
              "You only have to remember that: the MORE HUNGRY he is, the FASTER his ENERGY goes down.",
        },
        {
          "Koupen":
              "In your dimension, Energy is important to focus on your work...",
        },
        {"Koupen": "...and the same is true for ours!"},
        {
          "Koupen":
              "So, an important thing to note then: the MORE ENERGY you maintain in a PomTimer session, the MORE POMPOINTS you gain!",
        },
        {
          "Koupen":
              "So, you can kinda think of ENERGY POINTS as a sort of MULTIPLIER",
        },
        {
          "Koupen":
              "In other words: Hunger points affect Energy rate, where Energy points affect PomTimer Rewards!",
        },
        {"Koupen": "How about we try increasing our energy a bit?"},
        {
          "Koupen":
              "You can increase your energy through either SNACKS or PETTING.",
        },
        {"Koupen": "Petting Purin-chan is simple..."},
        {"Koupen": ".... you have to rub his belly with all your might!..."},
        {
          "Koupen":
              "Let's continue once you've gained 5 ENERGY POINTS from petting!",
        },
      ],

      onFinished: () {
        ScriptManager.singleton.removeTutorialScript();
        final targetEnergyLevel = PurinStateManager.singleton.energy.value;
        Purin.singleton.depleteEnergyPoints(energy: 5);
        Timer.periodic(Duration(milliseconds: 200), (timer) {
          final energyLevel = PurinStateManager.singleton.energy.value;
          if (energyLevel >= targetEnergyLevel) {
            TutorialManager.singleton.nextTutorialSection();
            timer.cancel();
          }
        });
      },
    ),

    6: ScriptDialog(
      onBegin: () {
        Future.delayed(
          Duration(milliseconds: 1000),
          () => UIDisplayState.singleton.hide.value = false,
        );
      },
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['dazzle_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['thinking_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['dazzle_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_koupen_icon']!,
      ],
      dialogues: [
        {"Purin": "~ Pom~u - Pom~u! ~"},
        {"Koupen": "Purin-chan really loves your attention!"},
        {
          "Koupen":
              "And I think it's about time we waddle through the POMTIMER!",
        },
        {
          "Koupen":
              "Using the PomTimer lets you FOCUS on your work for some time...",
        },
        {
          "Koupen":
              "... while also setting BREAK intervals in between LOOPS of your desired pace.",
        },
        {"Koupen": "Let's try opening it!"},
        {
          "Koupen":
              "Press and HOLD on the timer button icon below until it appears.",
        },
      ],
      onFinished: () {
        ScriptManager.singleton.removeTutorialScript();
        Timer.periodic(Duration(milliseconds: 200), (timer) {
          final pomTimerState =
              PomTimerDisplayStateManager.singleton.pomTimerState.value;
          if (pomTimerState == PomTimerStates.idle) {
            TutorialManager.singleton.nextTutorialSection();
            timer.cancel();
          }
        });
      },
    ),

    7: ScriptDialog(
      onBegin: () {
        Future.delayed(
          Duration(milliseconds: 1000),
          () => UIDisplayState.singleton.hide.value = false,
        );
      },
      imagePaths: [
        AssetManager.singleton.flutterAssetPaths['happy_purin_icon']!,
        AssetManager.singleton.flutterAssetPaths['dazzle_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['thinking_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['happy_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['dazzle_koupen_icon']!,
        AssetManager.singleton.flutterAssetPaths['curious_koupen_icon']!,
      ],
      dialogues: [
        {"Koupen": "The PomTimer is also a PUDDING??"},
        {"Koupen": "... is what I thought before..."},
        {"Koupen": "It's kinda better than just a plain old alarm clock, no?"},
        {
          "Koupen":
              "Anyways, you are free to set your PomTimer session from these configurations.",
        },
        {
          "Koupen":
              "FOCUS time is how long you want to work or study before another break...",
        },
        {
          "Koupen":
              "...while the BREAK time is on how long you want to rest in between Focus times.",
        },
        {
          "Koupen":
              "So, using LOOPS gives you the amount of times you want to repeat this cycle automatically.",
        },
        {"Koupen": "I heard that 25:5 is recommended... "},
        {
          "Koupen":
              "But you can consider a longer focus time when you feel pumped...",
        },
        {
          "Koupen":
              "... or a longer break time for a slower but still productive pace!",
        },
      ],
      onFinished: () {
        ScriptManager.singleton.removeTutorialScript();
        Timer.periodic(Duration(milliseconds: 200), (timer) {
          final pomTimerState =
              PomTimerDisplayStateManager.singleton.pomTimerState.value;
          if (pomTimerState == PomTimerStates.idle) {
            TutorialManager.singleton.nextTutorialSection();
            timer.cancel();
          }
        });
      },
    ),
  };
}
