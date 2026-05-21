import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class EnergyGloomEffect extends PositionComponent {
  final List<_GloomStroke> _strokes = [];

  double _time = 0;
  bool show = true;

  EnergyGloomEffect({super.position});

  @override
  Future<void> onLoad() async {
    size = Vector2(10, 10);
    anchor = Anchor.center;

    _strokes.addAll([
      _GloomStroke(baseX: 10, height: 9, phase: 0.0),
      _GloomStroke(baseX: 14, height: 15, phase: 1.3),
      _GloomStroke(baseX: 18, height: 19, phase: 2.1),
      _GloomStroke(baseX: 22, height: 12, phase: 0.7),
    ]);
  }

  @override
  void flipHorizontally() {
    super.flipHorizontally();
    position.x = -position.x;
  }

  @override
  void update(double dt) {
    super.update(dt);

    _time += dt;
  }

  @override
  void render(Canvas canvas) {
    if (!show) {
      return;
    }
    super.render(canvas);

    final outlinePaint = Paint()
      ..color = const Color.fromARGB(202, 255, 255, 255)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.4
      ..strokeCap = StrokeCap.round;

    final innerPaint = Paint()
      ..color = const Color.fromARGB(207, 44, 138, 159)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round;

    for (final stroke in _strokes) {
      final wave = sin((_time * 5) + stroke.phase) * 1.2;

      final path = Path();

      final startX = stroke.baseX;
      final topY = 0.0;

      path.moveTo(startX, topY);

      path.quadraticBezierTo(
        startX + wave,
        stroke.height * 0.45,
        startX,
        stroke.height,
      );

      canvas.drawPath(path, outlinePaint);
      canvas.drawPath(path, innerPaint);
    }
  }
}

class _GloomStroke {
  final double baseX;
  final double height;
  final double phase;

  _GloomStroke({
    required this.baseX,
    required this.height,
    required this.phase,
  });
}
