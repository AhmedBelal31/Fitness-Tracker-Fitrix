// lib/features/trainer/presentation/cubits/trainee_progress_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/trainee_progress_data.dart';
import '../../domain/repositories/trainer_repository.dart';

part 'trainee_progress_state.dart';

class TraineeProgressCubit extends Cubit<TraineeProgressState> {
  final TrainerRepository _repository;

  TraineeProgressCubit(this._repository) : super(TraineeProgressInitial());

  Future<void> loadProgress({
    required String traineeId,
    int days = 30,
    String? sectionId,
  }) async {
    emit(TraineeProgressLoading());
    final result = await _repository.getTraineeProgress(
      traineeId: traineeId,
      days: days,
      sectionId: sectionId,
    );
    result.fold(
      (failure) => emit(TraineeProgressError(failure.errorMessage)),
      (progress) => emit(TraineeProgressLoaded(progress)),
    );
  }
}
