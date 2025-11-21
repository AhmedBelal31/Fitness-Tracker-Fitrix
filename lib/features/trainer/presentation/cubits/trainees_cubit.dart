// lib/features/trainer/presentation/cubits/trainees_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/trainer_repository.dart';
import 'trainees_states.dart';

class TraineesCubit extends Cubit<TraineesState> {
  final TrainerRepository _repository;

  TraineesCubit(this._repository) : super(TraineesInitial());

  Future<void> loadTrainees() async {
    emit(TraineesLoading());
    final result = await _repository.getTrainees();
    result.fold(
      (failure) => emit(TraineesError(failure.errorMessage)),
      (trainees) => emit(TraineesLoaded(trainees)),
    );
  }

  Future<void> removeTrainee(String traineeId) async {
    final result = await _repository.removeTrainee(traineeId);
    result.fold(
      (failure) => emit(TraineesError(failure.errorMessage)),
      (_) => loadTrainees(),
    );
  }
}
