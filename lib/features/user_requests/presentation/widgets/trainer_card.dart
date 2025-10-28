import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../data/trainer.dart';
import '../cubit/user_requests_cubit.dart';

class TrainerCard extends StatelessWidget {
  final Trainer trainer;

  const TrainerCard({super.key, required this.trainer});

  void _showSendRequestDialog(BuildContext context) {
    final s = S.of(context);
    final messageController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: ColorsManager.getCardBackground(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundColor: ColorsManager.getPrimaryGreen(
                context,
              ).withOpacity(0.1),
              backgroundImage: trainer.image != null
                  ? NetworkImage(trainer.image!)
                  : null,
              child: trainer.image == null
                  ? Icon(
                      Icons.fitness_center_rounded,
                      color: ColorsManager.getPrimaryGreen(context),
                      size: 20.sp,
                    )
                  : null,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                s.sending_request_to(trainer.name),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.getPrimaryText(context),
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: messageController,
              maxLines: 4,
              style: TextStyle(color: ColorsManager.getPrimaryText(context)),
              decoration: InputDecoration(
                hintText: s.add_message_optional,
                hintStyle: TextStyle(
                  color: ColorsManager.getSecondaryText(context),
                ),
                fillColor: ColorsManager.getInputBackground(context),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(
                    color: ColorsManager.getPrimaryGreen(context),
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              s.cancel,
              style: TextStyle(
                color: ColorsManager.getSecondaryText(context),
                fontSize: 14.sp,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<UserRequestsCubit>().sendRequest(
                trainer.id,
                message: messageController.text.trim().isEmpty
                    ? null
                    : messageController.text.trim(),
              );
              Navigator.pop(dialogContext);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.getPrimaryGreen(context),
              foregroundColor: ColorsManager.whiteText,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(s.send),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: ColorsManager.getCardBackground(context),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: trainer.hasRequestPending
              ? ColorsManager.warning.withOpacity(0.3)
              : ColorsManager.getPrimaryGreen(context).withOpacity(0.15),
          width: 1.5,
        ),
        boxShadow: isDark
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : ColorsManager.cardShadow,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
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
                          ).withOpacity(0.3),
                          width: 2.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: ColorsManager.getPrimaryGreen(
                              context,
                            ).withOpacity(0.2),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 36.r,
                        backgroundColor: ColorsManager.getPrimaryGreen(
                          context,
                        ).withOpacity(0.1),
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
                                      .withOpacity(0.3),
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
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              trainer.name,
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold,
                                color: ColorsManager.getPrimaryText(context),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (trainer.hasRequestPending)
                            Container(
                              margin: EdgeInsets.only(left: 8.w),
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 5.h,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    ColorsManager.warning.withOpacity(0.2),
                                    ColorsManager.warning.withOpacity(0.15),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: ColorsManager.warning.withOpacity(0.4),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.schedule_rounded,
                                    size: 12.sp,
                                    color: ColorsManager.warning,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    s.pending,
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.bold,
                                      color: ColorsManager.warning,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
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
                                ).withOpacity(0.1),
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
                                  color: ColorsManager.getSecondaryText(
                                    context,
                                  ),
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
                                ).withOpacity(0.1),
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
          ),
          // Divider with gradient
          Container(
            height: 1.h,
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  ColorsManager.getPrimaryGreen(
                    context,
                  ).withOpacity(isDark ? 0.2 : 0.15),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          // Action Button
          // Update only the button section in TrainerCard

          // Action Button
          Padding(
            padding: EdgeInsets.all(16.w),
            child: SizedBox(
              width: double.infinity,
              child: trainer.isInRelation
                  ? // Connected Button - Lighter Style
                    ElevatedButton(
                      onPressed: null, // Disabled
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManager.getPrimaryGreen(
                          context,
                        ).withValues(alpha: 0.1),
                        foregroundColor: ColorsManager.getPrimaryGreen(context),
                        disabledBackgroundColor: ColorsManager.getPrimaryGreen(
                          context,
                        ).withValues(alpha: 0.1),
                        disabledForegroundColor: ColorsManager.getPrimaryGreen(
                          context,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          side: BorderSide(
                            color: ColorsManager.getPrimaryGreen(
                              context,
                            ).withValues(alpha: 0.3),
                            width: 1.5,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            size: 18.sp,
                            color: ColorsManager.getPrimaryGreen(context),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            s.connected,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                              color: ColorsManager.getPrimaryGreen(context),
                            ),
                          ),
                        ],
                      ),
                    )
                  : trainer.hasRequestPending
                  ? // Pending Button
                    ElevatedButton(
                      onPressed: null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManager.getSecondaryText(
                          context,
                        ).withValues(alpha: 0.15),
                        disabledBackgroundColor: ColorsManager.getSecondaryText(
                          context,
                        ).withValues(alpha: 0.15),
                        disabledForegroundColor: ColorsManager.getSecondaryText(
                          context,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.schedule_rounded, size: 18.sp),
                          SizedBox(width: 8.w),
                          Text(
                            s.pending,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    )
                  : // Send Request Button - With Gradient
                    // Send Request Button - DARKER GRADIENT
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            ColorsManager.darkGreen, // #2F855A - Darker
                            ColorsManager.secondaryGreen, // #38A169 - Medium
                            ColorsManager.darkGreen, // #2F855A - Darker
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                        borderRadius: BorderRadius.circular(14.r),
                        boxShadow: [
                          BoxShadow(
                            color: ColorsManager.darkGreen.withValues(
                              alpha: 0.4,
                            ),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () => _showSendRequestDialog(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: ColorsManager.whiteText,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.send_rounded, size: 18.sp),
                            SizedBox(width: 8.w),
                            Text(
                              s.send_request,
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
