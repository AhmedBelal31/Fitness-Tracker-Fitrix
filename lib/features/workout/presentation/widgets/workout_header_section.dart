import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/workout_session_entity.dart';
import 'dart:math' as math;

class WorkoutHeaderSection extends SliverPersistentHeaderDelegate {
  final WorkoutSessionEntity workout;
  final Animation<double> animation;

  WorkoutHeaderSection({required this.workout, required this.animation});
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progress = shrinkOffset / maxExtent;
    final isCollapsed = progress > 0.5; // ✅ Collapsed threshold

    return Stack(
      fit: StackFit.expand,
      children: [
        // Background - Simple when collapsed
        if (isCollapsed)
          // ✅ Flat background when collapsed
          Container(color: ColorsManager.getSecondaryGreen(context))
        else
          // ✅ Animated background when expanded
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return CustomPaint(
                painter: WorkoutHeaderPainter(
                  progress: animation.value,
                  shrinkProgress: progress,
                  isDark: isDark,
                  isCompleted: workout.isCompleted,
                ),
              );
            },
          ),

        // Content
        ClipRect(
          child: Stack(
            children: [
              // Expanded content (animated)
              if (!isCollapsed)
                Align(
                  alignment: Alignment.center,
                  child: Opacity(
                    opacity: 1 - (progress * 2),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.scale(
                          scale: math.max(0.5, 1 - progress),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ...List.generate(3, (index) {
                                return Transform.rotate(
                                  angle:
                                      animation.value *
                                      math.pi *
                                      2 *
                                      (index + 1),
                                  child: Container(
                                    width: 80.w - (index * 15),
                                    height: 80.w - (index * 15),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white.withValues(
                                          alpha: 0.1 - (index * 0.03),
                                        ),
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                              Container(
                                padding: EdgeInsets.all(16.w),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(
                                    colors: [
                                      Colors.white.withValues(alpha: 0.3),
                                      Colors.white.withValues(alpha: 0.1),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withValues(
                                        alpha: 0.3,
                                      ),
                                      blurRadius: 30,
                                      spreadRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  workout.isCompleted
                                      ? Icons.emoji_events
                                      : Icons.fitness_center,
                                  size: 32.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text(
                            DateFormat('EEE, MMM d').format(workout.date),
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              if (isCollapsed)
                Positioned(
                  top: MediaQuery.of(context).padding.top,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Opacity(
                    opacity: math.min(1.0, (progress - 0.5) * 2),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 60.w),
                        child: Text(
                          S.of(context).workout_details,
                          style: GoogleFonts.aBeeZee(
                            fontSize: 20.sp,
                            color: Colors.black.withValues(alpha: .8),
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),

        // Back button
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          left: 16.w,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 280.h;

  @override
  double get minExtent => 120.h;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

// Custom Painter with stunning effects
// Custom Painter with advanced 3D-like effects
class WorkoutHeaderPainter extends CustomPainter {
  final double progress;
  final double shrinkProgress;
  final bool isDark;
  final bool isCompleted;

  WorkoutHeaderPainter({
    required this.progress,
    required this.shrinkProgress,
    required this.isDark,
    required this.isCompleted,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Animated mesh gradient base
    _drawMeshGradient(canvas, size);

    // 2. Organic blob shapes
    _drawOrganicBlobs(canvas, size);

    // 3. Grid pattern overlay
    _drawAnimatedGrid(canvas, size);

    // 4. Liquid wave distortion
    _drawLiquidWave(canvas, size);

    // 5. Glowing orbs
    _drawGlowingOrbs(canvas, size);

    // 6. Noise texture overlay
    _drawNoiseTexture(canvas, size);
  }

  void _drawMeshGradient(Canvas canvas, Size size) {
    final colors = isDark
        ? [
            const Color(0xFF1A4D2E), // Deep forest
            ColorsManager.darkPrimaryGreen,
            const Color(0xFF0D2818), // Very dark green
            ColorsManager.darkSecondaryGreen,
            const Color(0xFF163920), // Mid dark
          ]
        : [
            const Color(0xFF2ECC71), // Bright green
            ColorsManager.primaryGreen,
            const Color(0xFF1E8449), // Dark green
            ColorsManager.secondaryGreen,
            const Color(0xFF27AE60), // Medium green
          ];

    // Create multiple radial gradients for mesh effect
    for (int i = 0; i < 5; i++) {
      final angle = (progress + (i * 0.2)) * math.pi * 2;
      final radius = size.width * (0.4 + (i * 0.15));
      final centerX = size.width * (0.5 + math.cos(angle) * 0.3);
      final centerY = size.height * (0.5 + math.sin(angle) * 0.3);

      final gradient = RadialGradient(
        center: Alignment(
          (centerX - size.width / 2) / (size.width / 2),
          (centerY - size.height / 2) / (size.height / 2),
        ),
        radius: 0.8,
        colors: [
          colors[i % colors.length].withValues(alpha: 0.6),
          colors[(i + 1) % colors.length].withValues(alpha: 0.3),
          Colors.transparent,
        ],
      );

      final paint = Paint()..shader = gradient.createShader(Offset.zero & size);
      canvas.drawRect(Offset.zero & size, paint);
    }
  }

  void _drawOrganicBlobs(Canvas canvas, Size size) {
    for (int i = 0; i < 4; i++) {
      final path = Path();
      final centerX = size.width * (0.3 + (i * 0.15));
      final centerY = size.height * (0.3 + math.sin(progress * math.pi + i));
      final baseRadius = size.width * 0.15;

      // Create blob with sine wave distortion
      for (double angle = 0; angle < math.pi * 2; angle += 0.1) {
        final distortion = math.sin(angle * 3 + progress * math.pi * 2) * 15;
        final radius = baseRadius + distortion;
        final x = centerX + math.cos(angle) * radius;
        final y = centerY + math.sin(angle) * radius;

        if (angle == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      path.close();

      final blobPaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.08 - (i * 0.015))
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30)
        ..style = PaintingStyle.fill;

      canvas.drawPath(path, blobPaint);
    }
  }

  void _drawAnimatedGrid(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final spacing = 40.0;
    final offset = (progress * spacing) % spacing;

    // Vertical lines
    for (double x = -spacing + offset; x < size.width + spacing; x += spacing) {
      final wavyPath = Path();
      for (double y = 0; y <= size.height; y += 2) {
        final wave = math.sin((y / 50) + (progress * math.pi * 2)) * 5;
        if (y == 0) {
          wavyPath.moveTo(x + wave, y);
        } else {
          wavyPath.lineTo(x + wave, y);
        }
      }
      canvas.drawPath(wavyPath, gridPaint);
    }

    // Horizontal lines
    for (
      double y = -spacing + offset;
      y < size.height + spacing;
      y += spacing
    ) {
      final wavyPath = Path();
      for (double x = 0; x <= size.width; x += 2) {
        final wave = math.sin((x / 50) + (progress * math.pi * 2)) * 5;
        if (x == 0) {
          wavyPath.moveTo(x, y + wave);
        } else {
          wavyPath.lineTo(x, y + wave);
        }
      }
      canvas.drawPath(wavyPath, gridPaint);
    }
  }

  void _drawLiquidWave(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.7);

    // Create complex wave with multiple frequencies
    for (double x = 0; x <= size.width; x += 2) {
      final wave1 =
          math.sin((x / size.width * math.pi * 2) + (progress * math.pi * 2)) *
          25;
      final wave2 =
          math.sin((x / size.width * math.pi * 4) + (progress * math.pi * 3)) *
          15;
      final wave3 =
          math.sin((x / size.width * math.pi * 6) + (progress * math.pi * 4)) *
          8;
      final combinedWave = wave1 + wave2 + wave3;

      path.lineTo(x, size.height * 0.7 + combinedWave);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    final wavePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withValues(alpha: 0.15),
          Colors.white.withValues(alpha: 0.05),
        ],
      ).createShader(Offset.zero & size)
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, wavePaint);
  }

  void _drawGlowingOrbs(Canvas canvas, Size size) {
    for (int i = 0; i < 8; i++) {
      final angle = (progress * 2 + (i * 0.25)) * math.pi * 2;
      final orbitRadius = size.width * (0.3 + (i % 2) * 0.15);
      final x = size.width * 0.5 + math.cos(angle) * orbitRadius;
      final y = size.height * 0.5 + math.sin(angle) * orbitRadius * 0.6;

      final orbPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            Colors.white.withValues(alpha: 0.4),
            Colors.white.withValues(alpha: 0.1),
            Colors.transparent,
          ],
        ).createShader(Rect.fromCircle(center: Offset(x, y), radius: 20))
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);

      canvas.drawCircle(Offset(x, y), 20, orbPaint);
    }
  }

  void _drawNoiseTexture(Canvas canvas, Size size) {
    final random = math.Random(42);
    final noisePaint = Paint()..color = Colors.white.withValues(alpha: 0.03);

    for (int i = 0; i < 200; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      canvas.drawCircle(Offset(x, y), 1, noisePaint);
    }
  }

  @override
  bool shouldRepaint(WorkoutHeaderPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.shrinkProgress != shrinkProgress;
}

// Wrapper widget to use in CustomScrollView
class WorkoutHeaderSectionWrapper extends StatefulWidget {
  final WorkoutSessionEntity workout;

  const WorkoutHeaderSectionWrapper({super.key, required this.workout});

  @override
  State<WorkoutHeaderSectionWrapper> createState() =>
      _WorkoutHeaderSectionWrapperState();
}

class _WorkoutHeaderSectionWrapperState
    extends State<WorkoutHeaderSectionWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: WorkoutHeaderSection(
        workout: widget.workout,
        animation: _controller,
      ),
    );
  }
}
