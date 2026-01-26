import 'package:flame/effects.dart';
import 'package:flame/image_composition.dart';
import 'package:flutter/widgets.dart';

class LoadAnimation extends SequenceEffect {
  LoadAnimation()
    : super([
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
}
