import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/mock_data.dart';
import 'user_home_section_header.dart';

class UserHomeRecords extends StatelessWidget {
  const UserHomeRecords({super.key});

  @override
  Widget build(BuildContext context) {
    final records = MockData.getMockUserDashboard().personalRecords;
    final s = S.of(context);

    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 1200),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 50 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserHomeSectionHeader(
            title: s.personal_records,
            onSeeAll: records != null && records.isNotEmpty
                ? () {
                    // Navigate to full records screen
                  }
                : null,
          ),
          SizedBox(height: 16.h),
          if (records != null && records.isNotEmpty)
            _buildRecordsList(context, records)
          else
            _buildEmptyState(s.no_personal_records_yet),
        ],
      ),
    );
  }

  Widget _buildRecordsList(BuildContext context, List records) {
    final s = S.of(context);
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: ColorsManager.cardShadow,
      ),
      child: Column(
        children: records.take(3).toList().asMap().entries.map((entry) {
          final index = entry.key;
          final record = entry.value;

          return TweenAnimationBuilder(
            duration: Duration(milliseconds: 600 + (index * 150)),
            tween: Tween<double>(begin: 0, end: 1),
            builder: (context, double value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(30 * (1 - value), 0),
                  child: child,
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: index < 2 ? 12.h : 0),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      gradient: ColorsManager.primaryGradient,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.emoji_events,
                      color: ColorsManager.whiteText,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          record.exerciseName,
                          style: TextStyles.font16PrimaryTextRegular,
                        ),
                        Text(
                          '${record.value} ${s.kg} • ${record.achievedDate}',
                          style: TextStyles.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: ColorsManager.lightText,
                    size: 24.sp,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: ColorsManager.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: ColorsManager.softShadow,
      ),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 48.sp,
              color: ColorsManager.lightText,
            ),
            SizedBox(height: 12.h),
            Text(message, style: TextStyles.bodyMedium),
          ],
        ),
      ),
    );
  }
}
