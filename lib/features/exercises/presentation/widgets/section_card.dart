import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';

// class SectionCard extends StatelessWidget {
//   final dynamic section;
//   final VoidCallback onTap;
//
//   const SectionCard({super.key, required this.section, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(20.r),
//         child: Container(
//           decoration: BoxDecoration(
//             color: isDark ? ColorsManager.darkSurface : Colors.white,
//             borderRadius: BorderRadius.circular(20.r),
//             border: Border.all(
//               color: isDark
//                   ? ColorsManager.darkBorder.withValues(alpha: 0.3)
//                   : ColorsManager.lightBorder.withValues(alpha: 0.5),
//               width: 1.5,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: isDark
//                     ? Colors.black.withValues(alpha: 0.4)
//                     : ColorsManager.getPrimaryGreen(
//                         context,
//                       ).withValues(alpha: 0.08),
//                 blurRadius: isDark ? 12 : 20,
//                 offset: Offset(0, isDark ? 4 : 8),
//                 spreadRadius: isDark ? 0 : -2,
//               ),
//               if (isDark)
//                 BoxShadow(
//                   color: ColorsManager.darkPrimaryGreen.withValues(alpha: 0.1),
//                   blurRadius: 20,
//                   offset: const Offset(0, 0),
//                 ),
//             ],
//           ),
//           child: Stack(
//             children: [
//               Positioned.fill(
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(20.r),
//                   child: CustomPaint(
//                     painter: _ModernPatternPainter(
//                       isDark: isDark,
//                       color: ColorsManager.getPrimaryGreen(context),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: -20,
//                 right: -20,
//                 child: Container(
//                   width: 80,
//                   height: 80,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     gradient: RadialGradient(
//                       colors: [
//                         ColorsManager.getPrimaryGreen(
//                           context,
//                         ).withValues(alpha: isDark ? 0.15 : 0.08),
//                         Colors.transparent,
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(16.w),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildIconBadge(context, isDark),
//                     SizedBox(height: 16.h),
//                     _buildTitle(context, isDark),
//                     if (section.description != null) ...[
//                       SizedBox(height: 6.h),
//                       _buildDescription(context, isDark),
//                     ],
//                     const Spacer(),
//                     _buildBottomRow(context, isDark),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildIconBadge(BuildContext context, bool isDark) {
//     return Container(
//       padding: EdgeInsets.all(12.w),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: isDark
//               ? [
//                   ColorsManager.darkPrimaryGreen,
//                   ColorsManager.darkSecondaryGreen,
//                 ]
//               : [ColorsManager.primaryGreen, ColorsManager.secondaryGreen],
//         ),
//         borderRadius: BorderRadius.circular(14.r),
//         boxShadow: [
//           BoxShadow(
//             color: ColorsManager.getPrimaryGreen(
//               context,
//             ).withValues(alpha: isDark ? 0.4 : 0.3),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Icon(
//         _getSectionIcon(),
//         color: isDark ? ColorsManager.darkScaffold : Colors.white,
//         size: 28.sp,
//       ),
//     );
//   }
//
//   Widget _buildTitle(BuildContext context, bool isDark) {
//     return Text(
//       section.name ?? '',
//       style: TextStyle(
//         fontSize: 16.sp,
//         fontWeight: FontWeight.bold,
//         color: ColorsManager.getPrimaryText(context),
//         height: 1.2,
//       ),
//       maxLines: 2,
//       overflow: TextOverflow.ellipsis,
//     );
//   }
//
//   Widget _buildDescription(BuildContext context, bool isDark) {
//     return Text(
//       section.description ?? '',
//       style: TextStyle(
//         fontSize: 11.sp,
//         color: ColorsManager.getSecondaryText(context).withValues(alpha: 0.8),
//         height: 1.3,
//       ),
//       maxLines: 2,
//       overflow: TextOverflow.ellipsis,
//     );
//   }
//
//   Widget _buildBottomRow(BuildContext context, bool isDark) {
//     return Row(
//       children: [
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
//           decoration: BoxDecoration(
//             color: ColorsManager.getPrimaryGreen(
//               context,
//             ).withValues(alpha: isDark ? 0.2 : 0.1),
//             borderRadius: BorderRadius.circular(8.r),
//             border: Border.all(
//               color: ColorsManager.getPrimaryGreen(
//                 context,
//               ).withValues(alpha: 0.3),
//               width: 1,
//             ),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(
//                 Icons.fitness_center,
//                 color: ColorsManager.getPrimaryGreen(context),
//                 size: 12.sp,
//               ),
//               SizedBox(width: 4.w),
//               Text(
//                 section.allExerciseNumber.toString(),
//                 style: TextStyle(
//                   color: ColorsManager.getPrimaryGreen(context),
//                   fontWeight: FontWeight.bold,
//                   fontSize: 12.sp,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const Spacer(),
//         Container(
//           padding: EdgeInsets.all(6.w),
//           decoration: BoxDecoration(
//             color: ColorsManager.getPrimaryGreen(
//               context,
//             ).withValues(alpha: isDark ? 0.15 : 0.08),
//             shape: BoxShape.circle,
//           ),
//           child: Icon(
//             Icons.arrow_forward,
//             color: ColorsManager.getPrimaryGreen(context),
//             size: 16.sp,
//           ),
//         ),
//       ],
//     );
//   }
//
//   IconData _getSectionIcon() {
//     final name = section.name?.toLowerCase() ?? '';
//
//     if (name.contains('chest')) return Icons.fitness_center;
//     if (name.contains('back')) return Icons.accessibility_new;
//     if (name.contains('leg')) return Icons.directions_run;
//     if (name.contains('arm')) return Icons.sports_martial_arts;
//     if (name.contains('shoulder')) return Icons.sports_gymnastics;
//     if (name.contains('core') || name.contains('abs')) return Icons.spa;
//     if (name.contains('cardio')) return Icons.favorite;
//
//     return Icons.fitness_center;
//   }
// }
//
// class _ModernPatternPainter extends CustomPainter {
//   final bool isDark;
//   final Color color;
//
//   const _ModernPatternPainter({required this.isDark, required this.color});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = color.withValues(alpha: isDark ? 0.03 : 0.02)
//       ..style = PaintingStyle.fill;
//
//     final dotPaint = Paint()
//       ..color = color.withValues(alpha: isDark ? 0.05 : 0.04)
//       ..style = PaintingStyle.fill;
//
//     for (double x = 0; x < size.width; x += 25) {
//       for (double y = 0; y < size.height; y += 25) {
//         canvas.drawCircle(Offset(x, y), 2, dotPaint);
//       }
//     }
//
//     final gradientPaint = Paint()
//       ..shader = RadialGradient(
//         center: const Alignment(0.8, -0.8),
//         radius: 1.5,
//         colors: [
//           color.withValues(alpha: isDark ? 0.08 : 0.05),
//           Colors.transparent,
//         ],
//       ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
//
//     canvas.drawRect(
//       Rect.fromLTWH(0, 0, size.width, size.height),
//       gradientPaint,
//     );
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
class SectionCard extends StatefulWidget {
  final dynamic section;
  final VoidCallback onTap;

