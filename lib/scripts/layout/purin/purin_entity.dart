import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:pomodoropompurin/scripts/layout/purin/purin_anim.dart';

///
class PurinEntity extends PositionComponent
    with TapCallbacks, GestureHitboxes, HasGameReference {
  PurinEntity() {
    anchor = Anchor.center;
    priority = 20;
  }

  final purin = Purin.singleton;
  final purinAreaStateManager = PurinAreaStateManager.singleton;

  late PurinAnim purinAnim;
  late SpriteComponent purinSprite;
  late PolygonHitbox purinHitbox;

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

    /// just a scalingAnim (breathing..)
    add(purinAnim);
    add(purinSprite);

    //sample hitbox, to put in center first!
    final hitbox = CircleHitbox(
      radius: 25,
      anchor: Anchor.center, // <-- remember this
    );
    hitbox.paint.color = const Color.fromARGB(135, 68, 137, 255);
    //hitbox.renderShape = true;
    add(hitbox);

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
  }

  void updatePostion() {
    switch (purin.stateManager.position) {
      case PurinPosition.kotatsu:
        position = Vector2(130, 160);
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
  void onLongTapDown(TapDownEvent event) {
    game.overlays.removeAll(game.overlays.activeOverlays);
    purinAreaStateManager.jumpToPosition(absolutePosition);
    game.overlays.add("purinMainMenu");
  }

  @override
  void onTapDown(TapDownEvent event) {
    purinAreaStateManager.state.value = 'Pet';
    game.overlays.removeAll(game.overlays.activeOverlays);
  }
}
