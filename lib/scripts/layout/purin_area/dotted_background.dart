import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class DottedBackground extends Component with HasGameReference {
  final double spacing = 36;
  final double radius = 1.5;

  double offsetX = 0;
  double offsetY = 0;

  @override
  void update(double dt) {
    offsetX += dt * 5;
    offsetY += dt * 3;
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = const Color.fromARGB(36, 255, 255, 255);
    final size = game.size;

    for (double x = -spacing; x < size.x + spacing; x += spacing) {
      for (double y = -spacing; y < size.y + spacing; y += spacing) {
        canvas.drawCircle(
          Offset(x + offsetX % spacing, y + offsetY % spacing),
          radius,
          paint,
        );
      }
    }
  }
}
