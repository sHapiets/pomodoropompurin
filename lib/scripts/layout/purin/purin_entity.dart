import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'package:pomodoropompurin/scripts/layout/purin/purin_anim.dart';

class PurinEntity extends SpriteComponent with TapCallbacks {
  PurinEntity({required Vector2 position, required Anchor anchor}) {
    this.position = position;
    sprite = Sprite(Flame.images.fromCache('SamplePurin.png'));
    size = Vector2(60, 60);
    this.anchor = anchor;
  }

  late PurinAnim purinAnim;

  @override
  void onMount() {
    super.onMount();

    purinAnim = PurinAnim();
    add(purinAnim);
  }

  @override
  void onTapDown(TapDownEvent event) {}
}
