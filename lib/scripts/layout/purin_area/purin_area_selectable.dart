import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/ui/ui_display_state.dart';
import 'package:pomodoropompurin/scripts/foundation/acquirable.dart';

/// A foundation class that is inherited by all Selectables.
///
/// Selectables are 'objects' within the Flame GameWidget added in PurinAreaHome
/// that are basically customizeable throughout the playthrough. All selectable classes
/// are found under .../lib/layout/purinArea/selectables
///
/// A selectable inheriting this class is constructed by initially passing
/// a final position, hitbox, and priority (via super)
/// Position is set relative to the absolute center of the parent component (PurinAreaHome).
/// Hitbox vectors are w.r.t the center anchor, s.t. (0, 0) is defaulted at the set position.
/// then configuring an initial sprite before this class's onMount (super.onMount())
///
/// Since the sprite is expected to change throughout, this class supports functions
/// that changes the sprite based on the STATE MANAGER.
///
/// IMPORTANT: Each selectable inheriting this super class is expected to have an override
/// for most of these functions.
/// Mostly of what I've added here are functionalities that all selectables should have,
/// such as display control during taps, animations, and sprite changing logic.
/// Instructions of how to override them are already added for reference.
class PurinAreaSelectable extends PositionComponent
    with TapCallbacks, GestureHitboxes, HasGameReference {
  PurinAreaSelectable({
    required Vector2 position,
    required this.hitbox,
    required int priority,
  }) : super(position: position) {
    anchor = Anchor.center;
    this.priority = priority;
  }

  final purinAreaStateManager = PurinAreaStateManager.singleton;

  late SpriteComponent sprite;
  late PolygonHitbox hitbox;
  late SequenceEffect onLoadAnim;

  /// The onMount function of this super class must be ADDED AFTER sprite initialization.
  /// Refer to Kotatsu.dart as a proper example...
  @override
  void onMount() {
    super.onMount();
    hitbox.paint.color = const Color.fromARGB(124, 68, 137, 255);
    //hitbox.renderShape = true;
    add(sprite);
    add(hitbox);
    addOnLoadAnim();
  }

  /// A simple 'bobbing' animation, which is used when loading or reloaded with
  /// a new sprite.
  ///
  /// NOTE: super.changeDesign already calls this function, so do not call when
  /// overriding...
  void addOnLoadAnim() {
    onLoadAnim = SequenceEffect([
      ScaleEffect.to(
        Vector2.all(1.4),
        EffectController(duration: 0.15, curve: Curves.easeOut),
      ),
      ScaleEffect.to(
        Vector2.all(0.6),
        EffectController(duration: 0.15, curve: Curves.easeIn),
      ),
      ScaleEffect.to(
        Vector2.all(1.1),
        EffectController(duration: 0.15, curve: Curves.easeOut),
      ),
      ScaleEffect.to(
        Vector2.all(0.9),
        EffectController(duration: 0.15, curve: Curves.easeIn),
      ),
      ScaleEffect.to(
        Vector2.all(1),
        EffectController(duration: 0.15, curve: Curves.easeOut),
      ),
    ]);
    add(onLoadAnim);
  }

  /// Changes the current sprite by passing a RoomDesign.
  ///
  /// NOTE: In order to use this from outside the context, a callback
  /// function must be added to the State Manager, then connect it to
  /// this function during onMount.
  /// Refer to Kotatsu.dart/onMount() as guide...
  void changeDesign(RoomDesign newRoomDesign) {
    final assetPath = newRoomDesign.spriteFlamePath;
    sprite.sprite = Sprite(Flame.images.fromCache(assetPath));
    addOnLoadAnim();
  }

  /// Added to pass on any normal tap events. This is to still allow camera movement
  /// (which are onTap and onDoubleTap) within its hitbox
  @override
  void onTapDown(TapDownEvent event) {
    event.continuePropagation = true;
  }

  /// Selectables are selected (really??) via long touch.
  ///
  /// NOTE: As of the moment of writing, this super class defines this action
  /// to (1) remove PurinArea overlays, and (2) centering the selectable.
  /// Overriding is necessary to open the appropriate menu for that selectable.
  /// Refer to the overriding function Kotatsu.dart for more details...
  @override
  void onLongTapDown(TapDownEvent event) {
    UIDisplayState.singleton.hide.value = true;
    game.overlays.removeAll(game.overlays.activeOverlays);
    purinAreaStateManager.jumpToPosition(
      absolutePosition,
      Vector2(0, -200),
      1.0,
    );
  }
}
