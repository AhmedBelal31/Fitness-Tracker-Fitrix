import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../generated/l10n.dart';
import 'animated_icon_widget.dart';
import 'exercise_helpers.dart';

// class SectionAppBar extends StatelessWidget {
//   final String sectionName;
//   final bool isAddingToWorkout;
//   final TickerProvider vsync;
//
//   const SectionAppBar({
//     super.key,
//     required this.sectionName,
//     required this.isAddingToWorkout,
//     required this.vsync,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//
//     return SliverAppBar(
//       expandedHeight: 220.h,
//       pinned: true,
//       backgroundColor: ColorsManager.primaryGreen,
//       leading: IconButton(
//         onPressed: () => Navigator.pop(context),
//         icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//       ),
//       flexibleSpace: FlexibleSpaceBar(
//         title: TweenAnimationBuilder<double>(
//           tween: Tween(begin: 0.0, end: 1.0),
//           duration: const Duration(milliseconds: 600),
//           curve: Curves.easeOut,
//           builder: (context, value, child) {
//             return Opacity(
//               opacity: value,
//               child: Transform.translate(
//                 offset: Offset(0, 10 * (1 - value)),
//                 child: child,
//               ),
//             );
//           },
//           child: Text(
//             isAddingToWorkout
//                 ? '${s.add_exercise} - $sectionName'
//                 : sectionName,
//             style: TextStyles.font16WhiteRegular,
//             textAlign: TextAlign.center,
//           ),
//         ),
//         background: _buildBackground(context, s),
//       ),
//     );
//   }
//
//   Widget _buildBackground(BuildContext context, S s) {
//     return Stack(
//       children: [
//         Container(
//           decoration: const BoxDecoration(
//             gradient: ColorsManager.appBarBackgroundGradient,
//           ),
//         ),
//         Positioned.fill(child: CustomPaint(painter: _AppBarPatternPainter())),
//         _buildFloatingCircles(),
//         _buildMainContent(s),
//       ],
//     );
//   }
//
//   Widget _buildFloatingCircles() {
//     return Stack(
//       children: [
//         _buildCircle(
//           top: 40.h,
//           right: 30.w,
//           size: 100.w,
//           duration: 1200,
//           offset: Offset(20, -20),
//         ),
//         _buildCircle(
//           bottom: 30.h,
//           left: 20.w,
//           size: 120.w,
//           duration: 1500,
//           offset: Offset(-10, 30),
//         ),
//         _buildCircle(
//           top: 100.h,
//           left: 50.w,
//           size: 80.w,
//           duration: 1800,
//           offset: Offset(-15, 15),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildCircle({
//     double? top,
//     double? bottom,
//     double? left,
//     double? right,
//     required double size,
//     required int duration,
//     required Offset offset,
//   }) {
//     return TweenAnimationBuilder<double>(
//       tween: Tween(begin: 0.0, end: 1.0),
//       duration: Duration(milliseconds: duration),
//       curve: Curves.easeOutCubic,
//       builder: (context, value, child) {
//         return Positioned(
//           top: top != null ? top + offset.dy * value : null,
//           bottom: bottom != null ? bottom + offset.dy * value : null,
//           left: left != null ? left + offset.dx * value : null,
//           right: right != null ? right + offset.dx * value : null,
//           child: Opacity(
//             opacity: 0.1 * value,
//             child: Container(
//               width: size,
//               height: size,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.white.withValues(alpha: 0.2),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildMainContent(S s) {
//     return TweenAnimationBuilder<double>(
//       tween: Tween(begin: 0.0, end: 1.0),
//       duration: const Duration(milliseconds: 1000),
//       curve: Curves.easeOutCubic,
//       builder: (context, value, child) {
//         return Transform.scale(
//           scale: 0.85 + (value * 0.15),
//           child: Opacity(opacity: value.clamp(0.0, 1.0), child: child),
//         );
//       },
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(height: 50.h),
//             AnimatedIconWidget(
//               isAddingToWorkout: isAddingToWorkout,
//               vsync: vsync,
//             ),
//             SizedBox(height: 16.h),
//             _buildSubtitle(s),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSubtitle(S s) {
//     return TweenAnimationBuilder<double>(
//       tween: Tween(begin: 0.0, end: 1.0),
//       duration: const Duration(milliseconds: 900),
//       curve: Curves.easeOut,
//       builder: (context, value, child) {
//         return Opacity(
//           opacity: value.clamp(0.0, 1.0),
//           child: Transform.translate(
//             offset: Offset(0, 20 * (1 - value)),
//             child: child,
//           ),
//         );
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
//         decoration: BoxDecoration(
//           color: Colors.white.withValues(alpha: 0.1),
//           borderRadius: BorderRadius.circular(20.r),
//         ),
//         child: Text(
//           isAddingToWorkout
//               ? s.tap_to_add_exercise
//               : ExerciseHelpers.getSectionDescription(s, sectionName),
//           style: TextStyles.font14WhiteMedium,
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
// }
//
// class _AppBarPatternPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.white.withValues(alpha: 0.03)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1.5;
//
//     for (double i = -size.height; i < size.width + size.height; i += 25) {
//       canvas.drawLine(
//         Offset(i, 0),
//         Offset(i + size.height, size.height),
//         paint,
//       );
//     }
//
//     final dotPaint = Paint()
//       ..color = Colors.white.withValues(alpha: 0.05)
//       ..style = PaintingStyle.fill;
//
//     for (double x = 0; x < size.width; x += 40) {
//       for (double y = 0; y < size.height; y += 40) {
//         canvas.drawCircle(Offset(x + 20, y + 20), 2, dotPaint);
//       }
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
class SectionAppBar extends StatefulWidget {
  final String sectionName;
  final bool isAddingToWorkout;
  final TickerProvider vsync;

