import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
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
          alignment: BarChartAlignment.spaceAround,
          maxY: _getMaxY(),
          minY: _getMinY(),
          groupsSpace: 4.w,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (group) => Theme.of(context).cardTheme.color!,
              tooltipBorderRadius: BorderRadius.circular(8.r),
              tooltipPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 8.h,
              ),
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                final date = data[group.x].date;
                return BarTooltipItem(
                  '${rod.toY.toStringAsFixed(1)}$unit\n${DateFormat('MMM d, yyyy').format(date)}',
                  TextStyle(
                    fontSize: 12,
                    color: ColorsManager.getPrimaryText(context),
                    fontWeight: FontWeight.w600,
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
                reservedSize: 40.h,
                getTitlesWidget: (value, meta) {
                  return _buildBottomTitle(value.toInt(), context);
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: _getLeftInterval(),
                reservedSize: 50.w,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '${value.toInt()}$unit',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: ColorsManager.getSecondaryText(context),
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
                color: ColorsManager.getSecondaryText(
                  context,
                ).withValues(alpha: 0.2),
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
                  width: _getBarWidth(),
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

  Widget _buildBottomTitle(int index, BuildContext context) {
    if (index < 0 || index >= data.length) return const SizedBox.shrink();

    final date = data[index].date;
    final showInterval = _getBottomTitleInterval();

    if (index % showInterval != 0 && index != data.length - 1) {
      return const SizedBox.shrink();
    }

    String dateLabel;
    if (data.length <= 7) {
      dateLabel = DateFormat('EEE').format(date);
    } else if (data.length <= 30) {
      dateLabel = DateFormat('d').format(date);
    } else if (data.length <= 90) {
      dateLabel = DateFormat('MMM d').format(date);
    } else {
      dateLabel = DateFormat('MMM').format(date);
    }

    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Text(
        dateLabel,
        style: TextStyle(
          fontSize: 9.sp,
          color: ColorsManager.getSecondaryText(context),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  int _getBottomTitleInterval() {
    if (data.length <= 7) return 1;
    if (data.length <= 14) return 2;
    if (data.length <= 30) return 5;
    if (data.length <= 60) return 10;
    if (data.length <= 90) return 15;
    return 30;
  }

  double _getBarWidth() {
    if (data.length <= 7) return 16.w;
    if (data.length <= 14) return 12.w;
    if (data.length <= 30) return 8.w;
    if (data.length <= 60) return 6.w;
    return 4.w;
  }

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
          Icon(
            Icons.bar_chart,
            size: 48.sp,
            color: ColorsManager.getSecondaryText(context),
          ),
          SizedBox(height: 12.h),
          Text(
            s.no_data_available,
            style: TextStyle(
              fontSize: 14,
              color: ColorsManager.getPrimaryText(context),
            ),
          ),
        ],
      ),
    );
  }
}
