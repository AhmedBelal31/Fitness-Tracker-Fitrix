import 'package:equatable/equatable.dart';
import '../../data/achievements_models.dart';

abstract class AchievementsState extends Equatable {
  const AchievementsState();

  @override
  List<Object?> get props => [];
}

// Initial State
class AchievementsInitial extends AchievementsState {
  const AchievementsInitial();
}

// Loading State
class AchievementsLoading extends AchievementsState {
  const AchievementsLoading();
}

// Loaded State
class AchievementsLoaded extends AchievementsState {
  final AchievementsResponse achievements;

  const AchievementsLoaded(this.achievements);

  @override
  List<Object?> get props => [achievements];
}

// Error State
class AchievementsError extends AchievementsState {
  final String message;

  const AchievementsError(this.message);

  @override
  List<Object?> get props => [message];
}

// Refreshing State (for pull-to-refresh)
class AchievementsRefreshing extends AchievementsState {
  final AchievementsResponse currentAchievements;

  const AchievementsRefreshing(this.currentAchievements);

  @override
  List<Object?> get props => [currentAchievements];
}

// Empty State
class AchievementsEmpty extends AchievementsState {
  final String message;

  const AchievementsEmpty(this.message);

  @override
  List<Object?> get props => [message];
}
