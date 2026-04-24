import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/acquirables.dart';
import 'package:pomodoropompurin/scripts/core/dialog/script_dialog/script_manager.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/prog_system.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_equip_manager.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/ui/purin_metrics_ui_state.dart';
import 'package:pomodoropompurin/scripts/layout/purin/purin_anim.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/effects/floating_plus_oshiri.dart';
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
  final progSystem = ProgSystem.singleton;
  int currentOshiriPoints = 0;

  final purinAreaStateManager = PurinAreaStateManager.singleton;
  final purinAreaEquipManager = PurinAreaEquipManager.singleton;

  late SequenceEffect loadAnim;
  late IdleBreathingAnimation purinAnim;
  late SpriteComponent purinSprite;
  late SpriteComponent purinShadow;
  late Map<PurinVars, SpriteSheet> purinSheets;
  late CircleHitbox purinHitbox;

  final spriteSheetRowFromPosition = {
    PurinPosition.kotatsuLeft: 0,
    PurinPosition.kotatsuRight: 0,
    PurinPosition.study: 0,
    PurinPosition.futon: 1,
    PurinPosition.sofaSitLeft: 0,
    PurinPosition.sofaSitRight: 0,
    PurinPosition.sofaRest: 1,
  };
  final spriteSheetColumnFromAction = {
    PurinAction.idle: 0,
    PurinAction.pet: 1,
    PurinAction.feed: 2,
  };
  final spriteFlipBoolFromPostion = {
    PurinPosition.kotatsuLeft: false,
    PurinPosition.kotatsuRight: true,
    PurinPosition.futon: false,
    PurinPosition.study: true,
    PurinPosition.sofaSitLeft: false,
    PurinPosition.sofaSitRight: true,
    PurinPosition.sofaRest: false,
  };

  late PurinVars lastPurinVars;

  @override
  void onMount() {
    super.onMount();

    purinSheets = {
      PurinVars.boku: SpriteSheet(
        image: Flame.images.fromCache('purin_sprites/boku_spritesheet.png'),
        srcSize: Vector2(500, 500),
      ),
      PurinVars.pumpkin: SpriteSheet(
        image: Flame.images.fromCache('purin_sprites/pumpkin_spritesheet.png'),
        srcSize: Vector2(500, 500),
      ),
      PurinVars.summer: SpriteSheet(
        image: Flame.images.fromCache('purin_sprites/summer_spritesheet.png'),
        srcSize: Vector2(500, 500),
      ),
      PurinVars.bee: SpriteSheet(
        image: Flame.images.fromCache('purin_sprites/bee_spritesheet.png'),
        srcSize: Vector2(500, 500),
      ),
      PurinVars.pika: SpriteSheet(
        image: Flame.images.fromCache('purin_sprites/pika_spritesheet.png'),
        srcSize: Vector2(500, 500),
      ),
      PurinVars.yana: SpriteSheet(
        image: Flame.images.fromCache('purin_sprites/yana_spritesheet.png'),
        srcSize: Vector2(500, 500),
      ),
      PurinVars.pol: SpriteSheet(
        image: Flame.images.fromCache('purin_sprites/pol_spritesheet.png'),
        srcSize: Vector2(500, 500),
      ),
      PurinVars.atenean: SpriteSheet(
        image: Flame.images.fromCache('purin_sprites/atenean_spritesheet.png'),
        srcSize: Vector2(500, 500),
      ),
      PurinVars.fragaria: SpriteSheet(
        image: Flame.images.fromCache('purin_sprites/fragaria_spritesheet.png'),
        srcSize: Vector2(500, 500),
      ),
      PurinVars.winter: SpriteSheet(
        image: Flame.images.fromCache('purin_sprites/winter_spritesheet.png'),
        srcSize: Vector2(500, 500),
      ),
      PurinVars.beach: SpriteSheet(
        image: Flame.images.fromCache('purin_sprites/beach_spritesheet.png'),
        srcSize: Vector2(500, 500),
      ),
    };

    loadAnim = LoadAnimation()..removeOnFinish = true;
    purinAnim = IdleBreathingAnimation();
    purinSprite = SpriteComponent(
      sprite: Sprite(Flame.images.fromCache('purinEntity.png')),
      size: Vector2.all(70),
      position: Vector2(0, 0),
      anchor: Anchor.center,
    );
    purinShadow = SpriteComponent(
      sprite: Sprite(Flame.images.fromCache('purin_sprites/purin_shadow.png')),
      size: Vector2.all(70),
      position: Vector2(0, 0),
      anchor: Anchor.center,
    );
    lastPurinVars = purin.equipManager.equippedPurinVar.id;
    updateSprite();
    updatePostion();

    purinSprite.paint.isAntiAlias = true;
    purinSprite.paint.filterQuality = FilterQuality.medium;
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
    PurinAreaStateManager.singleton.jumpToPosition(
      purin.purinPositionVect2,
      Vector2.zero(),
      1.2,
    );

    currentOshiriPoints = progSystem.oshiriPoints.value;
    progSystem.oshiriPoints.addListener(addFloatingPlusOshiri);
  }

  void updatePostion() {
    if (position != purin.purinPositionVect2) {
      priority = purin.purinPriority;
      position = purin.purinPositionVect2;
      reloadLoadAnimation();
    }
  }

  void updateSprite() {
    final purinVar = purin.equipManager.equippedPurinVar.id;
    final sheet = purinSheets[purinVar]!;

    final row = spriteSheetRowFromPosition[purin.stateManager.position]!;
    final col = spriteSheetColumnFromAction[purin.stateManager.action]!;

    purinSprite.sprite = sheet.getSprite(row, col);

    bool flip = spriteFlipBoolFromPostion[purin.stateManager.position]!;

    if (flip && !purinSprite.isFlippedHorizontally) {
      purinSprite.flipHorizontally();
    } else if (!flip && purinSprite.isFlippedHorizontally) {
      purinSprite.flipHorizontally();
    }

    if (purinVar as PurinVars != lastPurinVars) {
      lastPurinVars = purinVar;
      reloadLoadAnimation();
    }
  }

  void reloadLoadAnimation() {
    add(loadAnim..reset());
  }

  void addFloatingPlusOshiri() {
    final newOshiriPoints = progSystem.oshiriPoints.value;
    add(
      FloatingPlusOshiri(
        position: Vector2(0, -20),
        points: newOshiriPoints - currentOshiriPoints,
      ),
    );
    currentOshiriPoints = newOshiriPoints;
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (purinAreaStateManager.state.value == "Feed") {
      purin.feedFeedable();
      purinAreaStateManager.state.value = "Idle";
    } else {
      purinAreaStateManager.state.value = "Pet";
    }
  }

  @override
  void onLongTapDown(TapDownEvent event) {
    UIDisplayState.singleton.hide.value = true;
    PurinMetricsUIState.singleton.hideWidget();
    game.overlays.removeAll(game.overlays.activeOverlays);
    purinAreaStateManager.jumpToPosition(
      absolutePosition,
      Vector2(70, -100),
      1.5,
    );
    game.overlays.add("purinMainMenu");
    ScriptManager.singleton.addPurinMenuDialog();
  }
}
