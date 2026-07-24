import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../data/models/trainee_request_model.dart';
import '../cubit/trainer_requests_cubit.dart';

class TraineeRequestCard extends StatelessWidget {
  final TraineeRequest request;

  const TraineeRequestCard({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.getCardBackground(context),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: ColorsManager.warningYellow.withValues(alpha: 0.3),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
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
                    ),
                    child: CircleAvatar(
                      radius: 32.r,
                      backgroundColor: ColorsManager.getPrimaryGreen(
                        context,
                      ).withValues(alpha: 0.1),
                      backgroundImage: request.traineeImage != null
                          ? NetworkImage(request.traineeImage!)
                          : null,
                      child: request.traineeImage == null
                          ? Icon(
                              Icons.person_rounded,
                              color: ColorsManager.getPrimaryGreen(context),
                              size: 32.sp,
                            )
                          : null,
                    ),
                  ),
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      width: 14.w,
                      height: 14.h,
                      decoration: BoxDecoration(
                        color: ColorsManager.success,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ColorsManager.getCardBackground(context),
                          width: 2.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(
                      request.traineeName,
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.getPrimaryText(context),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6.h),
                    // Date and Badge Row
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_rounded,
                          size: 13.sp,
                          color: ColorsManager.getSecondaryText(context),
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            s.requested_on(
                              DateFormat(
                                'MMM dd, yyyy',
                              ).format(request.createdAt),
                            ),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: ColorsManager.getSecondaryText(context),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        // Pending Badge
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                ColorsManager.warningYellow.withValues(
                                  alpha: 0.2,
                                ),
                                ColorsManager.warningYellow.withValues(
                                  alpha: 0.15,
                                ),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(6.r),
                            border: Border.all(
                              color: ColorsManager.warningYellow.withValues(
                                alpha: 0.4,
                              ),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.schedule_rounded,
                                size: 10.sp,
                                color: ColorsManager.warningYellow,
                              ),
                              SizedBox(width: 3.w),
                              Text(
                                s.pending,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                  color: ColorsManager.warningYellow,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Message Section
          if (request.message != null && request.message!.isNotEmpty) ...[
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: ColorsManager.getPrimaryGreen(
                  context,
                ).withValues(alpha: isDark ? 0.08 : 0.05),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: ColorsManager.getPrimaryGreen(
                    context,
                  ).withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: ColorsManager.getPrimaryGreen(
                        context,
                      ).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.message_rounded,
                      size: 16.sp,
                      color: ColorsManager.getPrimaryGreen(context),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s.message,
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: ColorsManager.getPrimaryGreen(context),
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          request.message!,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: ColorsManager.getPrimaryText(context),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: 16.h),
          // Divider
          Container(
            height: 1.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  ColorsManager.getPrimaryGreen(
                    context,
                  ).withValues(alpha: 0.15),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),
          // Action Buttons
          Row(
            children: [
              // Accept Button - DARKER GRADIENT
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        ColorsManager.darkGreen, // Darker green
                        ColorsManager.secondaryGreen, // Medium green
                        ColorsManager.darkGreen, // Darker green
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: ColorsManager.darkGreen.withValues(alpha: 0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<TrainerRequestsCubit>().acceptRequest(
                        request.id,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: ColorsManager.whiteText,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_rounded, size: 18.sp),
                        SizedBox(width: 8.w),
                        Text(
                          s.accept,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(width: 12.w),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    context.read<TrainerRequestsCubit>().rejectRequest(
                      request.id,
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: ColorsManager.error,
                    side: BorderSide(
                      color: ColorsManager.error.withValues(alpha: 0.5),
                      width: 1.5,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.close_rounded, size: 18.sp),
                      SizedBox(width: 8.w),
                      Text(
                        s.reject,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
