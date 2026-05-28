import 'package:flutter/material.dart';
import 'package:flame/components.dart';

class DayNightCycle extends Component {
  Color nightColor = const Color.fromARGB(255, 26, 8, 77);
  double intensity = 0.3; // 0.0 = Midday (clear), 0.7 = Midnight (dark)

  @override
  void update(double dt) {
    super.update(dt);
    // TODO: Update your 'intensity' here based on your game time.
    // For example, slowly sinusoids between 0.0 and 0.7
  }

  @override
  void render(Canvas canvas) {
    // Only apply if it's not peak daylight
    if (intensity > 0) {
      final paint = Paint()
        ..color = nightColor.withOpacity(intensity)
        ..blendMode = BlendMode
            .multiply; // 'multiply' darkens the sprites underneath beautifully

      // Draw across the entire viewport
      canvas.drawRect(
        Rect.fromCenter(center: Offset.zero, width: 10000, height: 5000),
        paint,
      );
      // Note: Use gameRef.size or camera.viewport.size to get the actual screen bounds
    }
  }
}
