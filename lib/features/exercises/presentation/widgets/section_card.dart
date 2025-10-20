import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/section_model.dart';

// class SectionCard extends StatelessWidget {
//   final SectionModel section;
//   final VoidCallback onTap;
//
//   const SectionCard({required this.section, required this.onTap, super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(16.r),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: ColorsManager.cardGradient,
//           borderRadius: BorderRadius.circular(16.r),
//           boxShadow: ColorsManager.cardShadow,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Icon
//             Container(
//               padding: EdgeInsets.all(16.w),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.2),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 _getIconData(section.name),
//                 size: 40.sp,
//                 color: Colors.white,
//               ),
//             ),
//             SizedBox(height: 12.h),
//
//             // Section Name (Localized)
//             Text(
//               _getSectionName(s, section.name),
//               style: TextStyles.font18WhiteMedium,
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 4.h),
//
//             // Exercise Count
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(12.r),
//               ),
//               child: Text(
//                 '${section.allExerciseNumber} ${s.exercises}',
//                 style: TextStyles.font12WhiteRegular,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   String _getSectionName(S s, String sectionName) {
//     switch (sectionName.toLowerCase()) {
//       case 'chest':
//         return s.chest;
//       case 'back':
//         return s.back;
//       case 'legs':
//         return s.legs;
//       case 'shoulders':
//         return s.shoulders;
//       case 'arms':
//         return s.arms;
//       case 'core':
//         return s.core;
//       default:
//         return sectionName;
//     }
//   }
//
//   IconData _getIconData(String sectionName) {
//     switch (sectionName.toLowerCase()) {
//       case 'chest':
//         return Icons.fitness_center;
//       case 'back':
//         return Icons.accessibility_new;
//       case 'legs':
//         return Icons.directions_run;
//       case 'shoulders':
//         return Icons.sports_martial_arts;
//       case 'arms':
//         return Icons.sports_gymnastics;
//       case 'core':
//         return Icons.self_improvement;
//       default:
//         return Icons.fitness_center;
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';

class SectionCard extends StatelessWidget {
  final dynamic section;
  final VoidCallback onTap;

  const SectionCard({super.key, required this.section, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          decoration: BoxDecoration(
            gradient: ColorsManager.primaryGradient,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: ColorsManager.primaryGreen.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Background pattern
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: CustomPaint(painter: _PatternPainter()),
                ),
              ),
              // Main content
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildIcon(),
                    SizedBox(height: 12.h),
                    _buildTitle(),
                    if (section.description != null) ...[
                      SizedBox(height: 4.h),
                      _buildDescription(),
                    ],
                  ],
                ),
              ),
              // Exercise count badge (top-right)
              _buildExerciseCountBadge(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(
        _getSectionIcon(),
        color: ColorsManager.whiteText,
        size: 32.sp,
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      section.name ?? '',
      style: TextStyles.headline3.copyWith(
        color: ColorsManager.whiteText,
        fontSize: 16.sp,
      ),
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildDescription() {
    return Text(
      section.description ?? '',
      style: TextStyles.caption.copyWith(
        color: ColorsManager.whiteText.withValues(alpha: 0.8),
      ),
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildExerciseCountBadge() {
    return Positioned(
      top: 8.w,
      right: 8.w,
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 400),
        tween: Tween<double>(begin: 0, end: 1),
        curve: Curves.elasticOut,
        builder: (context, double value, child) {
          return Transform.scale(scale: value.clamp(0.0, 1.0), child: child);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.fitness_center,
                color: ColorsManager.primaryGreen,
                size: 14.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                section.allExerciseNumber.toString(),
                style: TextStyles.bodySmall.copyWith(
                  color: ColorsManager.primaryGreen,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getSectionIcon() {
    final name = section.name?.toLowerCase() ?? '';

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

class _PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Draw diagonal lines pattern
    for (double i = -size.height; i < size.width; i += 20) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
