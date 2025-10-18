import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitrix/core/theming/styles.dart';
import 'package:fitrix/generated/l10n.dart';
import '../../../../core/theming/app_colors.dart';
import '../screens/measurement_history_screen.dart';

class ViewHistoryButton extends StatelessWidget {
  const ViewHistoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MeasurementHistoryScreen()),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorsManager.primaryGreen.withOpacity(0.1),
              ColorsManager.secondaryGreen.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: ColorsManager.primaryGreen.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      s.measurement_history,
                      style: TextStyles.font16PrimaryTextSemiBold,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      s.view_charts_analytics,
                      style: TextStyles.font12SecondaryTextRegular,
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    gradient: ColorsManager.primaryGradient,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.insights,
                    color: ColorsManager.whiteText,
                    size: 20.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMiniChartIcon(Icons.show_chart, s.line_chart),
                _buildMiniChartIcon(Icons.bar_chart, s.bar_chart),
                _buildMiniChartIcon(Icons.area_chart, s.area_chart),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniChartIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: ColorsManager.primaryGreen.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, color: ColorsManager.primaryGreen, size: 20.sp),
        ),
        SizedBox(height: 4.h),
        Text(label, style: TextStyles.font10Bold),
      ],
    );
  }
}
