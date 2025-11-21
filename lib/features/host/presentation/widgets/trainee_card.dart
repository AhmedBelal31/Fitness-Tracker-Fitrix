import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../generated/l10n.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../home/data/trainee_model.dart';

class TraineeCard extends StatelessWidget {
  final TraineeModel trainee;
  final VoidCallback? onTap;
  final int index;

  const TraineeCard({
    required this.trainee,
    this.onTap,
    this.index = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return InkWell(
      onTap: onTap ?? () {},
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: ColorsManager.cardBackground,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: ColorsManager.cardShadow,
        ),
        child: Row(
          children: [
            // Profile Image
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: trainee.profileImage == null
                    ? ColorsManager.primaryGradient
                    : null,
                image: trainee.profileImage != null
                    ? DecorationImage(
                        image: NetworkImage(trainee.profileImage!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: trainee.profileImage == null
                  ? Center(
                      child: Text(
                        trainee.fullName.isNotEmpty
                            ? trainee.fullName[0].toUpperCase()
                            : 'U',
                        style: TextStyles.font24WhiteBold,
                      ),
                    )
                  : null,
            ),
            SizedBox(width: 12.w),

            // Trainee Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trainee.fullName,
                    style: TextStyles.font18PrimaryTextMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        Icons.fitness_center,
                        size: 14.sp,
                        color: ColorsManager.lightText,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${trainee.totalWorkouts} ${s.workouts}',
                        style: TextStyles.bodySmall,
                      ),
                      if (trainee.currentWeight != null) ...[
                        SizedBox(width: 12.w),
                        Icon(
                          Icons.monitor_weight,
                          size: 14.sp,
                          color: ColorsManager.lightText,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${trainee.currentWeight} ${s.kg}',
                          style: TextStyles.bodySmall,
                        ),
                      ],
                    ],
                  ),
                  if (trainee.lastWorkout != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      '${s.last_workout}: ${_formatDate(trainee.lastWorkout!)}',
                      style: TextStyles.caption,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),

            // Arrow Icon
            Icon(
              Icons.chevron_right,
              color: ColorsManager.lightText,
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date).inDays;

      if (difference == 0) return 'Today';
      if (difference == 1) return 'Yesterday';
      if (difference < 7) return '$difference days ago';

      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }
}
