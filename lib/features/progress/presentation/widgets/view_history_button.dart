import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitrix/core/theming/styles.dart';
import 'package:fitrix/generated/l10n.dart';
import '../../../../core/theming/app_colors.dart';
import '../screens/measurement_history_screen.dart';

class ViewHistoryButton extends StatelessWidget {
  const ViewHistoryButton({super.key});

  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const MeasurementHistoryScreen()),
      ),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [
                    const Color(0xFF1B5E20).withValues(alpha: 0.3),
                    const Color(0xFF2E7D32).withValues(alpha: 0.15),
                  ]
                : [
                    ColorsManager.primaryGreen.withValues(alpha: 0.1),
                    ColorsManager.secondaryGreen.withValues(alpha: 0.05),
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: ColorsManager.getPrimaryGreen(
              context,
            ).withValues(alpha: isDark ? 0.5 : 0.3),
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
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: ColorsManager.getPrimaryText(context),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      s.view_charts_analytics,
                      style: TextStyle(
                        fontSize: 12,
                        color: ColorsManager.getSecondaryText(context),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    gradient: isDark
                        ? LinearGradient(
                            colors: [
                              ColorsManager.darkPrimaryGreen,
                              ColorsManager.darkSecondaryGreen,
                            ],
                          )
                        : ColorsManager.primaryGradient,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.insights,
                    color: isDark ? ColorsManager.darkScaffold : Colors.white,
                    size: 20.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMiniChartIcon(
                  Icons.show_chart,
                  s.line_chart,
                  isDark,
                  context,
                ),
                _buildMiniChartIcon(
                  Icons.bar_chart,
                  s.bar_chart,
                  isDark,
                  context,
                ),
                _buildMiniChartIcon(
                  Icons.area_chart,
                  s.area_chart,
                  isDark,
                  context,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniChartIcon(
    IconData icon,
    String label,
    bool isDark,
    context,
  ) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: ColorsManager.getPrimaryGreen(
              context,
            ).withValues(alpha: isDark ? 0.2 : 0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            icon,
            color: ColorsManager.getPrimaryGreen(context),
            size: 20.sp,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: ColorsManager.getPrimaryText(context),
          ),
        ),
      ],
    );
  }
}
