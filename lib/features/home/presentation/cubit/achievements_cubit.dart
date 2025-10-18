import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/achievements_repository.dart';
import 'achievements_state.dart';

class AchievementsCubit extends Cubit<AchievementsState> {
  final AchievementsRepository _repository;

  AchievementsCubit(this._repository) : super(const AchievementsInitial());

  /// Load Achievements
  Future<void> loadAchievements() async {
    emit(const AchievementsLoading());

    final result = await _repository.getAchievements();

    result.fold((failure) => emit(AchievementsError(failure.errorMessage)), (
      achievements,
    ) {
      if (achievements.milestones.isEmpty &&
          achievements.recentRecords.isEmpty) {
        emit(const AchievementsEmpty('No achievements yet. Keep working out!'));
      } else {
        emit(AchievementsLoaded(achievements));
      }
    });
  }

  /// Refresh Achievements (for pull-to-refresh)
  Future<void> refreshAchievements() async {
    // Keep current data visible while refreshing
    if (state is AchievementsLoaded) {
      final currentAchievements = (state as AchievementsLoaded).achievements;
      emit(AchievementsRefreshing(currentAchievements));
    } else {
      emit(const AchievementsLoading());
    }

    final result = await _repository.getAchievements();

    result.fold((failure) => emit(AchievementsError(failure.errorMessage)), (
      achievements,
    ) {
      if (achievements.milestones.isEmpty &&
          achievements.recentRecords.isEmpty) {
        emit(const AchievementsEmpty('No achievements yet. Keep working out!'));
      } else {
        emit(AchievementsLoaded(achievements));
      }
    });
  }

  /// Reset to initial state
  void reset() {
    emit(const AchievementsInitial());
  }
}
