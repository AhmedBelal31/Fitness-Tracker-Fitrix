import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/helpers/celebration_prefs.dart';
import '../../data/models/measurement_chart_models.dart';
import '../../data/models/progress_models.dart';
import '../../data/models/statistics_model.dart';
import '../../domain/progress_repository.dart';
import 'progress_state.dart';
import 'package:flutter/foundation.dart';

class ProgressCubit extends Cubit<ProgressState> {
  final ProgressRepository _repository;

  ProgressCubit({required ProgressRepository repository})
    : _repository = repository,
      super(ProgressInitial());

  // ========== PROGRESS SCREEN METHODS ==========

  /// Load all progress data (cards + statistics)
  Future<void> loadProgress() async {
    emit(ProgressLoading());

    try {
      final cards = await _repository.getMeasurementCards();
      final stats = await _loadStatisticsSafely();

      emit(
        ProgressLoaded(
          measurementCards: cards,
          selectedCardType: MeasurementCardType.weight,
          statistics: stats,
        ),
      );

      // Check for celebration after loading
      _checkAndCelebrate(cards);
    } catch (e) {
      emit(ProgressError('Failed to load progress data: $e'));
    }
  }

  /// Refresh progress data
  Future<void> refreshData() async {
    if (state is! ProgressLoaded) return;

    try {
      final cards = await _repository.getMeasurementCards();
      final stats = await _loadStatisticsSafely();

      emit(
        (state as ProgressLoaded).copyWith(
          measurementCards: cards,
          statistics: stats,
        ),
      );

      // Check for celebration after refresh
      _checkAndCelebrate(cards);
    } catch (e) {
      debugPrint('⚠️ Refresh failed: $e');
    }
  }

  /// Switch card type in progress screen
  void switchCardType(MeasurementCardType type) {
    if (state is ProgressLoaded) {
      emit((state as ProgressLoaded).copyWith(selectedCardType: type));
    }
  }

  /// Dismiss celebration overlay
  void dismissCelebration() {
    if (state is ProgressLoaded) {
      emit((state as ProgressLoaded).copyWith(shouldShowCelebration: false));
    }
  }

  // ========== CHART SCREEN METHODS ==========

  /// Load measurement charts for history screen
  Future<void> loadMeasurementCharts({int days = 30}) async {
    try {
      emit(ChartLoading());
      final charts = await _repository.getMeasurementCharts(days: days);
      emit(
        ChartLoaded(
          charts: charts,
          selectedPeriod: TimePeriod.values.firstWhere(
            (p) => p.days == days,
            orElse: () => TimePeriod.month,
          ),
        ),
      );
    } catch (e) {
      emit(ChartError(e.toString()));
    }
  }

  /// Change time period in history screen
  void changeTimePeriod(TimePeriod period) {
    loadMeasurementCharts(days: period.days);
  }

  /// Change metric in history screen
  void changeMetric(MeasurementCardType metric) {
    if (state is ChartLoaded) {
      emit((state as ChartLoaded).copyWith(selectedMetric: metric));
    }
  }

  /// Change chart type in history screen
  void changeChartType(ChartType chartType) {
    if (state is ChartLoaded) {
      emit((state as ChartLoaded).copyWith(selectedChartType: chartType));
    }
  }

  // ========== ✅ EXERCISE PROGRESS METHODS ==========

  String? _currentExerciseId;

  /// Load exercise progress charts
  Future<void> loadExerciseProgress(
    String exerciseId, {
    TimePeriod period = TimePeriod.month,
  }) async {
    _currentExerciseId = exerciseId;
    emit(ExerciseProgressLoading());

    try {
      final response = await _repository.getExerciseProgress(
        exerciseId,
        days: period.days,
      );
      emit(
        ExerciseProgressLoaded(
          charts: response,
          selectedMetric: ExerciseMetricType.weight,
          selectedPeriod: period,
        ),
      );
    } catch (e) {
      emit(ExerciseProgressError(e.toString()));
    }
  }

  /// Change exercise metric
  void changeExerciseMetric(ExerciseMetricType metric) {
    if (state is ExerciseProgressLoaded) {
      final currentState = state as ExerciseProgressLoaded;
      emit(currentState.copyWith(selectedMetric: metric));
    }
  }