  const SectionCard({super.key, required this.section, required this.onTap});

  @override
  State<SectionCard> createState() => _SectionCardState();
}

class _SectionCardState extends State<SectionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? ColorsManager.darkSurface : Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: isDark
                  ? ColorsManager.darkBorder.withValues(alpha: 0.3)
                  : ColorsManager.lightBorder.withValues(alpha: 0.5),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withValues(alpha: 0.4)
                    : ColorsManager.getPrimaryGreen(
                        context,
                      ).withValues(alpha: 0.08),
                blurRadius: isDark ? 12 : 20,
                offset: Offset(0, isDark ? 4 : 8),
                spreadRadius: isDark ? 0 : -2,
              ),
              if (isDark)
                BoxShadow(
                  color: ColorsManager.darkPrimaryGreen.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 0),
                ),
            ],
          ),
          child: Stack(
            children: [
              // ✅ Animated Pattern Background
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return CustomPaint(
                        painter: _AnimatedPatternPainter(
                          isDark: isDark,
                          color: ColorsManager.getPrimaryGreen(context),
                          animation: _animationController.value,
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Gradient Orb
              Positioned(
                top: -20,
                right: -20,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        ColorsManager.getPrimaryGreen(
                          context,
                        ).withValues(alpha: isDark ? 0.15 : 0.08),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              // Content
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildIconBadge(context, isDark),
                    SizedBox(height: 16.h),
                    _buildTitle(context, isDark),
                    if (widget.section.description != null) ...[
                      SizedBox(height: 6.h),
                      _buildDescription(context, isDark),
                    ],
                    const Spacer(),
                    _buildBottomRow(context, isDark),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconBadge(BuildContext context, bool isDark) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  ColorsManager.darkPrimaryGreen,
                  ColorsManager.darkSecondaryGreen,
                ]
              : [ColorsManager.primaryGreen, ColorsManager.secondaryGreen],
        ),
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.getPrimaryGreen(
              context,
            ).withValues(alpha: isDark ? 0.4 : 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        _getSectionIcon(),
        color: isDark ? ColorsManager.darkScaffold : Colors.white,
        size: 28.sp,
      ),
    );
  }

  Widget _buildTitle(BuildContext context, bool isDark) {
    return Text(
      widget.section.name ?? '',
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: ColorsManager.getPrimaryText(context),
        height: 1.2,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildDescription(BuildContext context, bool isDark) {
    return Text(
      widget.section.description ?? '',
      style: TextStyle(
        fontSize: 11.sp,
        color: ColorsManager.getSecondaryText(context).withValues(alpha: 0.8),
        height: 1.3,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildBottomRow(BuildContext context, bool isDark) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: ColorsManager.getPrimaryGreen(
              context,
            ).withValues(alpha: isDark ? 0.2 : 0.1),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: ColorsManager.getPrimaryGreen(
                context,
              ).withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.fitness_center,
                color: ColorsManager.getPrimaryGreen(context),
                size: 12.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                widget.section.allExerciseNumber.toString(),
                style: TextStyle(
                  color: ColorsManager.getPrimaryGreen(context),
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Container(
          padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: ColorsManager.getPrimaryGreen(
              context,
            ).withValues(alpha: isDark ? 0.15 : 0.08),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.arrow_forward,
            color: ColorsManager.getPrimaryGreen(context),
            size: 16.sp,
          ),
        ),
      ],
    );
  }

  IconData _getSectionIcon() {
    final name = widget.section.name?.toLowerCase() ?? '';
    if (name.contains('chest')) return Icons.fitness_center;
    if (name.contains('back')) return Icons.accessibility_new;
    if (name.contains('leg')) return Icons.directions_run;
    if (name.contains('arm')) return Icons.sports_martial_arts;
    if (name.contains('shoulder')) return Icons.sports_gymnastics;
    if (name.contains('core') || name.contains('abs')) return Icons.spa;
    if (name.contains('cardio')) return Icons.favorite;
    return Icons.fitness_center;
  }
}

// ✅ ANIMATED PATTERN PAINTER WITH FLOATING DOTS
// ✅ ANIMATED PATTERN PAINTER WITH CLEARLY VISIBLE FLOATING DOTS
class _AnimatedPatternPainter extends CustomPainter {
  final bool isDark;
  final Color color;
  final double animation;

  const _AnimatedPatternPainter({
    required this.isDark,
    required this.color,
    required this.animation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final dotPaint = Paint()
      ..color = color.withValues(alpha: isDark ? 0.08 : 0.06)
      ..style = PaintingStyle.fill;

    // ✅ Animated floating dots with BIGGER motion
    for (double x = 0; x < size.width; x += 35) {
      for (double y = 0; y < size.height; y += 35) {
        // Calculate animated offset with LARGER amplitude
        final offsetX =
            math.sin((y / 15) + (animation * math.pi * 2)) *
            8; // ✅ Increased from 3 to 8
        final offsetY =
            math.cos((x / 15) + (animation * math.pi * 2)) *
            8; // ✅ Increased from 3 to 8

        // Pulsating size - MORE visible
        final pulseSize =
            2.5 +
            (math.sin((x + y + animation * math.pi * 4) / 8) *
                1.2); // ✅ Bigger range

        // Add slight opacity pulsation
        final alphaPulse =
            (isDark ? 0.08 : 0.06) +
            (math.sin((x + y + animation * math.pi * 3) / 10) * 0.03);

        final animatedPaint = Paint()
          ..color = color.withValues(alpha: alphaPulse)
          ..style = PaintingStyle.fill;

        canvas.drawCircle(
          Offset(x + offsetX, y + offsetY),
          pulseSize,
          animatedPaint,
        );
      }
    }

    // Gradient overlay
    final gradientPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.8, -0.8),
        radius: 1.5,
        colors: [
          color.withValues(alpha: isDark ? 0.08 : 0.05),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      gradientPaint,
    );
  }

  @override
  bool shouldRepaint(_AnimatedPatternPainter oldDelegate) {
    return oldDelegate.animation != animation;
  }
}
