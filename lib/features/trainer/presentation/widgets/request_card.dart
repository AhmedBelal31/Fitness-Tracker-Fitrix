// lib/features/trainer/presentation/widgets/request_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/trainee_data.dart';
import '../../data/models/trainer_request.dart';

class RequestCard extends StatelessWidget {
  final TrainerRequestResponse request;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const RequestCard({
    super.key,
    required this.request,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final trainee = request.trainee;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: ColorsManager.getPrimaryGreen(context).withValues(alpha: 0.3),
          width: 1,
        ),
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
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24.r,
                  backgroundColor: ColorsManager.getPrimaryGreen(
                    context,
                  ).withValues(alpha: 0.2),
                  backgroundImage: trainee?.image != null
                      ? NetworkImage(trainee!.image!)
                      : null,
                  child: trainee?.image == null && trainee != null
                      ? Text(
                          '${trainee.firstName[0]}${trainee.lastName[0]}'
                              .toUpperCase(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.getPrimaryGreen(context),
                          ),
                        )
                      : null,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (trainee != null)
                        Text(
                          '${trainee.firstName} ${trainee.lastName}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.getPrimaryText(context),
                          ),
                        ),
                      SizedBox(height: 2.h),
                      Text(
                        _formatDate(request.createdAt),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: ColorsManager.getSecondaryText(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            if (request.message != null && request.message!.isNotEmpty) ...[
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: ColorsManager.getPrimaryGreen(
                    context,
                  ).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  request.message!,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: ColorsManager.getPrimaryText(context),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],

            SizedBox(height: 16.h),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onAccept,
                    icon: const Icon(Icons.check),
                    label: Text(S.of(context).accept),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.success,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onReject,
                    icon: const Icon(Icons.close),
                    label: Text(S.of(context).reject),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: ColorsManager.error,
                      side: BorderSide(color: ColorsManager.error),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
