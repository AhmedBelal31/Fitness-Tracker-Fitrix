import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/section_model.dart';

class SectionCard extends StatelessWidget {
  final SectionModel section;
  final VoidCallback onTap;

  const SectionCard({required this.section, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        decoration: BoxDecoration(
          gradient: ColorsManager.cardGradient,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: ColorsManager.cardShadow,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getIconData(section.iconName),
                size: 40.sp,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 12.h),

            // Section Name (Localized)
            Text(
              _getSectionName(s, section.name),
              style: TextStyles.font18WhiteMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.h),

            // Exercise Count
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                '${section.exerciseCount} ${s.exercises}',
                style: TextStyles.font12WhiteRegular,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getSectionName(S s, String sectionName) {
    switch (sectionName.toLowerCase()) {
      case 'chest':
        return s.chest;
      case 'back':
        return s.back;
      case 'legs':
        return s.legs;
      case 'shoulders':
        return s.shoulders;
      case 'arms':
        return s.arms;
      case 'core':
        return s.core;
      default:
        return sectionName;
    }
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'fitness_center':
        return Icons.fitness_center;
      case 'accessibility_new':
        return Icons.accessibility_new;
      case 'directions_run':
        return Icons.directions_run;
      case 'sports_martial_arts':
        return Icons.sports_martial_arts;
      case 'sports_gymnastics':
        return Icons.sports_gymnastics;
      case 'self_improvement':
        return Icons.self_improvement;
      default:
        return Icons.fitness_center;
    }
  }
}
