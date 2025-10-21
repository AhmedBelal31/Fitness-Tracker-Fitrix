import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import '../../../progress/data/models/measurement_chart_models.dart';
import '../../../progress/presentation/cubit/progress_cubit.dart';
import '../../../progress/presentation/cubit/progress_state.dart';
import '../../../progress/presentation/widgets/progress_charts/progress_line_chart.dart';
import '../../../progress/presentation/widgets/progress_charts/time_period_selector.dart';
import '../../data/models/exercise_model.dart';
import '../../../progress/presentation/widgets/progress_charts/chart_type_switcher.dart'; // ✅ Import
import '../../../progress/presentation/widgets/progress_charts/progress_area_chart.dart'; // ✅ Import
import '../../../progress/presentation/widgets/progress_charts/progress_bar_chart.dart'; // ✅ Import

class ExerciseProgressScreen extends StatelessWidget {
  final ExerciseModel exercise;

  const ExerciseProgressScreen({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          di<ProgressCubit>()..loadExerciseProgress(exercise.id.toString()),
      child: _ExerciseProgressView(exercise: exercise),
    );
  }
}

class _ExerciseProgressView extends StatelessWidget {
  final ExerciseModel exercise;

  const _ExerciseProgressView({required this.exercise});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: ColorsManager.scaffoldBackground,
      appBar: AppBar(
        title: Text(
          '${exercise.name} ${s.progress}',
          style: TextStyles.headline3,
        ),
        backgroundColor: ColorsManager.scaffoldBackground,
        elevation: 0,
      ),
      body: BlocBuilder<ProgressCubit, ProgressState>(
        builder: (context, state) {
          if (state is ExerciseProgressLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: ColorsManager.primaryGreen,
              ),
            );
          }

          if (state is ExerciseProgressError) {
            return _buildErrorState(context, state.message, s);
          }

