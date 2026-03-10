import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/widgets.dart';

class IdleBreathingAnimation extends SequenceEffect {
  IdleBreathingAnimation()
    : super([
        ScaleEffect.to(
          Vector2.all(1.1),
          EffectController(duration: 0.8, curve: Curves.easeInOut),
        ),
        ScaleEffect.to(
          Vector2.all(1.0),
          EffectController(duration: 0.8, curve: Curves.easeInOut),
        ),
      ], infinite: true);
}
