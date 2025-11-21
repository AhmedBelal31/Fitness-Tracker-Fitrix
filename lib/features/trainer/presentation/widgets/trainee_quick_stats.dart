// lib/features/trainer/presentation/widgets/trainee_quick_stats.dart
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/trainee_data.dart';

class TraineeQuickStats extends StatelessWidget {
  final TraineeData trainee;

  const TraineeQuickStats({super.key, required this.trainee});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.fitness_center,
            label: S.of(context).active_workouts,
            value: '${trainee.activeWorkouts ?? 0}',
            color: ColorsManager.getPrimaryGreen(context),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _StatCard(
            icon: Icons.check_circle,
            label: S.of(context).completed,
            value: '${trainee.completedWorkouts ?? 0}',
            color: ColorsManager.success,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _StatCard(
            icon: Icons.trending_up,
            label: S.of(context).records,
            value: '${trainee.profile?.personalRecordsCount ?? 0}',
            color: ColorsManager.warning,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28.sp),
          SizedBox(height: 8.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: ColorsManager.getPrimaryText(context),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.sp,
              color: ColorsManager.getSecondaryText(context),
            ),
          ),
        ],
      ),
    );
  }
}
