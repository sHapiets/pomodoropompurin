import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/acquirables.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_equip_manager.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:pomodoropompurin/scripts/layout/purin/purin_anim.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/load_animation.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/purin_area.dart';
import 'package:pomodoropompurin/scripts/core/ui/ui_display_state.dart';

/// The definitive Flame component of [Purin] on [PurinArea].
/// Handles the current configurations of [Purin] during runtime, such
/// as current position, sprite, hitbox, animation, timers, etc.
///
/// Only a single instance of this component is added via [PurinArea].
/// All changes within the configurations are controlled via
/// notifyListeners() of the [Purin] class. Hence, if you decide to add
/// a feature within this that updates [PurinEntity], you must add the
/// function as a listener.
///
/// [PurinEntity] also has input components, like taps and long presses.
/// To keep the entire codebase clean, I would highly recommend to never
/// add any direct updates unto itself. What I simply mean is that,
/// I want to treat the input side of this class like a different class
/// altogether, instead of just a subsection that could call functions in
/// the 'display' or output side directly from the callbacks.
///
/// Instead, input should only make changes to the managers (via [Purin]),
/// and then add your function you wish to update to those managers.
class PurinEntity extends PositionComponent
    with TapCallbacks, DoubleTapCallbacks, GestureHitboxes, HasGameReference {
  PurinEntity() {
    anchor = Anchor.center;
    priority = 40;
  }

  final purin = Purin.singleton;
  final purinAreaStateManager = PurinAreaStateManager.singleton;
  final purinAreaEquipManager = PurinAreaEquipManager.singleton;

  late SequenceEffect loadAnim;
  late PurinAnim purinAnim;
  late SpriteComponent purinSprite;
  late CircleHitbox purinHitbox;

  final spriteDirectoryFromPurinVar = {
    PurinVars.boku: 'boku/',
    PurinVars.pumpkin: 'pumpkin/',
    PurinVars.shrimp: 'shrimp/',
  };
  final spriteDirectoryFromPosition = {
    PurinPosition.kotatsuLeft: 'sit/',
    PurinPosition.kotatsuRight: 'sit/',
    PurinPosition.futon: 'futon/',
    PurinPosition.study: 'sit/',
  };
  final spriteFileFromAction = {
    PurinAction.idle: 'idle.png',
    PurinAction.pet: 'pet.png',
    PurinAction.feed: 'feed.png',
  };
  final spriteFlipBoolFromPostion = {
    PurinPosition.kotatsuLeft: false,
    PurinPosition.kotatsuRight: true,
    PurinPosition.futon: false,
    PurinPosition.study: true,
  };

  @override
  void onMount() {
    super.onMount();
    position = Vector2(130, 160);

    loadAnim = LoadAnimation()..removeOnFinish = true;
    purinAnim = PurinAnim();
    purinSprite = SpriteComponent(
      sprite: Sprite(Flame.images.fromCache('purin_sprites/boku/sit/idle.png')),
      size: Vector2.all(70),
      position: Vector2(0, 0),
      anchor: Anchor.center,
    );
    updateSprite();
    updatePostion();

    add(purinAnim);
    add(purinSprite);
    add(loadAnim);

    //sample hitbox, to put in center first!
    purinHitbox = CircleHitbox(
      radius: 25,
      anchor: Anchor.center, // <-- remember this
    );
    purinHitbox.paint.color = const Color.fromARGB(135, 68, 137, 255);
    //hitbox.renderShape = true;
    add(purinHitbox);

    purin.addListener(updatePostion);
    purin.addListener(updateSprite);
  }

  void updatePostion() {
    if (position != purin.purinPositionVect2) {
      priority = purin.purinPriority;
      position = purin.purinPositionVect2;
      reloadLoadAnimation();
    }
  }

  void updateSprite() {
    final spriteRef = StringBuffer()
      ..write('purin_sprites/')
      ..write(
        spriteDirectoryFromPurinVar[purin.equipManager.equippedPurinVar.id],
      )
      ..write(spriteDirectoryFromPosition[purin.stateManager.position])
      ..write(spriteFileFromAction[purin.stateManager.action]);

    purinSprite.sprite?.image = Flame.images.fromCache(spriteRef.toString());
    bool flip = spriteFlipBoolFromPostion[purin.stateManager.position]!;
    (flip && !purinSprite.isFlippedHorizontally)
        ? purinSprite.flipHorizontally()
        : () {};
    (!flip && purinSprite.isFlippedHorizontally)
        ? purinSprite.flipHorizontally()
        : () {};
  }

  void reloadLoadAnimation() {
    add(loadAnim..reset());
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (purinAreaStateManager.state.value == "Feed") {
      purin.feed();
      purinAreaStateManager.state.value = "Idle";
    } else {
      purinAreaStateManager.state.value = "Pet";
    }
  }

  @override
  void onLongTapDown(TapDownEvent event) {
    UIDisplayState.singleton.hide.value = true;
    game.overlays.removeAll(game.overlays.activeOverlays);
    purinAreaStateManager.jumpToPosition(
      absolutePosition,
      Vector2(70, -100),
      1.5,
    );
    game.overlays.add("purinMainMenu");
  }
}
