import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class FloatingPlusOshiri extends TextComponent {
  final double lifetime = 1.2;
  double elapsed = 0;

  FloatingPlusOshiri({required Vector2 position, required int points})
    : super(
        text: '+$points *',
        position: position,
        anchor: Anchor.center,
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Colors.greenAccent,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  @override
  void update(double dt) {
    super.update(dt);

    elapsed += dt;

    // Move upward
    position.y -= 40 * dt;

    // Fade out by changing text alpha
    final progress = (elapsed / lifetime).clamp(0, 1);
    final alpha = (255 * (1 - progress)).toInt();

    final style = (textRenderer as TextPaint).style;
    textRenderer = TextPaint(
      style: style.copyWith(color: style.color!.withAlpha(alpha)),
    );

    if (elapsed >= lifetime) {
      removeFromParent();
    }
  }
}
