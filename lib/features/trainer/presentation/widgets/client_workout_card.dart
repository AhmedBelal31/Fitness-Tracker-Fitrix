// lib/features/trainer/presentation/widgets/client_workout_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/trainee_data.dart';

class ClientWorkoutCard extends StatelessWidget {
  final TraineeData trainee;
  final VoidCallback onCreateWorkout;

  const ClientWorkoutCard({
    super.key,
    required this.trainee,
    required this.onCreateWorkout,
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
          onTap: onCreateWorkout,
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
                  backgroundImage:
                      trainee.image != null && trainee.image!.isNotEmpty
                      ? NetworkImage(trainee.image!)
                      : null,
                  child: trainee.image == null || trainee.image!.isEmpty
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
                        trainee.fullName ??
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
                            '${trainee.totalWorkouts ?? 0} ${S.of(context).workouts}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: ColorsManager.getSecondaryText(context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Create Button
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: ColorsManager.getPrimaryGreen(context),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.add, color: Colors.white, size: 20.sp),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
