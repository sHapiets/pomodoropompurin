import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

class HeartParticle extends ParticleSystemComponent {
  HeartParticle({required Vector2 position})
    : super(
        particle: Particle.generate(
          count: 1,
          lifespan: 0.8 + Random().nextDouble() * 0.6,
          generator: (i) {
            final random = Random();

            return AcceleratedParticle(
              acceleration: Vector2(0, -20),
              speed: Vector2(
                (random.nextDouble() - 0.5) * 40,
                -50 - random.nextDouble() * 40,
              ),
              position: Vector2.zero(),
              child: ComputedParticle(
                renderer: (canvas, particle) {
                  final size = 8 + random.nextDouble() * 8;

                  final paint = Paint()
                    ..color = Color.fromARGB(255, 255, 247, 178);
                  final edgePaint = Paint()
                    ..color = Color.fromARGB(255, 158, 83, 60)
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 1.3;

                  final path = Path();
                  path.moveTo(0, size / 4);
                  path.cubicTo(0, 0, size / 2, 0, size / 2, size / 4);
                  path.cubicTo(size / 2, 0, size, 0, size, size / 4);
                  path.cubicTo(size, size / 2, size / 2, size, size / 2, size);
                  path.cubicTo(size / 2, size, 0, size / 2, 0, size / 4);

                  canvas.drawPath(path, paint);
                  canvas.drawPath(path, edgePaint);
                },
              ),
            );
          },
        ),
        position: position,
        priority: 999,
      );
}
