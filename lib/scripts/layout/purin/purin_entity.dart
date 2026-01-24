import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_equip_manager.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:pomodoropompurin/scripts/layout/purin/purin_anim.dart';
import 'package:pomodoropompurin/scripts/page/main_page.dart';

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
    priority = 20;
  }

  final purin = Purin.singleton;
  final purinAreaStateManager = PurinAreaStateManager.singleton;
  final purinAreaEquipManager = PurinAreaEquipManager.singleton;

  late PurinAnim purinAnim;
  late SpriteComponent purinSprite;
  late CircleHitbox purinHitbox;

  late TimerComponent actionCooldown;

  @override
  void onMount() {
    super.onMount();
    position = Vector2(130, 160);

    purinAnim = PurinAnim();
    purinSprite = SpriteComponent(
      sprite: Sprite(Flame.images.fromCache('purinEntity.png')),
      size: Vector2.all(90),
      position: Vector2(0, 0),
      anchor: Anchor.center,
    );
    updateSprite();

    /// just a scalingAnim (breathing..)
    add(purinAnim);
    add(purinSprite);

    //sample hitbox, to put in center first!
    purinHitbox = CircleHitbox(
      radius: 25,
      anchor: Anchor.center, // <-- remember this
    );
    purinHitbox.paint.color = const Color.fromARGB(135, 68, 137, 255);
    //hitbox.renderShape = true;
    add(purinHitbox);

    // timer for onTap timers and cancel
    actionCooldown = TimerComponent(
      autoStart: false,
      period: 0.7, // <- check how much time (0.3s or lower?)
      onTick: () {
        purin.idle();
      },
    );
    add(actionCooldown);

    purin.addListener(updatePostion);
    purin.addListener(updateSprite);
    purin.restartPetTimer = restartActionCooldown;
  }

  void updatePostion() {
    switch (purin.stateManager.position) {
      case PurinPosition.kotatsu:
        position = purinAreaEquipManager.kotatsu.position;
      default:
        break;
    }
  }

  void updateSprite() {
    String spriteRef = '';
    spriteRef += 'purin_sprites/';
    spriteRef += '${purin.equipManager.equippedPurinVar.id}/';

    switch (purin.stateManager.position) {
      case PurinPosition.kotatsu:
        spriteRef += 'kotatsu/';
    }

    switch (purin.stateManager.action) {
      case PurinAction.idle:
        spriteRef += 'idle.png';
      case PurinAction.pet:
        spriteRef += 'pet.png';
      default:
        spriteRef += 'idle.png';
    }

    purinSprite.sprite?.image = Flame.images.fromCache(spriteRef);
  }

  void restartActionCooldown() {
    actionCooldown.timer.reset();
    actionCooldown.timer.start();
  }

  @override
  void onTapDown(TapDownEvent event) {
    purinAreaStateManager.state.value = "Pet";
  }

  @override
  void onLongTapDown(TapDownEvent event) {
    game.overlays.removeAll(game.overlays.activeOverlays);
    purinAreaStateManager.jumpToPosition(absolutePosition);
    game.overlays.add("purinMainMenu");
  }
}
