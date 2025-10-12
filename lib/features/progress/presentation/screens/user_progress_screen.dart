import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';

class UserProgressScreen extends StatelessWidget {
  const UserProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: ColorsManager.scaffoldBackground,
      appBar: AppBar(
        title: Text(s.my_progress, style: TextStyles.headline2),
        backgroundColor: ColorsManager.scaffoldBackground,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
        },
        color: ColorsManager.primaryGreen,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Weight Progress Card
              _buildWeightProgressCard(s),
              SizedBox(height: 20.h),

              // Measurements Card
              Text(s.measurements, style: TextStyles.subtitle1),
              SizedBox(height: 16.h),
              _buildMeasurementsCard(s),
              SizedBox(height: 20.h),

              // Goals Card
              Text(s.goals, style: TextStyles.subtitle1),
              SizedBox(height: 16.h),
              _buildGoalsCard(s),
              SizedBox(height: 20.h),

              // Statistics
              Text(s.statistics, style: TextStyles.subtitle1),
              SizedBox(height: 16.h),
              _buildStatisticsCard(s),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'log_measurement_fab', // Add unique tag
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(s.log_measurement),
              backgroundColor: ColorsManager.success,
            ),
          );
        },
        backgroundColor: ColorsManager.primaryGreen,
        foregroundColor: ColorsManager.whiteText,
        icon: const Icon(Icons.add),
        label: Text(s.log_measurement, style: TextStyles.buttonMedium),
      ),
    );
  }

  Widget _buildWeightProgressCard(S s) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: ColorsManager.cardGradient,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: ColorsManager.primaryShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(s.weight_progress, style: TextStyles.font18WhiteMedium),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: ColorsManager.success.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_downward,
                      size: 14.sp,
                      color: ColorsManager.whiteText,
                    ),
                    SizedBox(width: 4.w),
                    Text('4.5 ${s.kg}', style: TextStyles.font12WhiteRegular),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildWeightStat(s.current_weight, '75.5', s.kg),
              Container(
                width: 1,
                height: 40.h,
                color: ColorsManager.whiteText.withOpacity(0.3),
              ),
              _buildWeightStat('Start', '80.0', s.kg),
              Container(
                width: 1,
                height: 40.h,
                color: ColorsManager.whiteText.withOpacity(0.3),
              ),
              _buildWeightStat('Goal', '70.0', s.kg),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeightStat(String label, String value, String unit) {
    return Column(
      children: [
        Text(label, style: TextStyles.font12WhiteRegular),
        SizedBox(height: 4.h),
        Text('$value $unit', style: TextStyles.font20WhiteSemiBold),
      ],
    );
  }

  Widget _buildMeasurementsCard(S s) {
    final measurements = [
      {'label': s.chest, 'value': '102', 'change': '+2'},
      {'label': s.waist, 'value': '85', 'change': '-3'},
      {'label': s.arms, 'value': '38', 'change': '+1'},
      {'label': s.thighs, 'value': '58', 'change': '+2'},
    ];

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: ColorsManager.cardShadow,
      ),
      child: Column(
        children: measurements.map((m) {
          final change = double.parse(m['change']!);
          final isPositive = change > 0;
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(m['label']!, style: TextStyles.bodyMedium),
                Row(
                  children: [
                    Text(
                      '${m['value']} ${s.cm}',
                      style: TextStyles.font16PrimaryTextRegular,
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: isPositive
                            ? ColorsManager.success.withOpacity(0.1)
                            : ColorsManager.error.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        '${isPositive ? '+' : ''}${m['change']} ${s.cm}',
                        style: TextStyles.caption.copyWith(
                          color: isPositive
                              ? ColorsManager.success
                              : ColorsManager.error,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildGoalsCard(S s) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: ColorsManager.cardShadow,
      ),
      child: Column(
        children: [
          _buildGoalItem('Lose 10kg', 45, ColorsManager.primaryGreen),
          SizedBox(height: 16.h),
          _buildGoalItem('Bench Press 120kg', 75, ColorsManager.info),
          SizedBox(height: 16.h),
          _buildGoalItem('Run 5km', 30, ColorsManager.warning),
        ],
      ),
    );
  }

  Widget _buildGoalItem(String goal, int progress, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(goal, style: TextStyles.font14PrimaryTextMedium),
            Text('$progress%', style: TextStyles.font14PrimaryGreenSemiBold),
          ],
        ),
        SizedBox(height: 8.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: LinearProgressIndicator(
            value: progress / 100,
            backgroundColor: ColorsManager.grey200,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8.h,
          ),
        ),
      ],
    );
  }

  Widget _buildStatisticsCard(S s) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            Icons.emoji_events,
            '15',
            'PRs',
            ColorsManager.warning,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildStatCard(
            Icons.local_fire_department,
            '850',
            'Streak',
            ColorsManager.error,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    IconData icon,
    String value,
    String label,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: ColorsManager.cardShadow,
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32.sp),
          SizedBox(height: 8.h),
          Text(value, style: TextStyles.font24PrimaryTextBold),
          Text(label, style: TextStyles.bodySmall),
        ],
      ),
    );
  }
}