          if (state is ExerciseProgressLoaded) {
            return _buildChartsView(context, state, s);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message, S s) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64.sp, color: ColorsManager.error),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              message,
              style: TextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () => context.read<ProgressCubit>().loadExerciseProgress(
              exercise.id.toString(),
            ),
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

  Widget _buildChartsView(
    BuildContext context,
    ExerciseProgressLoaded state,
    S s,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time Period Selector
          TimePeriodSelector(
            selectedPeriod: state.selectedPeriod,
            onPeriodChanged: (period) {
              context.read<ProgressCubit>().changeExerciseTimePeriod(period);
            },
          ),
          SizedBox(height: 20.h),

          // Metric Selector
          _buildMetricSelector(context, state.selectedMetric, s),
          SizedBox(height: 20.h),

          // Chart Card
          Container(
            decoration: BoxDecoration(
              color: ColorsManager.cardBackground,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: ColorsManager.cardShadow,
            ),
            child: Column(
              children: [
                // Chart Header with Chart Type Switcher
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          _getMetricTitle(state.selectedMetric, s),
                          style: TextStyles.font18PrimaryTextMedium,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      // ✅ Chart Type Switcher
                      ChartTypeSwitcher(
                        selectedType: state.selectedChartType,
                        onTypeChanged: (type) {
                          context.read<ProgressCubit>().changeExerciseChartType(
                            type,
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // Chart
                _buildChart(state, context),

                // Stats Summary
                _buildStatsSummary(state, s),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Updated to support all three chart types
  Widget _buildChart(ExerciseProgressLoaded state, BuildContext context) {
    final data = _getChartData(state);
    final unit = _getUnit(state.selectedMetric);
    final color = _getColor(state.selectedMetric);

    if (data.isEmpty) {
      return Padding(
        padding: EdgeInsets.all(40.w),
        child: Column(
          children: [
            Icon(
              Icons.insert_chart_outlined,
              size: 64.sp,
              color: ColorsManager.lightText,
            ),
            SizedBox(height: 16.h),
            Text(
              S.of(context).no_data_available,
              style: TextStyles.font14SecondaryTextRegular,
            ),
          ],
        ),
      );
    }

    // ✅ Switch between chart types
    switch (state.selectedChartType) {
      case ChartType.line:
        return ProgressLineChart(
          key: ValueKey(
            'exercise_line_${state.selectedMetric}_${state.selectedPeriod}',
          ),
          data: data,
          unit: unit,
          lineColor: color,
        );

      case ChartType.bar:
        return ProgressBarChart(
          key: ValueKey(
            'exercise_bar_${state.selectedMetric}_${state.selectedPeriod}',
          ),
          data: data,
          unit: unit,
          barColor: color,
        );

      case ChartType.area:
        return ProgressAreaChart(
          key: ValueKey(
            'exercise_area_${state.selectedMetric}_${state.selectedPeriod}',
          ),
          data: data,
          unit: unit,
          areaColor: color,
        );
    }
  }

  Widget _buildMetricSelector(
    BuildContext context,
    ExerciseMetricType selectedMetric,
    S s,
  ) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: ColorsManager.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
            Icons.fitness_center,
            ExerciseMetricType.weight,
            selectedMetric,
          ),
          SizedBox(width: 4.w),
          _buildMetricChip(
            context,
            s.volume,
            Icons.show_chart,
            ExerciseMetricType.volume,
            selectedMetric,
          ),
          SizedBox(width: 4.w),
          _buildMetricChip(
            context,
            s.reps,
            Icons.repeat,
            ExerciseMetricType.reps,
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
    ExerciseMetricType type,
    ExerciseMetricType selectedType,
  ) {
    final isSelected = selectedType == type;
    return Expanded(
      child: GestureDetector(
        onTap: () => context.read<ProgressCubit>().changeExerciseMetric(type),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
          decoration: BoxDecoration(
            gradient: isSelected ? ColorsManager.primaryGradient : null,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18.sp,
                color: isSelected
                    ? ColorsManager.whiteText
                    : ColorsManager.secondaryText,
              ),
              SizedBox(width: 6.w),
              Flexible(
                child: Text(
                  label,
                  style: TextStyles.font12Medium.copyWith(
                    color: isSelected
                        ? ColorsManager.whiteText
                        : ColorsManager.secondaryText,
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

  Widget _buildStatsSummary(ExerciseProgressLoaded state, S s) {
    final data = _getChartData(state);
    if (data.isEmpty) return const SizedBox();

    final values = data.map((e) => e.value ?? 0).toList();
    final current = values.last;
    final start = values.first;
    final change = current - start;
    final avg = values.reduce((a, b) => a + b) / values.length;
    final max = values.reduce((a, b) => a > b ? a : b);

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            s.change,
            '${change >= 0 ? '+' : ''}${change.toStringAsFixed(1)}${_getUnit(state.selectedMetric)}',
            change >= 0,
          ),
          _buildStatItem(
            s.average,
            '${avg.toStringAsFixed(1)}${_getUnit(state.selectedMetric)}',
            null,
          ),
          _buildStatItem(
            s.peak,
            '${max.toStringAsFixed(1)}${_getUnit(state.selectedMetric)}',
            null,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, bool? isPositive) {
    return Column(
      children: [
        Text(label, style: TextStyles.font12SecondaryTextRegular),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyles.font14PrimaryTextMedium.copyWith(
            color: isPositive == null
                ? ColorsManager.primaryText
                : isPositive
                ? ColorsManager.success
                : ColorsManager.error,
          ),
        ),
      ],
    );
  }

  List<ChartDataPoint> _getChartData(ExerciseProgressLoaded state) {
    switch (state.selectedMetric) {
      case ExerciseMetricType.weight:
        return state.charts.weightProgression;
      case ExerciseMetricType.volume:
        return state.charts.volumeProgression;
      case ExerciseMetricType.reps:
        return state.charts.repsProgression;
    }
  }

  String _getUnit(ExerciseMetricType type) {
    switch (type) {
      case ExerciseMetricType.weight:
        return 'kg';
      case ExerciseMetricType.volume:
      case ExerciseMetricType.reps:
        return '';
    }
  }

  Color _getColor(ExerciseMetricType type) {
    switch (type) {
      case ExerciseMetricType.weight:
        return ColorsManager.primaryGreen;
      case ExerciseMetricType.volume:
        return ColorsManager.info;
      case ExerciseMetricType.reps:
        return ColorsManager.warning;
    }
  }

  String _getMetricTitle(ExerciseMetricType type, S s) {
    switch (type) {
      case ExerciseMetricType.weight:
        return s.weight_progress;
      case ExerciseMetricType.volume:
        return s.volume_progress;
      case ExerciseMetricType.reps:
        return s.reps_progress;
    }
  }
}
