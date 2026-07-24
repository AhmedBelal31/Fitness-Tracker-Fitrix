// lib/features/trainer/presentation/widgets/trainer_quick_actions.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/routing/routes.dart';

class TrainerQuickActions extends StatelessWidget {
  const TrainerQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).quick_actions,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: ColorsManager.getPrimaryText(context),
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _QuickActionCard(
                icon: Icons.person_add,
                label: S.of(context).find_clients,
                color: ColorsManager.getPrimaryGreen(context),
                onTap: () {
                  Navigator.pushNamed(context, Routes.trainerClients);
                },
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _QuickActionCard(
                icon: Icons.fitness_center,
                label: S.of(context).create_workout,
                color: ColorsManager.info,
                onTap: () {
                  // Navigate to workout creation
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: isDark ? 0.2 : 0.1),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32.sp),
            SizedBox(height: 8.h),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: ColorsManager.getPrimaryText(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
