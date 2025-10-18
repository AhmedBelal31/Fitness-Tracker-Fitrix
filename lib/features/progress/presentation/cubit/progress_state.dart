import 'package:equatable/equatable.dart';

import '../../data/models/measurement_chart_models.dart';
import '../../data/models/progress_models.dart';
import '../../data/models/statistics_model.dart';

abstract class ProgressState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProgressInitial extends ProgressState {}

class ProgressLoading extends ProgressState {}

class ProgressLoaded extends ProgressState {
  final MeasurementCardsResponse measurementCards;
  final MeasurementCardType selectedCardType;
  final StatisticsResponse? statistics;
  final bool shouldShowCelebration;
  final String? celebrationMessage;
  final double? celebrationProgress;

  ProgressLoaded({
    required this.measurementCards,
    required this.selectedCardType,
    this.statistics,
    this.shouldShowCelebration = false,
    this.celebrationMessage,
    this.celebrationProgress,
  });

  @override
  List<Object?> get props => [
    measurementCards,
    selectedCardType,
    statistics,
    shouldShowCelebration,
    celebrationMessage,
    celebrationProgress,
  ];

  ProgressLoaded copyWith({
    MeasurementCardsResponse? measurementCards,
    MeasurementCardType? selectedCardType,
    StatisticsResponse? statistics,
    bool? shouldShowCelebration,
    String? celebrationMessage,
    double? celebrationProgress,
  }) {
    return ProgressLoaded(
      measurementCards: measurementCards ?? this.measurementCards,
      selectedCardType: selectedCardType ?? this.selectedCardType,
      statistics: statistics ?? this.statistics,
      shouldShowCelebration:
          shouldShowCelebration ?? this.shouldShowCelebration,
      celebrationMessage: celebrationMessage ?? this.celebrationMessage,
      celebrationProgress: celebrationProgress ?? this.celebrationProgress,
    );
  }
}

class ProgressError extends ProgressState {
  final String message;

  ProgressError(this.message);

  @override
  List<Object?> get props => [message];
}

// NEW: Chart states
class ChartLoading extends ProgressState {}

class ChartLoaded extends ProgressState {
  final MeasurementChartResponse charts;
  final TimePeriod selectedPeriod;
  final MeasurementCardType selectedMetric;
  final ChartType selectedChartType;

  ChartLoaded({
    required this.charts,
    this.selectedPeriod = TimePeriod.month,
    this.selectedMetric = MeasurementCardType.weight,
    this.selectedChartType = ChartType.line,
  });

  @override
  List<Object?> get props => [
    charts,
    selectedPeriod,
    selectedMetric,
    selectedChartType,
  ];

  ChartLoaded copyWith({
    MeasurementChartResponse? charts,
    TimePeriod? selectedPeriod,
    MeasurementCardType? selectedMetric,
    ChartType? selectedChartType,
  }) {
    return ChartLoaded(
      charts: charts ?? this.charts,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
      selectedMetric: selectedMetric ?? this.selectedMetric,
      selectedChartType: selectedChartType ?? this.selectedChartType,
    );
  }
}

class ChartError extends ProgressState {
  final String message;

  ChartError(this.message);

  @override
  List<Object?> get props => [message];
}
