// lib/features/trainer/presentation/cubits/trainee_details_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/trainee_data.dart';
import '../../domain/repositories/trainer_repository.dart';
part 'trainee_details_state.dart';

class TraineeDetailsCubit extends Cubit<TraineeDetailsState> {
  final TrainerRepository _repository;

  TraineeDetailsCubit(this._repository) : super(TraineeDetailsInitial());

  Future<void> loadTrainee(String traineeId) async {
    emit(TraineeDetailsLoading());
    final result = await _repository.getTrainee(traineeId);
    result.fold(
      (failure) => emit(TraineeDetailsError(failure.errorMessage)),
      (trainee) => emit(TraineeDetailsLoaded(trainee)),
    );
  }

  Future<void> refresh(String traineeId) async {
    await loadTrainee(traineeId);
  }
}
