// lib/features/trainer/presentation/cubits/trainer_dashboard_state.dart
part of 'trainer_dashboard_cubit.dart';

abstract class TrainerDashboardState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TrainerDashboardInitial extends TrainerDashboardState {}

class TrainerDashboardLoading extends TrainerDashboardState {}

class TrainerDashboardLoaded extends TrainerDashboardState {
  final TrainerDashboardData dashboard;

  TrainerDashboardLoaded(this.dashboard);

  @override
  List<Object?> get props => [dashboard];
}

class TrainerDashboardError extends TrainerDashboardState {
  final String message;

  TrainerDashboardError(this.message);

  @override
  List<Object?> get props => [message];
}
