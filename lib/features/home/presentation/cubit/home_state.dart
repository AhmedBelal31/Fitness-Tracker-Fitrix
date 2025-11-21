import 'package:equatable/equatable.dart';
import '../../data/dashboard_model.dart';
import '../../data/trainee_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

// Initial State
class HomeInitial extends HomeState {
  const HomeInitial();
}

// Loading State
class HomeLoading extends HomeState {
  const HomeLoading();
}

// User Dashboard Loaded State
class HomeLoaded extends HomeState {
  final DashboardModel dashboard;

  const HomeLoaded(this.dashboard);

  @override
  List<Object?> get props => [dashboard];
}

// Trainees Loaded State (for Trainers)
class TraineesLoaded extends HomeState {
  final List<TraineeModel> trainees;

  const TraineesLoaded(this.trainees);

  @override
  List<Object?> get props => [trainees];
}

// Error State
class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}

// Refreshing State (for pull-to-refresh without blocking UI)
class HomeRefreshing extends HomeState {
  final DashboardModel? currentDashboard;
  final List<TraineeModel>? currentTrainees;

  const HomeRefreshing({this.currentDashboard, this.currentTrainees});

  @override
  List<Object?> get props => [currentDashboard, currentTrainees];
}

// Empty State
class HomeEmpty extends HomeState {
  final String message;

  const HomeEmpty(this.message);

  @override
  List<Object?> get props => [message];
}