  const SectionAppBar({
    super.key,
    required this.sectionName,
    required this.isAddingToWorkout,
    required this.vsync,
  });

  @override
  State<SectionAppBar> createState() => _SectionAppBarState();
}

class _SectionAppBarState extends State<SectionAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SliverAppBar(
      expandedHeight: 240.h,
      pinned: true,
      backgroundColor: ColorsManager.getPrimaryGreen(context),
      leading: _buildBackButton(isDark),
      flexibleSpace: FlexibleSpaceBar(
        title: _buildAnimatedTitle(s, isDark),
        titlePadding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
        background: _buildBackground(context, s, isDark),
      ),
    );
  }

  Widget _buildBackButton(bool isDark) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.elasticOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value.clamp(0.0, 1.0),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: (isDark ? ColorsManager.darkScaffold : Colors.white)
                    .withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: isDark ? ColorsManager.darkScaffold : Colors.white,
                size: 18.sp,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedTitle(S s, bool isDark) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 15 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Text(
        widget.isAddingToWorkout
            ? '${s.add_exercise} - ${widget.sectionName}'
            : widget.sectionName,
        style: GoogleFonts.aBeeZee(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: isDark
              ? ColorsManager.darkScaffold.withValues(alpha: .7)
              : Colors.white,
          shadows: [
            Shadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildBackground(BuildContext context, S s, bool isDark) {
    return Stack(
      children: [
        _buildGradientBackground(isDark),
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _waveController,
            builder: (context, child) {
              return CustomPaint(
                painter: _ModernAppBarPainter(
                  isDark: isDark,
                  animation: _waveController.value,
                ),
              );
            },
          ),
        ),
        _buildFloatingShapes(isDark),
        _buildParticles(isDark),
        _buildMainContent(s, isDark),
      ],
    );
  }

  Widget _buildGradientBackground(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        gradient: isDark
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ColorsManager.darkPrimaryGreen,
                  ColorsManager.darkSecondaryGreen,
                  ColorsManager.darkPrimaryGreen.withValues(alpha: 0.8),
                ],
                stops: const [0.0, 0.5, 1.0],
              )
            : LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ColorsManager.primaryGreen,
                  ColorsManager.secondaryGreen,
                  ColorsManager.primaryGreen.withValues(alpha: 0.8),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
      ),
    );
  }

  Widget _buildFloatingShapes(bool isDark) {
    return Stack(
      children: [
        _buildAnimatedShape(
          top: 30.h,
          right: 20.w,
          size: 120.w,
          duration: 2000,
          delay: 0,
          isDark: isDark,
        ),
        _buildAnimatedShape(
          top: 120.h,
          left: 30.w,
          size: 80.w,
          duration: 2500,
          delay: 300,
          isDark: isDark,
        ),
        _buildAnimatedShape(
          bottom: 40.h,
          right: 50.w,
          size: 100.w,
          duration: 2200,
          delay: 600,
          isDark: isDark,
        ),
      ],
    );
  }

  Widget _buildAnimatedShape({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required double size,
    required int duration,
    required int delay,
    required bool isDark,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: duration),
      curve: Curves.easeInOutSine,
      builder: (context, value, child) {
        final yOffset = math.sin(value * 2 * math.pi) * 20;
        final rotation = value * 2 * math.pi;

        return Positioned(
          top: top != null ? top + yOffset : null,
          bottom: bottom != null ? bottom - yOffset : null,
          left: left,
          right: right,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(milliseconds: 800 + delay),
            curve: Curves.easeOut,
            builder: (context, fadeValue, _) {
              return Opacity(
                opacity: (0.08 * fadeValue).clamp(0.0, 1.0),
                child: Transform.rotate(
                  angle: rotation,
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          (isDark ? ColorsManager.darkScaffold : Colors.white)
                              .withValues(alpha: 0.3),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildParticles(bool isDark) {
    return Stack(
      children: List.generate(12, (index) {
        final angle = (index * 30.0) * math.pi / 180;
        final radius = 150.w;

        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 1500 + (index * 100)),
          curve: Curves.easeOut,
          builder: (context, value, child) {
            final xOffset = math.cos(angle) * radius * value;
            final yOffset = math.sin(angle) * radius * value;

            return Positioned(
              left: MediaQuery.of(context).size.width / 2 + xOffset - 3.w,
              top: 120.h + yOffset - 3.w,
              child: Opacity(
                opacity: (1 - value).clamp(0.0, 0.6),
                child: Container(
                  width: 6.w,
                  height: 6.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDark ? ColorsManager.darkScaffold : Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color:
                            (isDark ? ColorsManager.darkScaffold : Colors.white)
                                .withValues(alpha: 0.6),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildMainContent(S s, bool isDark) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.7 + (value * 0.3),
          child: Opacity(opacity: value.clamp(0.0, 1.0), child: child),
        );
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40.h),
            _buildCenterIcon(isDark),
            SizedBox(height: 20.h),
            _buildSubtitle(s, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterIcon(bool isDark) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1500),
      curve: Curves.elasticOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value.clamp(0.0, 1.0),
          child: Transform.rotate(
            angle: (1 - value) * math.pi * 2,
            child: child,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (isDark ? ColorsManager.darkScaffold : Colors.white)
              .withValues(alpha: 0.2),
          boxShadow: [
            BoxShadow(
              color: (isDark ? ColorsManager.darkScaffold : Colors.white)
                  .withValues(alpha: 0.3),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Icon(
          widget.isAddingToWorkout ? Icons.add_circle : Icons.fitness_center,
          size: 48.sp,
          color: isDark ? ColorsManager.darkScaffold : Colors.white,
        ),
      ),
    );
  }

  Widget _buildSubtitle(S s, bool isDark) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 40.w),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: (isDark ? ColorsManager.darkScaffold : Colors.white)
              .withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(25.r),
          border: Border.all(
            color: (isDark ? ColorsManager.darkScaffold : Colors.white)
                .withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Text(
          widget.isAddingToWorkout
              ? s.tap_to_add_exercise
              : ExerciseHelpers.getSectionDescription(s, widget.sectionName),
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: isDark ? ColorsManager.darkScaffold : Colors.white,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),
    );
  }
}

// ✨ STUNNING CUSTOM PAINTER WITH WAVES AND PATTERNS
class _ModernAppBarPainter extends CustomPainter {
  final bool isDark;
  final double animation;

  const _ModernAppBarPainter({required this.isDark, required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final baseColor = isDark ? ColorsManager.darkScaffold : Colors.white;

    // Wave pattern
    _paintWaves(canvas, size, baseColor);

    // Geometric grid
    _paintGrid(canvas, size, baseColor);

    // Floating dots
    _paintDots(canvas, size, baseColor);

    // Curved lines
    _paintCurvedLines(canvas, size, baseColor);
  }

  void _paintWaves(Canvas canvas, Size size, Color baseColor) {
    final paint = Paint()
      ..color = baseColor.withValues(alpha: 0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (int i = 0; i < 3; i++) {
      final path = Path();
      final waveHeight = 20.0 + (i * 10);
      final offset = animation * size.width * 2;

      for (double x = -size.width; x < size.width * 2; x += 10) {
        final y =
            size.height / 2 +
            math.sin((x + offset) / 50 + (i * 0.5)) * waveHeight;
        if (x == -size.width) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }

      canvas.drawPath(path, paint);
    }
  }

  void _paintGrid(Canvas canvas, Size size, Color baseColor) {
    final paint = Paint()
      ..color = baseColor.withValues(alpha: 0.03)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (double x = 0; x < size.width; x += 50) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y < size.height; y += 50) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  void _paintDots(Canvas canvas, Size size, Color baseColor) {
    final paint = Paint()
      ..color = baseColor.withValues(alpha: 0.08)
      ..style = PaintingStyle.fill;

    for (double x = 25; x < size.width; x += 60) {
      for (double y = 25; y < size.height; y += 60) {
        final offset = math.sin(animation * 2 * math.pi + x / 30) * 3;
        canvas.drawCircle(Offset(x, y + offset), 2.5, paint);
      }
    }
  }

  void _paintCurvedLines(Canvas canvas, Size size, Color baseColor) {
    final paint = Paint()
      ..color = baseColor.withValues(alpha: 0.06)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final path = Path();
    path.moveTo(0, size.height * 0.7);

    for (double x = 0; x < size.width; x += 50) {
      final y = size.height * 0.7 + math.sin((x + animation * 200) / 80) * 30;
      path.quadraticBezierTo(x + 25, y - 15, x + 50, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _ModernAppBarPainter oldDelegate) {
    return animation != oldDelegate.animation;
  }
}
