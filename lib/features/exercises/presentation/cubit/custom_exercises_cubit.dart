import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/custom_exercise_request.dart';
import '../../domain/repositories/exercise_repository.dart';
import 'custom_exercises_state.dart';

class CustomExercisesCubit extends Cubit<CustomExercisesState> {
  final ExerciseRepository _repository;

  CustomExercisesCubit(this._repository) : super(CustomExercisesInitial());

  Future<void> loadCustomExercises({String? difficulty}) async {
    emit(CustomExercisesLoading());

    final result = await _repository.getCustomExercises(difficulty: difficulty);

    result.fold(
      (failure) => emit(CustomExercisesError(failure.errorMessage)),
      (exercises) => emit(CustomExercisesLoaded(exercises)),
    );
  }

  Future<void> createCustomExercise(CreateCustomExerciseRequest request) async {
    emit(CustomExercisesCreating());

    final result = await _repository.createCustomExercise(request);

    result.fold((failure) => emit(CustomExercisesError(failure.errorMessage)), (
      exercise,
    ) {
      emit(CustomExerciseCreated(exercise));
      loadCustomExercises(); // Reload list after creation
    });
  }

  Future<void> updateCustomExercise({
    required String exerciseId,
    required String sectionId,
    required UpdateCustomExerciseRequest request,
  }) async {
    final result = await _repository.updateCustomExercise(
      exerciseId,
      sectionId,
      request,
    );

    result.fold(
      (failure) => emit(CustomExercisesError(failure.errorMessage)),
      (_) => loadCustomExercises(), // Reload list after update
    );
  }

  Future<void> deleteCustomExercise(String exerciseId) async {
    final result = await _repository.deleteCustomExercise(exerciseId);

    result.fold(
      (failure) => emit(CustomExercisesError(failure.errorMessage)),
      (_) => loadCustomExercises(), // Reload list after deletion
    );
  }
}
