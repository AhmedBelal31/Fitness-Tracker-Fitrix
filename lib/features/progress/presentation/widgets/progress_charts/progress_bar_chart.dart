import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fitrix/core/theming/styles.dart';
import 'package:intl/intl.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/models/measurement_chart_models.dart';

class ProgressBarChart extends StatelessWidget {
  final List<ChartDataPoint> data;
  final String unit;
  final Color barColor;

  const ProgressBarChart({
    super.key,
    required this.data,
    required this.unit,
    required this.barColor,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return _buildEmptyState(context);
    }

    return Container(
      height: 320.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround, // ✅ Better spacing
          maxY: _getMaxY(),
          minY: _getMinY(),
          groupsSpace: 4.w, // ✅ Space between bar groups
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (group) => ColorsManager.cardBackground,
              tooltipBorderRadius: BorderRadius.circular(8.r),
              tooltipPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 8.h,
              ),
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                final date = data[group.x].date;
                return BarTooltipItem(
                  '${rod.toY.toStringAsFixed(1)}$unit\n${DateFormat('MMM d, yyyy').format(date)}',
                  TextStyles.font12WhiteSemiBold.copyWith(
                    color: ColorsManager.primaryText,
                  ),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40.h, // ✅ More space
                getTitlesWidget: (value, meta) {
                  return _buildBottomTitle(value.toInt());
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: _getLeftInterval(), // ✅ Dynamic interval
                reservedSize: 50.w,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '${value.toInt()}$unit',
                    style: TextStyles.font10WhiteRegular.copyWith(
                      color: ColorsManager.secondaryText,
                      fontSize: 10.sp,
                    ),
                  );
                },
              ),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: _getLeftInterval(),
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: ColorsManager.lightText.withOpacity(0.1),
                strokeWidth: 1,
              );
            },
          ),
          borderData: FlBorderData(show: false),
          barGroups: data.asMap().entries.map((entry) {
            return BarChartGroupData(
              x: entry.key,
              barRods: [
                BarChartRodData(
                  toY: entry.value.value ?? 0,
                  gradient: LinearGradient(
                    colors: [barColor, barColor.withOpacity(0.7)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  width: _getBarWidth(), // ✅ Dynamic bar width
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(4.r),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  // ✅ FIXED: Smart bottom title rendering
  Widget _buildBottomTitle(int index) {
    if (index < 0 || index >= data.length) {
      return const SizedBox.shrink();
    }

    final date = data[index].date;

    // Determine which dates to show based on data length
    final showInterval = _getBottomTitleInterval();

    // Only show dates at the calculated interval
    if (index % showInterval != 0 && index != data.length - 1) {
      return const SizedBox.shrink();
    }

    // Format date based on data length
    String dateLabel;
    if (data.length <= 7) {
      // Show day of week for 7 days
      dateLabel = DateFormat('EEE').format(date);
    } else if (data.length <= 30) {
      // Show "d" for 30 days
      dateLabel = DateFormat('d').format(date);
    } else if (data.length <= 90) {
      // Show "MMM d" for 90 days
      dateLabel = DateFormat('MMM d').format(date);
    } else {
      // Show "MMM" for longer periods
      dateLabel = DateFormat('MMM').format(date);
    }

    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Text(
        dateLabel,
        style: TextStyles.font10WhiteRegular.copyWith(
          color: ColorsManager.secondaryText,
          fontSize: 9.sp,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // ✅ Calculate how many dates to skip
  int _getBottomTitleInterval() {
    if (data.length <= 7) return 1; // Show all
    if (data.length <= 14) return 2; // Show every 2nd
    if (data.length <= 30) return 5; // Show every 5th
    if (data.length <= 60) return 10; // Show every 10th
    if (data.length <= 90) return 15; // Show every 15th
    return 30; // Show every 30th for longer periods
  }

  // ✅ Dynamic bar width based on data length
  double _getBarWidth() {
    if (data.length <= 7) return 16.w;
    if (data.length <= 14) return 12.w;
    if (data.length <= 30) return 8.w;
    if (data.length <= 60) return 6.w;
    return 4.w;
  }

  // ✅ Dynamic left axis interval
  double _getLeftInterval() {
    final range = _getMaxY() - _getMinY();
    if (range <= 50) return 10;
    if (range <= 100) return 20;
    if (range <= 200) return 40;
    return 50;
  }

  double _getMinY() {
    final values = data.map((e) => e.value ?? 0).toList();
    if (values.isEmpty) return 0;
    final min = values.reduce((a, b) => a < b ? a : b);
    return (min - 10).clamp(0, double.infinity);
  }

  double _getMaxY() {
    final values = data.map((e) => e.value ?? 0).toList();
    if (values.isEmpty) return 100;
    final max = values.reduce((a, b) => a > b ? a : b);
    return max + 10;
  }

  Widget _buildEmptyState(BuildContext context) {
    final s = S.of(context);
    return Container(
      height: 320.h,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bar_chart, size: 48.sp, color: ColorsManager.lightText),
          SizedBox(height: 12.h),
          Text(s.no_data_available, style: TextStyles.bodyMedium),
        ],
      ),
    );
  }
}
