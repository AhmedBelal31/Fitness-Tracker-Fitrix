import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../data/trainer.dart';

class MyTrainerCard extends StatelessWidget {
  final Trainer trainer;

  const MyTrainerCard({super.key, required this.trainer});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.getCardBackground(context),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: ColorsManager.getPrimaryGreen(context).withValues(alpha: 0.2),
          width: 1.5,
        ),
        boxShadow: isDark
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : ColorsManager.cardShadow,
      ),
      child: Row(
        children: [
          // Profile Image with Gender Badge
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ColorsManager.getPrimaryGreen(
                      context,
                    ).withValues(alpha: 0.3),
                    width: 2.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: ColorsManager.getPrimaryGreen(
                        context,
                      ).withValues(alpha: 0.2),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 36.r,
                  backgroundColor: ColorsManager.getPrimaryGreen(
                    context,
                  ).withValues(alpha: 0.1),
                  backgroundImage: trainer.image != null
                      ? NetworkImage(trainer.image!)
                      : null,
                  child: trainer.image == null
                      ? Icon(
                          Icons.fitness_center_rounded,
                          color: ColorsManager.getPrimaryGreen(context),
                          size: 32.sp,
                        )
                      : null,
                ),
              ),
              // Gender Badge
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: trainer.gender == 1
                        ? ColorsManager.blue
                        : Colors.pink.shade400,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: ColorsManager.getCardBackground(context),
                      width: 2.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color:
                            (trainer.gender == 1
                                    ? ColorsManager.blue
                                    : Colors.pink.shade400)
                                .withValues(alpha: 0.3),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Icon(
                    trainer.genderIcon,
                    size: 14.sp,
                    color: ColorsManager.whiteText,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 16.w),
          // Trainer Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trainer.name,
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.getPrimaryText(context),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10.h),
                if (trainer.email != null) ...[
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: ColorsManager.getPrimaryGreen(
                            context,
                          ).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Icon(
                          Icons.email_outlined,
                          size: 14.sp,
                          color: ColorsManager.getPrimaryGreen(context),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          trainer.email!,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: ColorsManager.getSecondaryText(context),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                ],
                if (trainer.phoneNumber != null) ...[
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: ColorsManager.getPrimaryGreen(
                            context,
                          ).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Icon(
                          Icons.phone_outlined,
                          size: 14.sp,
                          color: ColorsManager.getPrimaryGreen(context),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        trainer.phoneNumber!,
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
        ],
      ),
    );
  }
}
