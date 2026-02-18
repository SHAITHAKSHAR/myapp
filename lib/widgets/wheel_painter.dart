import 'dart:math';
import 'package:flutter/material.dart';

class WheelPainter extends CustomPainter {
  final List<String> items;

  WheelPainter({required this.items});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);
    final segmentAngle = 2 * pi / items.length;

    final colors = [
      Colors.red.shade400,
      Colors.orange.shade400,
      Colors.yellow.shade400,
      Colors.green.shade400,
      Colors.blue.shade400,
      Colors.indigo.shade400,
      Colors.purple.shade400,
      Colors.pink.shade400,
    ];

    for (int i = 0; i < items.length; i++) {
      final startAngle = i * segmentAngle;
      final paint = Paint()..color = colors[i % colors.length];

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        segmentAngle,
        true,
        paint,
      );

      // Draw the text
      final textPainter = TextPainter(
        text: TextSpan(
          text: items[i],
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 5.0,
                color: Colors.black.withAlpha(128),
                offset: const Offset(2.0, 2.0),
              ),
            ],
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      final textAngle = startAngle + segmentAngle / 2;
      final textOffset = Offset(
        center.dx + (radius * 0.7) * cos(textAngle),
        center.dy + (radius * 0.7) * sin(textAngle),
      );

      canvas.save();
      canvas.translate(textOffset.dx, textOffset.dy);
      canvas.rotate(textAngle + pi / 2);
      textPainter.paint(canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
