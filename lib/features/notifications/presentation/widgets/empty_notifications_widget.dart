import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import 'dart:math' as math;

class EmptyNotificationsWidget extends StatefulWidget {
  const EmptyNotificationsWidget({super.key});

  @override
  State<EmptyNotificationsWidget> createState() =>
      _EmptyNotificationsWidgetState();
}

class _EmptyNotificationsWidgetState extends State<EmptyNotificationsWidget>
    with TickerProviderStateMixin {
  late AnimationController _floatController;
  late AnimationController _rotateController;
  late AnimationController _particleController;
  late AnimationController _shimmerController;

  late Animation<double> _floatAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _particleAnimation;
  late Animation<double> _shimmerAnimation;

  final List<Particle> _particles = [];

  @override
  void initState() {
    super.initState();

    // Float animation
    _floatController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -15, end: 15).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    // Subtle rotate animation
    _rotateController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    _rotateAnimation = Tween<double>(begin: -0.05, end: 0.05).animate(
      CurvedAnimation(parent: _rotateController, curve: Curves.easeInOut),
    );

    // Particle animation
    _particleController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();

    _particleAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_particleController);

    // Shimmer animation
    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();

    _shimmerAnimation = Tween<double>(begin: -1, end: 2).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );

    // Initialize particles
    _initParticles();
  }

  void _initParticles() {
    final random = math.Random();
    for (int i = 0; i < 20; i++) {
      _particles.add(
        Particle(
          x: random.nextDouble() * 200 - 100,
          y: random.nextDouble() * 200 - 100,
          size: random.nextDouble() * 3 + 1,
          speed: random.nextDouble() * 0.5 + 0.2,
          angle: random.nextDouble() * math.pi * 2,
        ),
      );
    }
  }

  @override
  void dispose() {
    _floatController.dispose();
    _rotateController.dispose();
    _particleController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated Bell with Particles
          AnimatedBuilder(
            animation: Listenable.merge([
              _floatController,
              _rotateController,
              _particleController,
              _shimmerController,
            ]),
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _floatAnimation.value),
                child: Transform.rotate(
                  angle: _rotateAnimation.value,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Particles background
                      CustomPaint(
                        size: Size(250.w, 250.h),
                        painter: ParticlesPainter(
                          particles: _particles,
                          animationValue: _particleAnimation.value,
                          primaryColor: ColorsManager.getPrimaryGreen(context),
                        ),
                      ),

                      // Main Bell
                      CustomPaint(
                        size: Size(200.w, 200.h),
                        painter: Enhanced3DBellPainter(
                          primaryColor: ColorsManager.getPrimaryGreen(context),
                          secondaryColor: ColorsManager.getSecondaryGreen(
                            context,
                          ),
                          isDark:
                              Theme.of(context).brightness == Brightness.dark,
                          shimmerValue: _shimmerAnimation.value,
                        ),
                      ),

                      // Glow effect
                      Container(
                        width: 200.w,
                        height: 200.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: ColorsManager.getPrimaryGreen(
                                context,
                              ).withOpacity(0.3),
                              blurRadius: 40,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          SizedBox(height: 48.h),

          // Animated Text with Shimmer
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOut,
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, 20 * (1 - value)),
                  child: child,
                ),
              );
            },
            child: ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  colors: [
                    ColorsManager.getPrimaryText(context),
                    ColorsManager.getPrimaryGreen(context),
                    ColorsManager.getPrimaryText(context),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ).createShader(bounds);
              },
              child: Text(
                s.no_notifications,
                style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SizedBox(height: 12.h),

          // Description with fade-in
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeOut,
            builder: (context, value, child) {
              return Opacity(opacity: value, child: child);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 48.w),
              child: Text(
                s.no_notifications_desc,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: ColorsManager.getSecondaryText(context),
                  height: 1.5,
                ),
              ),
            ),
          ),

          SizedBox(height: 32.h),

          // Decorative dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: Duration(milliseconds: 1200 + (index * 100)),
                curve: Curves.elasticOut,
                builder: (context, value, child) {
                  return Transform.scale(scale: value, child: child);
                },
                child: Container(
                  width: 8.w,
                  height: 8.h,
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        ColorsManager.getPrimaryGreen(context),
                        ColorsManager.getSecondaryGreen(context),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ColorsManager.getPrimaryGreen(
                          context,
                        ).withOpacity(0.5),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

// Particle class for floating particles
class Particle {
  double x;
  double y;
  final double size;
  final double speed;
  final double angle;

  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.angle,
  });
}

// Particles Painter
class ParticlesPainter extends CustomPainter {
  final List<Particle> particles;
  final double animationValue;
  final Color primaryColor;

