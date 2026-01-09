import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin_state_manager.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:pomodoropompurin/scripts/layout/purin/purin_anim.dart';

class PurinEntity extends SpriteComponent with TapCallbacks {
  PurinEntity({required Vector2 position, required Anchor anchor}) {
    this.position = position;
    sprite = Sprite(Flame.images.fromCache('SamplePurin.png'));
    size = Vector2(80, 80);
    this.anchor = anchor;
    priority = 20;
  }

  final purinAreaStateManager = PurinAreaStateManager.singleton;

  late PurinAnim purinAnim;

  @override
  void onMount() {
    super.onMount();
    purinAnim = PurinAnim();

    /// just a scalingAnim (breathing..)
    add(purinAnim);
  }

  @override
  void onLongTapDown(TapDownEvent event) {
    purinAreaStateManager.jumpToPosition(absolutePosition);
    // ... open menu and stuff
  }
}
