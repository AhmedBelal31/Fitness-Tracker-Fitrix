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

// class MeasurementHistoryScreen extends StatelessWidget {
//   const MeasurementHistoryScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => di<ProgressCubit>()..loadMeasurementCharts(),
//       child: const _MeasurementHistoryView(),
//     );
//   }
// }
//
// class _MeasurementHistoryView extends StatelessWidget {
//   const _MeasurementHistoryView();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorsManager.scaffoldBackground,
//       appBar: AppBar(
//         title: Text('Measurement History', style: TextStyles.headline3),
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
//             return _buildErrorState(context, state.message);
//           }
//
//           if (state is ChartLoaded) {
//             return _buildChartView(context, state);
//           }
//
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }
//
//   Widget _buildErrorState(BuildContext context, String message) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.error_outline, size: 64.sp, color: ColorsManager.error),
//           SizedBox(height: 16.h),
//           Text(
//             message,
//             style: TextStyles.bodyMedium,
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 16.h),
//           ElevatedButton(
//             onPressed: () =>
//                 context.read<ProgressCubit>().loadMeasurementCharts(),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: ColorsManager.primaryGreen,
//               padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
//             ),
//             child: Text('Retry', style: TextStyles.font16WhiteSemiBold),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildChartView(BuildContext context, ChartLoaded state) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(20.w),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Time Period Selector
//           TimePeriodSelector(
//             selectedPeriod: state.selectedPeriod,
//             onPeriodChanged: (period) {
//               context.read<ProgressCubit>().changeTimePeriod(period);
//             },
//           ),
//           SizedBox(height: 20.h),
//
//           // Metric Selector
//           _buildMetricSelector(context, state.selectedMetric),
//           SizedBox(height: 20.h),
//
//           // Chart Card
//           Container(
//             decoration: BoxDecoration(
//               color: ColorsManager.cardBackground,
//               borderRadius: BorderRadius.circular(16.r),
//               boxShadow: ColorsManager.cardShadow,
//             ),
//             child: Column(
//               children: [
//                 // Chart Header
//                 Padding(
//                   padding: EdgeInsets.all(16.w),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         _getMetricTitle(state.selectedMetric),
//                         style: TextStyles.font18PrimaryTextMedium,
//                       ),
//                       ChartTypeSwitcher(
//                         selectedType: state.selectedChartType,
//                         onTypeChanged: (type) {
//                           context.read<ProgressCubit>().changeChartType(type);
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 // ✅ FIXED: Switch between different chart widgets
//                 _buildChart(state),
//
//                 // Stats Summary
//                 _buildStatsSummary(state),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ✅ NEW: Build the correct chart based on selectedChartType
//   Widget _buildChart(ChartLoaded state) {
//     final data = _getChartData(state);
//     final unit = _getUnit(state.selectedMetric);
//     final color = _getColor(state.selectedMetric);
//
//     switch (state.selectedChartType) {
//       case ChartType.line:
//         return ProgressLineChart(
//           key: ValueKey('line_${state.selectedMetric}'),
//           data: data,
//           unit: unit,
//           lineColor: color,
//         );
//
//       case ChartType.bar:
//         return ProgressBarChart(
//           key: ValueKey('bar_${state.selectedMetric}'),
//           data: data,
//           unit: unit,
//           barColor: color,
//         );
//
//       case ChartType.area:
//         return ProgressAreaChart(
//           key: ValueKey('area_${state.selectedMetric}'),
//           data: data,
//           unit: unit,
//           areaColor: color,
//         );
//     }
//   }
//
//   Widget _buildMetricSelector(
//     BuildContext context,
//     MeasurementCardType selectedMetric,
//   ) {
//     return Container(
//       padding: EdgeInsets.all(4.w),
//       decoration: BoxDecoration(
//         color: ColorsManager.cardBackground,
//         borderRadius: BorderRadius.circular(12.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           _buildMetricChip(
//             context,
//             'Weight',
//             Icons.monitor_weight_outlined,
//             MeasurementCardType.weight,
//             selectedMetric,
//           ),
//           SizedBox(width: 4.w),
//           _buildMetricChip(
//             context,
//             'Body Fat',
//             Icons.water_drop_outlined,
//             MeasurementCardType.bodyFat,
//             selectedMetric,
//           ),
//           SizedBox(width: 4.w),
//           _buildMetricChip(
//             context,
//             'Muscle',
//             Icons.fitness_center_outlined,
//             MeasurementCardType.muscleMass,
//             selectedMetric,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMetricChip(
//     BuildContext context,
//     String label,
//     IconData icon,
//     MeasurementCardType type,
//     MeasurementCardType selectedType,
//   ) {
//     final isSelected = selectedType == type;
//     return Expanded(
//       child: GestureDetector(
//         onTap: () => context.read<ProgressCubit>().changeMetric(type),
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 250),
//           padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 6.w),
//           decoration: BoxDecoration(
//             gradient: isSelected ? ColorsManager.primaryGradient : null,
//             borderRadius: BorderRadius.circular(10.r),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 icon,
//                 size: 16.sp,
//                 color: isSelected
//                     ? ColorsManager.whiteText
//                     : ColorsManager.secondaryText,
//               ),
//               SizedBox(width: 4.w),
//               Flexible(
//                 child: Text(
//                   label,
//                   style: TextStyles.caption.copyWith(
//                     fontSize: 11.sp,
//                     color: isSelected
//                         ? ColorsManager.whiteText
//                         : ColorsManager.secondaryText,
//                     fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStatsSummary(ChartLoaded state) {
//     final data = _getChartData(state);
//     if (data.isEmpty) return const SizedBox();
//
//     final values = data.map((e) => e.value ?? 0).toList();
//     final current = values.last;
//     final start = values.first;
//     final change = current - start;
//     final avg = values.reduce((a, b) => a + b) / values.length;
//     final max = values.reduce((a, b) => a > b ? a : b);
//     final min = values.reduce((a, b) => a < b ? a : b);
//
//     return Padding(
//       padding: EdgeInsets.all(16.w),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _buildStatItem(
//             'Change',
//             '${change.toStringAsFixed(1)}${_getUnit(state.selectedMetric)}',
//             change >= 0,
//           ),
//           _buildStatItem(
//             'Avg',
//             '${avg.toStringAsFixed(1)}${_getUnit(state.selectedMetric)}',
//             null,
//           ),
//           _buildStatItem(
//             'Max',
//             '${max.toStringAsFixed(1)}${_getUnit(state.selectedMetric)}',
//             null,
//           ),
//           _buildStatItem(
//             'Min',
//             '${min.toStringAsFixed(1)}${_getUnit(state.selectedMetric)}',
//             null,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildStatItem(String label, String value, bool? isPositive) {
//     return Column(
//       children: [
//         Text(label, style: TextStyles.font12SecondaryTextRegular),
//         SizedBox(height: 4.h),
//         Text(
//           value,
//           style: TextStyles.font14PrimaryTextMedium.copyWith(
//             color: isPositive == null
//                 ? ColorsManager.primaryText
//                 : isPositive
//                 ? ColorsManager.success
//                 : ColorsManager.error,
//           ),
//         ),
//       ],
//     );
//   }
//
//   List<ChartDataPoint> _getChartData(ChartLoaded state) {
//     switch (state.selectedMetric) {
//       case MeasurementCardType.weight:
//         return state.charts.weightChart;
//       case MeasurementCardType.bodyFat:
//         return state.charts.bodyFatChart;
//       case MeasurementCardType.muscleMass:
//         return state.charts.muscleMassChart;
//     }
//   }
//
//   String _getUnit(MeasurementCardType type) {
//     switch (type) {
//       case MeasurementCardType.weight:
//       case MeasurementCardType.muscleMass:
//         return 'kg';
//       case MeasurementCardType.bodyFat:
//         return '%';
//     }
//   }
//
//   Color _getColor(MeasurementCardType type) {
//     switch (type) {
//       case MeasurementCardType.weight:
//         return ColorsManager.primaryGreen;
//       case MeasurementCardType.bodyFat:
//         return ColorsManager.info;
//       case MeasurementCardType.muscleMass:
//         return ColorsManager.warning;
//     }
//   }
//
//   String _getMetricTitle(MeasurementCardType type) {
//     switch (type) {
//       case MeasurementCardType.weight:
//         return 'Weight Progress';
//       case MeasurementCardType.bodyFat:
//         return 'Body Fat Progress';
//       case MeasurementCardType.muscleMass:
//         return 'Muscle Mass Progress';
//     }
//   }
// }

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

