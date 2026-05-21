import 'dart:math';
import 'dart:ui';
import 'package:flame/components.dart';

class HungerPulseEffect extends PositionComponent {
  final List<_HungerRay> _rays = [];

  final Random _random = Random();

  double _time = 0;
  bool show = true;

  /// Duration of one pulse cycle
  final double pulseSpeed = 1.4;

  HungerPulseEffect({super.position});

  @override
  Future<void> onLoad() async {
    size = Vector2(80, 80);
    anchor = Anchor.center;

    // Fixed rays
    for (int i = 0; i < 6; i++) {
      _rays.add(
        _HungerRay(
          angle: radians(332 + (i / 5) * 75),
          phase: _random.nextDouble() * pi * 2,
        ),
      );
    }
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

    final center = Offset(size.x / 2, size.y / 2);

    final outlinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final innerPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    for (final ray in _rays) {
      const pulseDuration = 1.2;
      const restDuration = 0.8;

      final totalCycle = pulseDuration + restDuration;

      final cycleTime = _time % totalCycle;

      final isResting = cycleTime > pulseDuration;

      double pulse = 0;
      double progress = 0;

      if (!isResting) {
        progress = cycleTime / pulseDuration;
        pulse = sin(progress * pi);
      }

      if (isResting || pulse <= 0.001) {
        continue;
      }

      final wave = sin((_time * 5) + ray.phase) * 0.05;

      final dynamicAngle = ray.angle + wave;

      // Radius moves outward
      final startRadius = lerpDouble(13, 36, progress)!;

      // Length grows then shrinks
      final animatedLength = ray.maxLength * pulse;

      final endRadius = startRadius + animatedLength;

      final opacity = 0.2 + (pulse * 0.6);

      final start = Offset(
        center.dx + cos(dynamicAngle) * startRadius,
        center.dy + sin(dynamicAngle) * startRadius,
      );

      final end = Offset(
        center.dx + cos(dynamicAngle) * endRadius,
        center.dy + sin(dynamicAngle) * endRadius,
      );

      outlinePaint.color = const Color.fromARGB(
        255,
        255,
        255,
        255,
      ).withOpacity(opacity);

      innerPaint.color = const Color.fromARGB(
        255,
        208,
        62,
        62,
      ).withOpacity(opacity);
      final path = Path();

      final midX = (start.dx + end.dx) / 2;
      final midY = (start.dy + end.dy) / 2;

      // Perpendicular wobble
      final perpendicularAngle = dynamicAngle + (pi / 2);

      final waveOffset = sin((_time * 7) + ray.phase) * 1.8;

      final controlPoint = Offset(
        midX + cos(perpendicularAngle) * waveOffset,
        midY + sin(perpendicularAngle) * waveOffset,
      );

      path.moveTo(start.dx, start.dy);

      path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, end.dx, end.dy);

      canvas.drawPath(path, outlinePaint);
      canvas.drawPath(path, innerPaint);
    }
  }

  double radians(double degrees) {
    return degrees * (pi / 180);
  }
}

class _HungerRay {
  final double angle;
  final double phase;

  late final double maxLength;

  _HungerRay({required this.angle, required this.phase}) {
    maxLength = 7 + Random().nextDouble() * 8;
  }
}
