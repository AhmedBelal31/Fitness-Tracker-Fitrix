import 'package:flutter/material.dart';

class NotificationBadgePainter extends CustomPainter {
  final Color badgeColor;
  final Color glowColor;
  final bool animate;
  final double animationValue;

  NotificationBadgePainter({
    required this.badgeColor,
    required this.glowColor,
    this.animate = false,
    this.animationValue = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Animated glow effect
    if (animate) {
      final glowPaint = Paint()
        ..color = glowColor.withValues(alpha: 0.3 * (1 - animationValue))
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

      canvas.drawCircle(center, radius + (10 * animationValue), glowPaint);
    }

    // Badge shadow
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawCircle(center.translate(0, 1), radius, shadowPaint);

    // Badge gradient
    final gradient = RadialGradient(
      colors: [badgeColor.withValues(alpha: 0.9), badgeColor],
      stops: const [0.0, 1.0],
    );

    final gradientPaint = Paint()
      ..shader = gradient.createShader(
        Rect.fromCircle(center: center, radius: radius),
      );
    canvas.drawCircle(center, radius, gradientPaint);

    // Inner highlight
    final highlightPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);
    canvas.drawCircle(center.translate(-1, -1), radius * 0.4, highlightPaint);
  }

  @override
  bool shouldRepaint(NotificationBadgePainter oldDelegate) {
    return animate != oldDelegate.animate ||
        animationValue != oldDelegate.animationValue ||
        badgeColor != oldDelegate.badgeColor;
  }
}
