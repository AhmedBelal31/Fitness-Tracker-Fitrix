import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _repository;

  HomeCubit(this._repository) : super(const HomeInitial());

  /// Load User Dashboard
  Future<void> loadUserDashboard() async {
    emit(const HomeLoading());

    final result = await _repository.getUserDashboard();

    result.fold((failure) => emit(HomeError(failure.errorMessage)), (
      dashboard,
    ) {
      if (dashboard.recentWorkouts == null ||
          dashboard.recentWorkouts!.isEmpty) {
        // Dashboard loaded but no workouts
        emit(HomeLoaded(dashboard));
      } else {
        emit(HomeLoaded(dashboard));
      }
    });
  }

  /// Load Trainees (for Trainers)
  Future<void> loadTrainees() async {
    emit(const HomeLoading());

    final result = await _repository.getTrainees();

    result.fold((failure) => emit(HomeError(failure.errorMessage)), (trainees) {
      if (trainees.isEmpty) {
        emit(const HomeEmpty('No trainees found'));
      } else {
        emit(TraineesLoaded(trainees));
      }
    });
  }

  /// Refresh Dashboard (for pull-to-refresh)
  Future<void> refreshDashboard() async {
    // Keep current data visible while refreshing
    if (state is HomeLoaded) {
      final currentDashboard = (state as HomeLoaded).dashboard;
      emit(HomeRefreshing(currentDashboard: currentDashboard));
    } else {
      emit(const HomeLoading());
    }

    final result = await _repository.getUserDashboard();

    result.fold(
      (failure) => emit(HomeError(failure.errorMessage)),
      (dashboard) => emit(HomeLoaded(dashboard)),
    );
  }

  /// Refresh Trainees (for pull-to-refresh)
  Future<void> refreshTrainees() async {
    // Keep current data visible while refreshing
    if (state is TraineesLoaded) {
      final currentTrainees = (state as TraineesLoaded).trainees;
      emit(HomeRefreshing(currentTrainees: currentTrainees));
    } else {
      emit(const HomeLoading());
    }

    final result = await _repository.getTrainees();

    result.fold((failure) => emit(HomeError(failure.errorMessage)), (trainees) {
      if (trainees.isEmpty) {
        emit(const HomeEmpty('No trainees found'));
      } else {
        emit(TraineesLoaded(trainees));
      }
    });
  }

  /// Generic refresh method
  void refresh() {
    if (state is HomeLoaded || state is HomeRefreshing) {
      loadUserDashboard();
    } else if (state is TraineesLoaded) {
      loadTrainees();
    }
  }

  /// Reset to initial state
  void reset() {
    emit(const HomeInitial());
  }

  /// Load specific trainee dashboard
  Future<void> loadTraineeDashboard(String traineeId) async {
    emit(const HomeLoading());

    final result = await _repository.getTraineeDashboard(traineeId);

    result.fold(
      (failure) => emit(HomeError(failure.errorMessage)),
      (dashboard) => emit(HomeLoaded(dashboard)),
    );
  }
}
