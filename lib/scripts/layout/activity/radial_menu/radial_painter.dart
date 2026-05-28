import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/layout/activity/radial_menu/radial_menu_item.dart';

class RadialPainter extends CustomPainter {
  final Offset center;
  final List<RadialMenuItem> items;
  final double radius;
  final int? hoveredIndex;

  RadialPainter({
    required this.center,
    required this.items,
    required this.radius,
    required this.hoveredIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final sliceAngle = (2 * pi) / items.length;

    for (int i = 0; i < items.length; i++) {
      final startAngle = (-pi / 2) + (sliceAngle * i);

      final isHovered = hoveredIndex == i;

      final paint = Paint()
        ..color = isHovered
            ? items[i].color.withOpacity(0.95)
            : items[i].color.withOpacity(0.75)
        ..style = PaintingStyle.fill;

      final path = Path()
        ..moveTo(center.dx, center.dy)
        ..arcTo(
          Rect.fromCircle(center: center, radius: radius),
          startAngle,
          sliceAngle,
          false,
        )
        ..close();

      canvas.drawPath(path, paint);

      final iconAngle = startAngle + sliceAngle / 2;

      final iconRadius = radius * 0.65;

      final iconPosition = Offset(
        center.dx + cos(iconAngle) * iconRadius,
        center.dy + sin(iconAngle) * iconRadius,
      );

      final textPainter = TextPainter(
        text: TextSpan(
          text: String.fromCharCode(items[i].icon.codePoint),
          style: TextStyle(
            fontSize: isHovered ? 34 : 28,
            fontFamily: items[i].icon.fontFamily,
            package: items[i].icon.fontPackage,
            color: Colors.white,
          ),
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();

      textPainter.paint(
        canvas,
        iconPosition - Offset(textPainter.width / 2, textPainter.height / 2),
      );
    }

    final centerPaint = Paint()..color = Colors.black.withOpacity(0.85);

    canvas.drawCircle(center, 36, centerPaint);
  }

  @override
  bool shouldRepaint(covariant RadialPainter oldDelegate) {
    return oldDelegate.hoveredIndex != hoveredIndex;
  }
}
