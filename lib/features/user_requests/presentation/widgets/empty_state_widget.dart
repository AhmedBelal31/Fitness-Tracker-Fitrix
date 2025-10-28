import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_colors.dart';
import 'dart:math' as math;

class EmptyStateWidget extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  State<EmptyStateWidget> createState() => _EmptyStateWidgetState();
}

class _EmptyStateWidgetState extends State<EmptyStateWidget>
    with TickerProviderStateMixin {
  late AnimationController _floatController;
  late AnimationController _particleController;
  late Animation<double> _floatAnimation;
  late Animation<double> _particleAnimation;
  final List<Particle> _particles = [];

  @override
  void initState() {
    super.initState();

    _floatController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -15, end: 15).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _particleController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();

    _particleAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_particleController);

    _initParticles();
  }

  void _initParticles() {
    final random = math.Random();
    for (int i = 0; i < 15; i++) {
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
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: Listenable.merge([
              _floatController,
              _particleController,
            ]),
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _floatAnimation.value),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Animated particles background
                    CustomPaint(
                      size: Size(200.w, 200.h),
                      painter: ParticlesPainter(
                        particles: _particles,
                        animationValue: _particleAnimation.value,
                        primaryColor: ColorsManager.getPrimaryGreen(context),
                      ),
                    ),
                    // Icon
                    Icon(
                      widget.icon,
                      size: 100.sp,
                      color: ColorsManager.getPrimaryGreen(
                        context,
                      ).withOpacity(0.3),
                    ),
                    // Glow effect
                    Container(
                      width: 120.w,
                      height: 120.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: ColorsManager.getPrimaryGreen(
                              context,
                            ).withOpacity(0.2),
                            blurRadius: 30,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 32.h),
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: ColorsManager.getPrimaryText(context),
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.w),
            child: Text(
              widget.subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: ColorsManager.getSecondaryText(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Particle model
class Particle {
  double x, y;
  final double size, speed, angle;

  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.angle,
  });
}

// Custom painter for animated particles
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
      // Calculate particle position based on animation progress
      final progress = (animationValue + particle.speed) % 1.0;
      final distance = progress * 80;

      final x = center.dx + particle.x + math.cos(particle.angle) * distance;
      final y = center.dy + particle.y + math.sin(particle.angle) * distance;

      // Fade out as particles move away from center
      final opacity = 1.0 - progress;
      paint.color = primaryColor.withOpacity(opacity * 0.4);

      canvas.drawCircle(Offset(x, y), particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(ParticlesPainter oldDelegate) => true;
}
