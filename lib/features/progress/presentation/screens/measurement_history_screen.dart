import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitrix/core/di/get_it.dart';
import 'package:fitrix/core/theming/styles.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/measurement_chart_models.dart';
import '../../data/models/progress_models.dart';
import '../cubit/progress_cubit.dart';
import '../cubit/progress_state.dart';
import '../widgets/progress_charts/chart_type_switcher.dart';
import '../widgets/progress_charts/progress_area_chart.dart';
import '../widgets/progress_charts/progress_bar_chart.dart';
import '../widgets/progress_charts/progress_line_chart.dart';
import '../widgets/progress_charts/time_period_selector.dart';

class MeasurementHistoryScreen extends StatelessWidget {
  const MeasurementHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<ProgressCubit>()..loadMeasurementCharts(),
      child: const _MeasurementHistoryView(),
    );
  }
}

// class _MeasurementHistoryView extends StatelessWidget {
//   const _MeasurementHistoryView();
//
//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//
//     return Scaffold(
//       backgroundColor: ColorsManager.scaffoldBackground,
//       appBar: AppBar(
//         title: Text(s.measurement_history, style: TextStyles.headline3),
//         backgroundColor: ColorsManager.scaffoldBackground,
//         elevation: 0,
//       ),
//       body: BlocBuilder<ProgressCubit, ProgressState>(
//         builder: (context, state) {
//           if (state is ChartLoading) {
//             return const Center(
//               child: CircularProgressIndicator(
//                 color: ColorsManager.primaryGreen,
//               ),
//             );
//           }
//
//           if (state is ChartError) {
//             return _buildErrorState(context, state.message, s);
//           }
//
//           if (state is ChartLoaded) {
//             return _buildChartView(context, state, s);
//           }
//
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }
class _MeasurementHistoryView extends StatelessWidget {
  const _MeasurementHistoryView();

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          s.measurement_history,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ColorsManager.getPrimaryText(context),
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: ColorsManager.getPrimaryText(context)),
      ),
      body: BlocBuilder<ProgressCubit, ProgressState>(
        builder: (context, state) {
          if (state is ChartLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: ColorsManager.getPrimaryGreen(context),
              ),
            );
          }
          if (state is ChartError)
            return _buildErrorState(context, state.message, s);
          if (state is ChartLoaded) return _buildChartView(context, state, s);
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

Widget _buildErrorState(BuildContext context, String message, S s) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error_outline, size: 64.sp, color: ColorsManager.error),
        SizedBox(height: 16.h),
        Text(
          message,
          style: TextStyles.bodyMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16.h),
        ElevatedButton(
          onPressed: () =>
              context.read<ProgressCubit>().loadMeasurementCharts(),
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorsManager.primaryGreen,
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
          ),
          child: Text(s.retry, style: TextStyles.font16WhiteSemiBold),
        ),
      ],
    ),
  );
}

