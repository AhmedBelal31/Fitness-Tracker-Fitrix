// lib/features/trainer/presentation/widgets/trainee_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/trainee_data.dart';
import 'assign_workout_dialog.dart';

class TraineeCard extends StatelessWidget {
  final TraineeData trainee;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const TraineeCard({
    super.key,
    required this.trainee,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 30.r,
                  backgroundColor: ColorsManager.getPrimaryGreen(
                    context,
                  ).withValues(alpha: 0.2),
                  backgroundImage: trainee.image != null
                      ? NetworkImage(trainee.image!)
                      : null,
                  child: trainee.image == null
                      ? Text(
                          '${trainee.firstName[0]}${trainee.lastName[0]}'
                              .toUpperCase(),
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.getPrimaryGreen(context),
                          ),
                        )
                      : null,
                ),

                SizedBox(width: 16.w),

                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${trainee.firstName} ${trainee.lastName}',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.getPrimaryText(context),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.fitness_center,
                            size: 14.sp,
                            color: ColorsManager.getSecondaryText(context),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '${trainee.completedWorkouts ?? 0} ${S.of(context).workouts_completed}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: ColorsManager.getSecondaryText(context),
                            ),
                          ),
                        ],
                      ),
                      if (trainee.lastWorkoutDate != null) ...[
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 14.sp,
                              color: ColorsManager.getSecondaryText(context),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              _formatLastWorkout(trainee.lastWorkoutDate!),
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: ColorsManager.getSecondaryText(context),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),

                // Actions
                PopupMenuButton<String>(
                  icon: Icon(
                    Icons.more_vert,
                    color: ColorsManager.getSecondaryText(context),
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'view',
                      child: Row(
                        children: [
                          const Icon(Icons.visibility),
                          SizedBox(width: 8.w),
                          Text(S.of(context).view_details),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'workout',
                      child: Row(
                        children: [
                          const Icon(Icons.add_circle_outline),
                          SizedBox(width: 8.w),
                          Text(S.of(context).assign_workout),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'remove',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: ColorsManager.error),
                          SizedBox(width: 8.w),
                          Text(
                            S.of(context).remove,
                            style: TextStyle(color: ColorsManager.error),
                          ),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    switch (value) {
                      case 'view':
                        onTap();
                        break;
                      case 'workout':
                        _showAssignWorkoutDialog(context);
                        break;
                      case 'remove':
                        onRemove();
                        break;
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatLastWorkout(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _showAssignWorkoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AssignWorkoutDialog(traineeId: trainee.id),
    );
  }
}