  ParticlesPainter({
    required this.particles,
    required this.animationValue,
    required this.primaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()..style = PaintingStyle.fill;

    for (var particle in particles) {
      final progress = (animationValue + particle.speed) % 1.0;
      final distance = progress * 100;

      final x = center.dx + particle.x + math.cos(particle.angle) * distance;
      final y = center.dy + particle.y + math.sin(particle.angle) * distance;

      final opacity = 1.0 - progress;
      paint.color = primaryColor.withOpacity(opacity * 0.6);

      canvas.drawCircle(Offset(x, y), particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(ParticlesPainter oldDelegate) => true;
}

// Enhanced 3D Bell Painter
class Enhanced3DBellPainter extends CustomPainter {
  final Color primaryColor;
  final Color secondaryColor;
  final bool isDark;
  final double shimmerValue;

  Enhanced3DBellPainter({
    required this.primaryColor,
    required this.secondaryColor,
    required this.isDark,
    required this.shimmerValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Draw shadow
    _drawShadow(canvas, center);

    // Draw main bell body with 3D effect
    _drawBellBody(canvas, center, size);

    // Draw bell rim
    _drawBellRim(canvas, center);

    // Draw clapper
    _drawClapper(canvas, center);

    // Draw highlights
    _drawHighlights(canvas, center);

    // Draw shimmer effect
    _drawShimmer(canvas, center, size);

    // Draw animated sound waves
    _drawSoundWaves(canvas, center);
  }

  void _drawShadow(Canvas canvas, Offset center) {
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);

    // Use drawOval instead of drawEllipse
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(center.dx, center.dy + 70),
        width: 100,
        height: 20,
      ),
      shadowPaint,
    );
  }

  void _drawBellBody(Canvas canvas, Offset center, Size size) {
    final bellPath = Path();

    // Top handle
    bellPath.moveTo(center.dx - 8, center.dy - 45);
    bellPath.lineTo(center.dx - 8, center.dy - 55);
    bellPath.arcToPoint(
      Offset(center.dx + 8, center.dy - 55),
      radius: const Radius.circular(8),
    );
    bellPath.lineTo(center.dx + 8, center.dy - 45);

    // Bell curves
    bellPath.moveTo(center.dx, center.dy - 45);
    bellPath.quadraticBezierTo(
      center.dx - 55,
      center.dy - 45,
      center.dx - 55,
      center.dy + 15,
    );
    bellPath.lineTo(center.dx - 45, center.dy + 25);
    bellPath.lineTo(center.dx + 45, center.dy + 25);
    bellPath.lineTo(center.dx + 55, center.dy + 15);
    bellPath.quadraticBezierTo(
      center.dx + 55,
      center.dy - 45,
      center.dx,
      center.dy - 45,
    );

    // Gradient fill
    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [primaryColor, primaryColor.withOpacity(0.8), secondaryColor],
      stops: const [0.0, 0.5, 1.0],
    );

    final bellPaint = Paint()
      ..shader = gradient.createShader(
        Rect.fromCenter(center: center, width: 120, height: 120),
      )
      ..style = PaintingStyle.fill;

    canvas.drawPath(bellPath, bellPaint);

    // Outline
    final outlinePaint = Paint()
      ..color = primaryColor.withOpacity(isDark ? 0.8 : 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(bellPath, outlinePaint);
  }

  void _drawBellRim(Canvas canvas, Offset center) {
    final rimPaint = Paint()
      ..shader =
          LinearGradient(
            colors: [primaryColor.withOpacity(0.9), secondaryColor],
          ).createShader(
            Rect.fromCenter(
              center: Offset(center.dx, center.dy + 25),
              width: 90,
              height: 10,
            ),
          )
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(center.dx, center.dy + 25),
          width: 90,
          height: 10,
        ),
        const Radius.circular(5),
      ),
      rimPaint,
    );
  }

  void _drawClapper(Canvas canvas, Offset center) {
    // Clapper string
    final stringPaint = Paint()
      ..color = secondaryColor.withOpacity(0.6)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(center.dx, center.dy - 10),
      Offset(center.dx, center.dy + 20),
      stringPaint,
    );

    // Clapper ball with gradient
    final clapperGradient = RadialGradient(
      colors: [
        secondaryColor.withOpacity(0.9),
        secondaryColor.withOpacity(0.6),
      ],
    );

    final clapperPaint = Paint()
      ..shader = clapperGradient.createShader(
        Rect.fromCircle(center: Offset(center.dx, center.dy + 20), radius: 8),
      );

    canvas.drawCircle(Offset(center.dx, center.dy + 20), 8, clapperPaint);

    // Clapper highlight
    final highlightPaint = Paint()..color = Colors.white.withOpacity(0.6);
    canvas.drawCircle(Offset(center.dx - 2, center.dy + 18), 3, highlightPaint);
  }

  void _drawHighlights(Canvas canvas, Offset center) {
    final highlightPaint = Paint()
      ..color = Colors.white.withOpacity(isDark ? 0.3 : 0.5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    // Left highlight
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(center.dx - 20, center.dy - 15),
        width: 30,
        height: 50,
      ),
      highlightPaint,
    );

    // Top highlight
    canvas.drawCircle(Offset(center.dx + 3, center.dy - 35), 8, highlightPaint);
  }

  void _drawShimmer(Canvas canvas, Offset center, Size size) {
    final shimmerPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.transparent,
          Colors.white.withOpacity(0.3),
          Colors.transparent,
        ],
        stops: [shimmerValue - 0.3, shimmerValue, shimmerValue + 0.3],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..blendMode = BlendMode.overlay;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), shimmerPaint);
  }

  void _drawSoundWaves(Canvas canvas, Offset center) {
    for (int i = 0; i < 3; i++) {
      final wavePaint = Paint()
        ..color = primaryColor.withOpacity(0.15 - (i * 0.04))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3;

      final radius = 70.0 + (i * 20);

      // Left wave
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi * 0.8,
        math.pi * 0.6,
        false,
        wavePaint,
      );

      // Right wave
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        math.pi * 0.2,
        math.pi * 0.6,
        false,
        wavePaint,
      );
    }
  }

  @override
  bool shouldRepaint(Enhanced3DBellPainter oldDelegate) {
    return shimmerValue != oldDelegate.shimmerValue;
  }
}