Widget _buildChartView(BuildContext context, ChartLoaded state, S s) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return SingleChildScrollView(
    padding: EdgeInsets.all(20.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Time Period Selector
        TimePeriodSelector(
          selectedPeriod: state.selectedPeriod,
          onPeriodChanged: (period) {
            context.read<ProgressCubit>().changeTimePeriod(period);
          },
        ),
        SizedBox(height: 20.h),

        // Metric Selector
        _buildMetricSelector(context, state.selectedMetric, s),
        SizedBox(height: 20.h),

        // Chart Card
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: isDark
                  ? ColorsManager.darkBorder.withValues(alpha: 0.5)
                  : Colors.transparent,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withValues(alpha: 0.3)
                    : Colors.black.withValues(alpha: 0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Chart Header
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        _getMetricTitle(state.selectedMetric, s),
                        maxLines: 1,
                        // minFontSize: 14,
                        // maxFontSize: 18,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: ColorsManager.getPrimaryText(context),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    ChartTypeSwitcher(
                      selectedType: state.selectedChartType,
                      onTypeChanged: (type) {
                        context.read<ProgressCubit>().changeChartType(type);
                      },
                    ),
                  ],
                ),
              ),

              // Divider
              Container(
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                color: isDark
                    ? ColorsManager.darkBorder
                    : ColorsManager.lightBorder,
              ),

              // Chart
              _buildChart(state),

              // Divider
              Container(
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                color: isDark
                    ? ColorsManager.darkBorder
                    : ColorsManager.lightBorder,
              ),

              // Stats Summary
              _buildStatsSummary(state, s, context),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildMetricSelector(
  BuildContext context,
  MeasurementCardType selectedMetric,
  S s,
) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return Container(
    padding: EdgeInsets.all(4.w),
    decoration: BoxDecoration(
      color: Theme.of(context).cardTheme.color,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(
        color: isDark ? ColorsManager.darkBorder : ColorsManager.lightBorder,
      ),
      boxShadow: [
        BoxShadow(
          color: isDark
              ? Colors.black.withValues(alpha: 0.3)
              : Colors.black.withValues(alpha: 0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        _buildMetricChip(
          context,
          s.weight,
          Icons.monitor_weight_outlined,
          MeasurementCardType.weight,
          selectedMetric,
        ),
        SizedBox(width: 4.w),
        _buildMetricChip(
          context,
          s.body_fat,
          Icons.water_drop_outlined,
          MeasurementCardType.bodyFat,
          selectedMetric,
        ),
        SizedBox(width: 4.w),
        _buildMetricChip(
          context,
          s.muscle_mass,
          Icons.fitness_center_outlined,
          MeasurementCardType.muscleMass,
          selectedMetric,
        ),
      ],
    ),
  );
}

Widget _buildMetricChip(
  BuildContext context,
  String label,
  IconData icon,
  MeasurementCardType type,
  MeasurementCardType selectedType,
) {
  final isSelected = selectedType == type;
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return Expanded(
    child: GestureDetector(
      onTap: () => context.read<ProgressCubit>().changeMetric(type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 6.w),
        decoration: BoxDecoration(
          gradient: isSelected
              ? (isDark
                    ? LinearGradient(
                        colors: [
                          ColorsManager.darkPrimaryGreen,
                          ColorsManager.darkSecondaryGreen,
                        ],
                      )
                    : ColorsManager.primaryGradient)
              : null,
          color: isSelected
              ? null
              : (isDark
                    ? ColorsManager.darkInputBackground
                    : Colors.transparent),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16.sp,
              color: isSelected
                  ? (isDark ? ColorsManager.darkScaffold : Colors.white)
                  : (isDark ? Colors.white : ColorsManager.secondaryText),
            ),
            SizedBox(width: 4.w),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: isSelected
                      ? (isDark ? ColorsManager.darkScaffold : Colors.white)
                      : (isDark ? Colors.white : ColorsManager.secondaryText),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildStatsSummary(ChartLoaded state, S s, context) {
  final data = _getChartData(state);
  if (data.isEmpty) return const SizedBox();

  final values = data.map((e) => e.value ?? 0).toList();
  final current = values.last;
  final start = values.first;
  final change = current - start;
  final avg = values.reduce((a, b) => a + b) / values.length;
  final max = values.reduce((a, b) => a > b ? a : b);
  final min = values.reduce((a, b) => a < b ? a : b);

  return Padding(
    padding: EdgeInsets.all(16.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: _buildStatItem(
            s.change,
            '${change.toStringAsFixed(1)}${_getUnit(state.selectedMetric)}',
            change >= 0,
            context,
          ),
        ),
        Expanded(
          child: _buildStatItem(
            s.average,
            '${avg.toStringAsFixed(1)}${_getUnit(state.selectedMetric)}',
            null,
            context,
          ),
        ),
        Expanded(
          child: _buildStatItem(
            s.max_value,
            '${max.toStringAsFixed(1)}${_getUnit(state.selectedMetric)}',
            null,
            context,
          ),
        ),
        Expanded(
          child: _buildStatItem(
            s.min_value,
            '${min.toStringAsFixed(1)}${_getUnit(state.selectedMetric)}',
            null,
            context,
          ),
        ),
      ],
    ),
  );
}

Widget _buildStatItem(String label, String value, bool? isPositive, context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: ColorsManager.getSecondaryText(context),
        ),
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      SizedBox(height: 4.h),
      Text(
        value,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isPositive == null
              ? ColorsManager.getPrimaryText(context)
              : isPositive
              ? ColorsManager.success
              : ColorsManager.error,
        ),
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ],
  );
}

Widget _buildChart(ChartLoaded state) {
  final data = _getChartData(state);
  final unit = _getUnit(state.selectedMetric);
  final color = _getColor(state.selectedMetric);

  switch (state.selectedChartType) {
    case ChartType.line:
      return ProgressLineChart(
        key: ValueKey('line_${state.selectedMetric}'),
        data: data,
        unit: unit,
        lineColor: color,
      );

    case ChartType.bar:
      return ProgressBarChart(
        key: ValueKey('bar_${state.selectedMetric}'),
        data: data,
        unit: unit,
        barColor: color,
      );

    case ChartType.area:
      return ProgressAreaChart(
        key: ValueKey('area_${state.selectedMetric}'),
        data: data,
        unit: unit,
        areaColor: color,
      );
  }
}

List<ChartDataPoint> _getChartData(ChartLoaded state) {
  switch (state.selectedMetric) {
    case MeasurementCardType.weight:
      return state.charts.weightChart;
    case MeasurementCardType.bodyFat:
      return state.charts.bodyFatChart;
    case MeasurementCardType.muscleMass:
      return state.charts.muscleMassChart;
  }
}

String _getUnit(MeasurementCardType type) {
  switch (type) {
    case MeasurementCardType.weight:
    case MeasurementCardType.muscleMass:
      return 'kg';
    case MeasurementCardType.bodyFat:
      return '%';
  }
}

Color _getColor(MeasurementCardType type) {
  switch (type) {
    case MeasurementCardType.weight:
      return ColorsManager.primaryGreen;
    case MeasurementCardType.bodyFat:
      return ColorsManager.info;
    case MeasurementCardType.muscleMass:
      return ColorsManager.warning;
  }
}

String _getMetricTitle(MeasurementCardType type, S s) {
  switch (type) {
    case MeasurementCardType.weight:
      return s.weight_progress;
    case MeasurementCardType.bodyFat:
      return s.body_fat_progress;
    case MeasurementCardType.muscleMass:
      return s.muscle_mass_progress;
  }
}
