import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/dialog/script_dialog/script_manager.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/prog_system.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/purin_var/purin_var.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin_state/purin_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_equip_manager.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/ui/purin_metrics_ui_state.dart';
import 'package:pomodoropompurin/scripts/layout/purin/purin_anim.dart';
import 'package:pomodoropompurin/scripts/layout/purin/purin_face.dart';
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
  late PurinFace purinFace;
  late SpriteComponent purinShadow;
  late CircleHitbox purinHitbox;

  final spriteSheetColumnFromAction = {
    PurinAction.idle: 0,
    PurinAction.pet: 1,
    PurinAction.feed: 2,
  };

  late PurinVar lastPurinVar;

  @override
  void onMount() {
    super.onMount();

    loadAnim = LoadAnimation()..removeOnFinish = true;

    purinAnim = IdleBreathingAnimation();
    purinSprite = SpriteComponent(
      sprite: Sprite(Flame.images.fromCache('purinEntity.png')),
      size: Vector2.all(70),
      position: Vector2(0, 0),
      anchor: Anchor.center,
    );
    purinFace = PurinFace();
    purinShadow = SpriteComponent(
      sprite: Sprite(Flame.images.fromCache('purin_sprites/purin_shadow.png')),
      size: Vector2.all(70),
      position: Vector2(0, 0),
      anchor: Anchor.center,
    );
    lastPurinVar = purin.equipManager.equippedPurinVar;
    updateSprite();
    updatePostion();

    purinSprite.paint.isAntiAlias = true;
    purinSprite.paint.filterQuality = FilterQuality.medium;
    add(purinAnim);
    add(purinSprite);
    add(purinFace);
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
    final purinVar = purin.equipManager.equippedPurinVar;
    final sheet = SpriteSheet(
      image: Flame.images.fromCache(purinVar.purinSpritesheetDir),
      srcSize: Vector2(500, 500),
    );

    int row = 0;
    final col = spriteSheetColumnFromAction[purin.stateManager.action]!;

    if (purin.stateManager.action == PurinAction.sleep) {
      row = 1;
    }

    purinSprite.sprite = sheet.getSprite(row, col);

    bool flip = purin.stateManager.position.flipSprite;

    if (flip && !purinSprite.isFlippedHorizontally) {
      purinSprite.flipHorizontally();
      purinFace.flipHorizontally();
    } else if (!flip && purinSprite.isFlippedHorizontally) {
      purinSprite.flipHorizontally();
      purinFace.flipHorizontally();
    }

    if (purinVar != lastPurinVar) {
      lastPurinVar = purinVar;
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
