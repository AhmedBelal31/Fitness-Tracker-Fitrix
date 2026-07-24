// lib/features/trainer/presentation/cubits/trainer_dashboard_cubit.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/trainee_data.dart';
import '../../data/models/trainer_dashboard_data.dart';
import '../../domain/repositories/trainer_repository.dart';

part 'trainer_dashboard_state.dart';

class TrainerDashboardCubit extends Cubit<TrainerDashboardState> {
  final TrainerRepository _repository;

  TrainerDashboardCubit(this._repository) : super(TrainerDashboardInitial());

  Future<void> loadDashboard() async {
    emit(TrainerDashboardLoading());
    final result = await _repository.getDashboard();
    result.fold(
      (failure) => emit(TrainerDashboardError(failure.errorMessage)),
      (dashboard) => emit(TrainerDashboardLoaded(dashboard)),
    );
  }

  Future<void> refresh() async {
    await loadDashboard();
  }
}
