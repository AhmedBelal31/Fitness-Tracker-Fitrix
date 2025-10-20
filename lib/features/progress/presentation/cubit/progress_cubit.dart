import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/measurement_chart_models.dart';
import '../../data/models/progress_models.dart';
import '../../data/models/statistics_model.dart';
import '../../domain/progress_repository.dart';
import '../widgets/goal_progress_helper.dart';
import 'progress_state.dart';

// class ProgressCubit extends Cubit<ProgressState> {
//   final ProgressRepository repository;
//
//   ProgressCubit({required this.repository}) : super(ProgressInitial());
//
//   Future<void> loadMeasurementCards() async {
//     emit(ProgressLoading());
//
//     try {
//       // Load measurement cards
//       final cards = await repository.getMeasurementCards();
//
//       // Load statistics
//       StatisticsResponse? stats;
//       try {
//         stats = await repository.getStatistics();
//       } catch (e) {
//         debugPrint('⚠️ Failed to load statistics: $e');
//         // Continue without statistics
//       }
//
//       emit(
//         ProgressLoaded(
//           measurementCards: cards,
//           selectedCardType: MeasurementCardType.weight,
//           statistics: stats, // ✅ Pass statistics
//         ),
//       );
//     } catch (e) {
//       emit(ProgressError('Failed to load progress data: $e'));
//     }
//   }
//
//   Future<void> refreshData() async {
//     if (state is! ProgressLoaded) return;
//
//     try {
//       final cards = await repository.getMeasurementCards();
//
//       StatisticsResponse? stats;
//       try {
//         stats = await repository.getStatistics();
//       } catch (e) {
//         debugPrint('⚠️ Failed to refresh statistics: $e');
//       }
//
//       emit(
//         (state as ProgressLoaded).copyWith(
//           measurementCards: cards,
//           statistics: stats, // ✅ Update statistics
//         ),
//       );
//     } catch (e) {
//       // Keep current state on refresh error
//       debugPrint('⚠️ Failed to refresh: $e');
//     }
//   }
//   // Future<void> loadMeasurementCards() async {
//   //   try {
//   //     emit(ProgressLoading());
//   //     final cards = await repository.getMeasurementCards();
//   //     emit(ProgressLoaded(measurementCards: cards));
//   //     _checkAndCelebrate(cards);
//   //   } catch (e) {
//   //     emit(ProgressError(e.toString()));
//   //   }
//   // }
//
//   // NEW: Load chart data
//   Future<void> loadMeasurementCharts({int days = 30}) async {
//     try {
//       emit(ChartLoading());
//       final charts = await repository.getMeasurementCharts(days: days);
//       emit(
//         ChartLoaded(
//           charts: charts,
//           selectedPeriod: TimePeriod.values.firstWhere(
//             (p) => p.days == days,
//             orElse: () => TimePeriod.month,
//           ),
//         ),
//       );
//     } catch (e) {
//       emit(ChartError(e.toString()));
//     }
//   }
//
//   // NEW: Change time period
//   void changeTimePeriod(TimePeriod period) {
//     loadMeasurementCharts(days: period.days);
//   }
//
//   // NEW: Change metric
//   void changeMetric(MeasurementCardType metric) {
//     if (state is ChartLoaded) {
//       emit((state as ChartLoaded).copyWith(selectedMetric: metric));
//     }
//   }
//
//   // NEW: Change chart type
//   void changeChartType(ChartType chartType) {
//     if (state is ChartLoaded) {
//       emit((state as ChartLoaded).copyWith(selectedChartType: chartType));
//     }
//   }
//
//   void switchCardType(MeasurementCardType type) {
//     if (state is ProgressLoaded) {
//       emit((state as ProgressLoaded).copyWith(selectedCardType: type));
//     }
//   }
//
//   // Future<void> refreshData() async {
//   //   await loadMeasurementCards();
//   // }
//
//   void dismissCelebration() {
//     if (state is ProgressLoaded) {
//       emit((state as ProgressLoaded).copyWith(shouldShowCelebration: false));
//     }
//   }
//
//   void _checkAndCelebrate(MeasurementCardsResponse cards) {
//     // Check weight progress
//     final weightProgress = GoalProgressHelper.calculateProgress(
//       startValue: cards.weightCard.firstWeight,
//       currentValue: cards.weightCard.lastWeight,
//       goalValue: cards.weightCard.weightGoal,
//       isPositiveGood: false,
//     );
//     print('🏋️ Weight Progress: ${weightProgress.toStringAsFixed(1)}%');
//     print('   Start: ${cards.weightCard.firstWeight}kg');
//     print('   Current: ${cards.weightCard.lastWeight}kg');
//     print('   Goal: ${cards.weightCard.weightGoal}kg');
//
//     // Check body fat progress
//     final bodyFatProgress = GoalProgressHelper.calculateProgress(
//       startValue: cards.bodyFatCard.firstBodyFat,
//       currentValue: cards.bodyFatCard.lastBodyFat,
//       goalValue: cards.bodyFatCard.bodyFatGoal,
//       isPositiveGood: false,
//     );
//     print('💧 Body Fat Progress: ${bodyFatProgress.toStringAsFixed(1)}%');
//     print('   Start: ${cards.bodyFatCard.firstBodyFat}%');
//     print('   Current: ${cards.bodyFatCard.lastBodyFat}%');
//     print('   Goal: ${cards.bodyFatCard.bodyFatGoal}%');
//
//     // Check muscle mass progress
//     final muscleProgress = GoalProgressHelper.calculateProgress(
//       startValue: cards.muscleMassCard.firstMuscleMass,
//       currentValue: cards.muscleMassCard.lastMuscleMass,
//       goalValue: cards.muscleMassCard.muscleMassGoal,
//       isPositiveGood: true,
//     );
//     print('💪 Muscle Mass Progress: ${muscleProgress.toStringAsFixed(1)}%');
//     print('   Start: ${cards.muscleMassCard.firstMuscleMass}kg');
//     print('   Current: ${cards.muscleMassCard.lastMuscleMass}kg');
//     print('   Goal: ${cards.muscleMassCard.muscleMassGoal}kg');
//
//     // Find the highest progress
//     final maxProgress = [
//       weightProgress,
//       bodyFatProgress,
//       muscleProgress,
//     ].reduce((a, b) => a > b ? a : b);
//
//     print('🎯 Max Progress: ${maxProgress.toStringAsFixed(1)}%');
//
//     // Celebrate if milestone reached
//     if (GoalProgressHelper.shouldCelebrate(maxProgress) ||
//         GoalProgressHelper.isGoalReached(maxProgress)) {
//       final message = GoalProgressHelper.getMilestoneMessage(maxProgress);
//
//       Future.delayed(const Duration(milliseconds: 800), () {
//         if (state is ProgressLoaded) {
//           emit(
//             (state as ProgressLoaded).copyWith(
//               shouldShowCelebration: true,
//               celebrationMessage: message,
//               celebrationProgress: maxProgress,
//             ),
//           );
//         }
//       });
//     }
//   }
//
//   // void switchCardType(MeasurementCardType type) {
//   //   if (state is ProgressLoaded) {
//   //     final currentState = state as ProgressLoaded;
//   //     emit(currentState.copyWith(selectedCardType: type));
//   //   }
//   // }
//   //
//   // Future<void> refreshData() async {
//   //   // ✅ Celebration will show again after refresh if milestone is met
//   //   await loadMeasurementCards();
//   // }
//   //
//   // void dismissCelebration() {
//   //   if (state is ProgressLoaded) {
//   //     final currentState = state as ProgressLoaded;
//   //     emit(currentState.copyWith(shouldShowCelebration: false));
//   //   }
//   // }
// }
import 'package:flutter/foundation.dart';