class _MeasurementHistoryView extends StatelessWidget {
  const _MeasurementHistoryView();

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: ColorsManager.scaffoldBackground,
      appBar: AppBar(
        title: Text(s.measurement_history, style: TextStyles.headline3),
        backgroundColor: ColorsManager.scaffoldBackground,
        elevation: 0,
      ),
      body: BlocBuilder<ProgressCubit, ProgressState>(
        builder: (context, state) {
          if (state is ChartLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: ColorsManager.primaryGreen,
              ),
            );
          }

          if (state is ChartError) {
            return _buildErrorState(context, state.message, s);
          }

          if (state is ChartLoaded) {
            return _buildChartView(context, state, s);
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
              color: ColorsManager.cardBackground,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: ColorsManager.cardShadow,
            ),
            child: Column(
              children: [
                // Chart Header
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _getMetricTitle(state.selectedMetric, s),
                        style: TextStyles.font18PrimaryTextMedium,
                      ),
                      ChartTypeSwitcher(
                        selectedType: state.selectedChartType,
                        onTypeChanged: (type) {
                          context.read<ProgressCubit>().changeChartType(type);
                        },
                      ),
                    ],
                  ),
                ),

                // Chart
                _buildChart(state),

                // Stats Summary
                _buildStatsSummary(state, s),
              ],
            ),
          ),
        ],
      ),
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

  Widget _buildMetricSelector(
    BuildContext context,
    MeasurementCardType selectedMetric,
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
    return Expanded(
      child: GestureDetector(
        onTap: () => context.read<ProgressCubit>().changeMetric(type),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 6.w),
          decoration: BoxDecoration(
            gradient: isSelected ? ColorsManager.primaryGradient : null,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16.sp,
                color: isSelected
                    ? ColorsManager.whiteText
                    : ColorsManager.secondaryText,
              ),
              SizedBox(width: 4.w),
              Flexible(
                child: Text(
                  label,
                  style: TextStyles.caption.copyWith(
                    fontSize: 11.sp,
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

  Widget _buildStatsSummary(ChartLoaded state, S s) {
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
          _buildStatItem(
            s.change,
            '${change.toStringAsFixed(1)}${_getUnit(state.selectedMetric)}',
            change >= 0,
          ),
          _buildStatItem(
            s.average,
            '${avg.toStringAsFixed(1)}${_getUnit(state.selectedMetric)}',
            null,
          ),
          _buildStatItem(
            s.max_value,
            '${max.toStringAsFixed(1)}${_getUnit(state.selectedMetric)}',
            null,
          ),
          _buildStatItem(
            s.min_value,
            '${min.toStringAsFixed(1)}${_getUnit(state.selectedMetric)}',
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
}
