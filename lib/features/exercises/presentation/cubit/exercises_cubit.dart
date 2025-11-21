import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/exercise_model.dart';
import '../../domain/repositories/exercise_repository.dart';
import 'exercises_state.dart';

class ExercisesCubit extends Cubit<ExercisesState> {
  final ExerciseRepository _repository;

  ExercisesCubit(this._repository) : super(ExercisesInitial());

  Future<void> loadExercisesBySection({
    required String sectionId,
    String? searchTerm,
    String? difficulty,
  }) async {
    emit(ExercisesLoading());

    final result = await _repository.getExercisesBySection(
      sectionId: sectionId,
      searchTerm: searchTerm,
      difficulty: difficulty,
    );

    result.fold(
      (failure) => emit(ExercisesError(failure.errorMessage)),
      (exercises) => emit(ExercisesLoaded(exercises)),
    );
  }

  // Future<void> loadExerciseById(String exerciseId) async {
  //   emit(ExerciseDetailsLoading());
  //
  //   final result = await _repository.getExerciseById(exerciseId);
  //
  //   result.fold(
  //     (failure) => emit(ExercisesError(failure.errorMessage)),
  //     (exercise) => emit(ExerciseDetailsLoaded(exercise)),
  //   );
  // }

  Future<ExerciseModel?> getExerciseById(String exerciseId) async {
    try {
      return await _repository.getExerciseById(exerciseId);
    } catch (e) {
      return null;
    }
  }

  Future<ExerciseModel?> getCustomExerciseById(String customExerciseId) async {
    try {
      return await _repository.getCustomExerciseById(customExerciseId);
    } catch (e) {
      return null;
    }
  }
}