// class ProgressCubit extends Cubit<ProgressState> {
//   final ProgressRepository _repository;
//
//   ProgressCubit({required ProgressRepository repository})
//     : _repository = repository,
//       super(ProgressInitial());
//
//   // ========== PROGRESS SCREEN METHODS ==========
//
//   /// Load all progress data (cards + statistics)
//   Future<void> loadProgress() async {
//     emit(ProgressLoading());
//
//     try {
//       final cards = await _repository.getMeasurementCards();
//       final stats = await _loadStatisticsSafely();
//
//       emit(
//         ProgressLoaded(
//           measurementCards: cards,
//           selectedCardType: MeasurementCardType.weight,
//           statistics: stats,
//         ),
//       );
//     } catch (e) {
//       emit(ProgressError('Failed to load progress data: $e'));
//     }
//   }
//
//   /// Refresh progress data
//   Future<void> refreshData() async {
//     if (state is! ProgressLoaded) return;
//
//     try {
//       final cards = await _repository.getMeasurementCards();
//       final stats = await _loadStatisticsSafely();
//
//       emit(
//         (state as ProgressLoaded).copyWith(
//           measurementCards: cards,
//           statistics: stats,
//         ),
//       );
//     } catch (e) {
//       debugPrint('⚠️ Refresh failed: $e');
//     }
//   }
//
//   /// Switch card type in progress screen
//   void switchCardType(MeasurementCardType type) {
//     if (state is ProgressLoaded) {
//       emit((state as ProgressLoaded).copyWith(selectedCardType: type));
//     }
//   }
//
//   /// Dismiss celebration overlay
//   void dismissCelebration() {
//     if (state is ProgressLoaded) {
//       emit((state as ProgressLoaded).copyWith(shouldShowCelebration: false));
//     }
//   }
//
//   // ========== CHART SCREEN METHODS ==========
//
//   /// Load measurement charts for history screen
//   Future<void> loadMeasurementCharts({int days = 30}) async {
//     try {
//       emit(ChartLoading());
//       final charts = await _repository.getMeasurementCharts(days: days);
//       emit(
//         ChartLoaded(
//           charts: charts,
//           selectedPeriod: TimePeriod.values.firstWhere(
//             (p) => p.days == days,
//             orElse: () => TimePeriod.month,
//           ),
//         ),
//       );
//     } catch (e) {
//       emit(ChartError(e.toString()));
//     }
//   }
//
//   /// Change time period in history screen
//   void changeTimePeriod(TimePeriod period) {
//     loadMeasurementCharts(days: period.days);
//   }
//
//   /// Change metric in history screen
//   void changeMetric(MeasurementCardType metric) {
//     if (state is ChartLoaded) {
//       emit((state as ChartLoaded).copyWith(selectedMetric: metric));
//     }
//   }
//
//   /// Change chart type in history screen
//   void changeChartType(ChartType chartType) {
//     if (state is ChartLoaded) {
//       emit((state as ChartLoaded).copyWith(selectedChartType: chartType));
//     }
//   }
//
//   // ========== PRIVATE HELPERS ==========
//
//   /// Load statistics with error handling
//   Future<StatisticsResponse?> _loadStatisticsSafely() async {
//     try {
//       return await _repository.getStatistics();
//     } catch (e) {
//       debugPrint('⚠️ Failed to load statistics: $e');
//       return null;
//     }
//   }
// }
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

      // ✅ Check for celebration after loading
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

      // ✅ Check for celebration after refresh
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

  // ========== PRIVATE HELPERS ==========

  /// Load statistics with error handling
  Future<StatisticsResponse?> _loadStatisticsSafely() async {
    try {
      return await _repository.getStatistics();
    } catch (e) {
      debugPrint('⚠️ Failed to load statistics: $e');
      return null;
    }
  }

  /// ✅ Check progress and trigger celebration
  // void _checkAndCelebrate(MeasurementCardsResponse cards) {
  //   // Check weight progress
  //   final weightProgress = GoalProgressHelper.calculateProgress(
  //     startValue: cards.weightCard.firstWeight,
  //     currentValue: cards.weightCard.lastWeight,
  //     goalValue: cards.weightCard.weightGoal,
  //     isPositiveGood: false,
  //   );
  //   debugPrint('🏋️ Weight Progress: ${weightProgress.toStringAsFixed(1)}%');
  //   debugPrint('   Start: ${cards.weightCard.firstWeight}kg');
  //   debugPrint('   Current: ${cards.weightCard.lastWeight}kg');
  //   debugPrint('   Goal: ${cards.weightCard.weightGoal}kg');
  //
  //   // Check body fat progress
  //   final bodyFatProgress = GoalProgressHelper.calculateProgress(
  //     startValue: cards.bodyFatCard.firstBodyFat,
  //     currentValue: cards.bodyFatCard.lastBodyFat,
  //     goalValue: cards.bodyFatCard.bodyFatGoal,
  //     isPositiveGood: false,
  //   );
  //   debugPrint('💧 Body Fat Progress: ${bodyFatProgress.toStringAsFixed(1)}%');
  //   debugPrint('   Start: ${cards.bodyFatCard.firstBodyFat}%');
  //   debugPrint('   Current: ${cards.bodyFatCard.lastBodyFat}%');
  //   debugPrint('   Goal: ${cards.bodyFatCard.bodyFatGoal}%');
  //
  //   // Check muscle mass progress
  //   final muscleProgress = GoalProgressHelper.calculateProgress(
  //     startValue: cards.muscleMassCard.firstMuscleMass,
  //     currentValue: cards.muscleMassCard.lastMuscleMass,
  //     goalValue: cards.muscleMassCard.muscleMassGoal,
  //     isPositiveGood: true,
  //   );
  //   debugPrint(
  //     '💪 Muscle Mass Progress: ${muscleProgress.toStringAsFixed(1)}%',
  //   );
  //   debugPrint('   Start: ${cards.muscleMassCard.firstMuscleMass}kg');
  //   debugPrint('   Current: ${cards.muscleMassCard.lastMuscleMass}kg');
  //   debugPrint('   Goal: ${cards.muscleMassCard.muscleMassGoal}kg');
  //
  //   // Find the highest progress
  //   final maxProgress = [
  //     weightProgress,
  //     bodyFatProgress,
  //     muscleProgress,
  //   ].reduce((a, b) => a > b ? a : b);
  //
  //   debugPrint('🎯 Max Progress: ${maxProgress.toStringAsFixed(1)}%');
  //
  //   // Celebrate if milestone reached
  //   if (GoalProgressHelper.shouldCelebrate(maxProgress) ||
  //       GoalProgressHelper.isGoalReached(maxProgress)) {
  //     final message = GoalProgressHelper.getMilestoneMessage(maxProgress);
  //
  //     Future.delayed(const Duration(milliseconds: 800), () {
  //       if (state is ProgressLoaded) {
  //         emit(
  //           (state as ProgressLoaded).copyWith(
  //             shouldShowCelebration: true,
  //             celebrationMessage: message,
  //             celebrationProgress: maxProgress,
  //           ),
  //         );
  //       }
  //     });
  //   }
  // }

  /// ✅ Check ONLY weight progress and celebrate ANY change toward goal
  // void _checkAndCelebrate(MeasurementCardsResponse cards) {
  //   final weightCard = cards.weightCard;
  //
  //   // Calculate absolute change from start
  //   final weightChange = (weightCard.firstWeight - weightCard.lastWeight).abs();
  //
  //   debugPrint('🏋️ Weight Change: ${weightChange.toStringAsFixed(1)}kg');
  //   debugPrint('   Start: ${weightCard.firstWeight}kg');
  //   debugPrint('   Current: ${weightCard.lastWeight}kg');
  //   debugPrint('   Goal: ${weightCard.weightGoal}kg');
  //
  //   // ✅ Celebrate if ANY weight change (> 0.5kg)
  //   if (weightChange >= 0.5) {
  //     // Calculate progress toward goal (for percentage display)
  //     final startToGoal = (weightCard.firstWeight - weightCard.weightGoal)
  //         .abs();
  //     final currentToGoal = (weightCard.lastWeight - weightCard.weightGoal)
  //         .abs();
  //     final progressPercent =
  //         ((startToGoal - currentToGoal) / startToGoal * 100).clamp(0, 100);
  //
  //     final isGoodDirection = progressPercent > 0;
  //     final message = isGoodDirection
  //         ? '🎯 Weight Update!\nYou changed ${weightChange.toStringAsFixed(1)}kg!'
  //         : '📊 Weight Tracked!\n${weightChange.toStringAsFixed(1)}kg change recorded!';
  //
  //     debugPrint('🎉 WEIGHT CHANGE CELEBRATION: $message');
  //
  //     Future.delayed(const Duration(milliseconds: 800), () {
  //       if (state is ProgressLoaded) {
  //         emit(
  //           (state as ProgressLoaded).copyWith(
  //             shouldShowCelebration: true,
  //             celebrationMessage: message,
  //             celebrationProgress: progressPercent
  //                 .clamp(1, 100)
  //                 .toDouble(), // Show at least 1% for visual
  //           ),
  //         );
  //       }
  //     });
  //   } else {
  //     debugPrint(
  //       '⚠️ No celebration: Weight change is only ${weightChange.toStringAsFixed(1)}kg',
  //     );
  //   }
  // }
  void _checkAndCelebrate(MeasurementCardsResponse cards) {
    final weightCard = cards.weightCard;

    // Calculate absolute change from start
    final weightChange = (weightCard.firstWeight - weightCard.lastWeight).abs();

    debugPrint('🏋️ Weight Change: ${weightChange.toStringAsFixed(1)}kg');
    debugPrint('   Start: ${weightCard.firstWeight}kg');
    debugPrint('   Current: ${weightCard.lastWeight}kg');
    debugPrint('   Goal: ${weightCard.weightGoal}kg');

    // ✅ Celebrate if ANY weight change (> 0.5kg)
    if (weightChange >= 0.5) {
      // Check if goal exists before calculating progress
      if (weightCard.weightGoal != null) {
        final goal = weightCard.weightGoal!; // Safe unwrap
        final startToGoal = (weightCard.firstWeight - goal).abs();
        final currentToGoal = (weightCard.lastWeight - goal).abs();
        final progressPercent =
            ((startToGoal - currentToGoal) / startToGoal * 100).clamp(0, 100);

        final isGoodDirection = progressPercent > 0;
        final message = isGoodDirection
            ? '🎯 Weight Update!\nYou changed ${weightChange.toStringAsFixed(1)}kg!'
            : '📊 Weight Tracked!\n${weightChange.toStringAsFixed(1)}kg change recorded!';

        debugPrint('🎉 WEIGHT CHANGE CELEBRATION: $message');

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
      } else {
        // No goal set, just celebrate the change
        final message =
            '📊 Weight Tracked!\n${weightChange.toStringAsFixed(1)}kg change recorded!';

        debugPrint('🎉 WEIGHT CHANGE (No Goal): $message');

        Future.delayed(const Duration(milliseconds: 800), () {
          if (state is ProgressLoaded) {
            emit(
              (state as ProgressLoaded).copyWith(
                shouldShowCelebration: true,
                celebrationMessage: message,
                celebrationProgress: 50.0, // Show 50% when no goal
              ),
            );
          }
        });
      }
    } else {
      debugPrint(
        '⚠️ No celebration: Weight change is only ${weightChange.toStringAsFixed(1)}kg',
      );
    }
  }

  /// ✅ Get appropriate message based on progress
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