  /// Change exercise time period
  void changeExerciseTimePeriod(TimePeriod period) {
    if (state is ExerciseProgressLoaded && _currentExerciseId != null) {
      loadExerciseProgress(_currentExerciseId!, period: period);
    }
  }

  // ========== HELPER METHODS ==========

  /// Load statistics with error handling
  Future<StatisticsResponse?> _loadStatisticsSafely() async {
    try {
      return await _repository.getStatistics();
    } catch (e) {
      debugPrint('⚠️ Failed to load statistics: $e');
      return null;
    }
  }

  void changeExerciseChartType(ChartType chartType) {
    if (state is ExerciseProgressLoaded) {
      final currentState = state as ExerciseProgressLoaded;
      emit(currentState.copyWith(selectedChartType: chartType));
    }
  }

  // lib/features/progress/domain/cubits/progress_cubit.dart

  void _checkAndCelebrate(MeasurementCardsResponse cards) async {
    // Check if celebrations are disabled
    final isCelebrationDisabled =
        await CelebrationPrefs.isCelebrationDisabled();
    if (isCelebrationDisabled) {
      debugPrint('🔕 Celebrations disabled by user');
      return;
    }

    final weightCard = cards.weightCard;
    final weightChange = (weightCard.firstWeight - weightCard.lastWeight).abs();

    debugPrint('🏋️ Weight Change: ${weightChange.toStringAsFixed(1)}kg');

    if (weightChange >= 0.5) {
      if (weightCard.weightGoal != null) {
        final goal = weightCard.weightGoal!;
        final startToGoal = (weightCard.firstWeight - goal).abs();
        final currentToGoal = (weightCard.lastWeight - goal).abs();
        final progressPercent =
            ((startToGoal - currentToGoal) / startToGoal * 100).clamp(0, 100);

        final isGoodDirection = progressPercent > 0;

        // ✅ Get localized message
        final message = _getLocalizedCelebrationMessage(
          weightChange: weightChange,
          isGoodDirection: isGoodDirection,
        );

        Future.delayed(const Duration(milliseconds: 800), () {
          if (state is ProgressLoaded) {
            emit(
              (state as ProgressLoaded).copyWith(
                shouldShowCelebration: true,
                celebrationMessage: message,
                celebrationProgress: progressPercent.clamp(1, 100).toDouble(),
              ),
            );
          }
        });
      }
    }
  }

  // ✅ Helper method to get localized celebration message
  String _getLocalizedCelebrationMessage({
    required double weightChange,
    required bool isGoodDirection,
  }) {
    // Get current locale
    final locale = Intl.getCurrentLocale();
    final isArabic = locale.startsWith('ar');

    if (isGoodDirection) {
      if (isArabic) {
        return '🎯 تحديث الوزن!\nتغير وزنك ${weightChange.toStringAsFixed(1)} كجم!';
      } else {
        return '🎯 Weight Update!\nYou changed ${weightChange.toStringAsFixed(1)}kg!';
      }
    } else {
      if (isArabic) {
        return '📊 تم تسجيل الوزن!\nتم تسجيل تغيير ${weightChange.toStringAsFixed(1)} كجم!';
      } else {
        return '📊 Weight Tracked!\n${weightChange.toStringAsFixed(1)}kg change recorded!';
      }
    }
  }

  /// Get appropriate message based on progress
  String _getWeightMessage(double progress) {
    if (progress >= 100) {
      return '🏆 Goal Achieved!\nYou reached your target weight!';
    } else if (progress >= 75) {
      return '🔥 Almost There!\n${progress.toStringAsFixed(0)}% to your goal!';
    } else if (progress >= 50) {
      return '💪 Halfway Point!\nKeep pushing forward!';
    } else if (progress >= 25) {
      return '⭐ Great Progress!\nYou\'re on the right track!';
    } else if (progress >= 10) {
      return '🎯 Nice Start!\nEvery step counts!';
    } else {
      return '🚀 Progress Made!\nYou\'re moving toward your goal!';
    }
  }
}
