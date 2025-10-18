import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fitrix/core/theming/styles.dart';
import 'package:intl/intl.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/models/measurement_chart_models.dart';

class ProgressAreaChart extends StatelessWidget {
  final List<ChartDataPoint> data;
  final String unit;
  final Color areaColor;

  const ProgressAreaChart({
    super.key,
    required this.data,
    required this.unit,
    required this.areaColor,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return _buildEmptyState(context);
    }

    return Container(
      height: 320.h, // ✅ Increased
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 1,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: ColorsManager.lightText.withOpacity(0.1),
                strokeWidth: 1,
              );
            },
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
                reservedSize: 32.h,
                interval: _getBottomInterval(), // ✅ Use same helper
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= data.length) {
                    return const SizedBox();
                  }
                  final date = data[index].date;
                  return Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Text(
                      DateFormat('MMM d').format(date),
                      style: TextStyles.font10WhiteRegular.copyWith(
                        color: ColorsManager.secondaryText,
                        fontSize: 9.sp,
                      ),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 45.w,
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
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: (data.length - 1).toDouble(),
          minY: _getMinY(),
          maxY: _getMaxY(),
          lineBarsData: [
            LineChartBarData(
              spots: data.asMap().entries.map((entry) {
                return FlSpot(entry.key.toDouble(), entry.value.value ?? 0);
              }).toList(),
              isCurved: true,
              curveSmoothness: 0.4,
              color: areaColor,
              barWidth: 0,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    areaColor.withOpacity(0.5),
                    areaColor.withOpacity(0.2),
                    areaColor.withOpacity(0.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (LineBarSpot touchedSpot) {
                return ColorsManager.cardBackground;
              },
              tooltipBorderRadius: BorderRadius.circular(8.r),
              tooltipPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 8.h,
              ),
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  final date = data[spot.x.toInt()].date;
                  return LineTooltipItem(
                    '${spot.y.toStringAsFixed(1)}$unit\n${DateFormat('MMM d').format(date)}',
                    TextStyles.font12WhiteSemiBold.copyWith(
                      color: ColorsManager.primaryText,
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }

  // ✅ Add same helper method
  double _getBottomInterval() {
    if (data.length <= 7) return 1;
    if (data.length <= 30) return 5;
    if (data.length <= 90) return 15;
    return 30;
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
      height: 250.h,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.area_chart, size: 48.sp, color: ColorsManager.lightText),
          SizedBox(height: 12.h),
          Text(s.no_data_available, style: TextStyles.bodyMedium),
        ],
      ),
    );
  }
}
