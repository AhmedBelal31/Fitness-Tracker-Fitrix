import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/custom_exercise_request.dart';
import '../../data/models/exercise_model.dart';
import '../../domain/repositories/exercise_repository.dart';
import 'custom_exercises_state.dart';

// class CustomExercisesCubit extends Cubit<CustomExercisesState> {
//   final ExerciseRepository _repository;
//
//   CustomExercisesCubit(this._repository) : super(CustomExercisesInitial());
//
//   Future<void> loadCustomExercises({String? difficulty}) async {
//     emit(CustomExercisesLoading());
//
//     final result = await _repository.getCustomExercises(difficulty: difficulty);
//
//     result.fold(
//       (failure) => emit(CustomExercisesError(failure.errorMessage)),
//       (exercises) => emit(CustomExercisesLoaded(exercises)),
//     );
//   }
//
//   Future<void> createCustomExercise(CreateCustomExerciseRequest request) async {
//     emit(CustomExercisesCreating());
//
//     final result = await _repository.createCustomExercise(request);
//
//     result.fold((failure) => emit(CustomExercisesError(failure.errorMessage)), (
//       exercise,
//     ) {
//       emit(CustomExerciseCreated(exercise));
//       loadCustomExercises(); // Reload list after creation
//     });
//   }
//
//   Future<void> updateCustomExercise({
//     required String exerciseId,
//     required String sectionId,
//     required UpdateCustomExerciseRequest request,
//   }) async {
//     final result = await _repository.updateCustomExercise(
//       exerciseId,
//       sectionId,
//       request,
//     );
//
//     result.fold(
//       (failure) => emit(CustomExercisesError(failure.errorMessage)),
//       (_) => loadCustomExercises(), // Reload list after update
//     );
//   }
//
//   Future<void> deleteCustomExercise(String exerciseId) async {
//     // Keep current exercises while showing loading indicator
//     if (state is CustomExercisesLoaded) {
//       final currentExercises = (state as CustomExercisesLoaded).exercises;
//       emit(CustomExercisesDeleting(currentExercises));
//     }
//
//     final result = await _repository.deleteCustomExercise(exerciseId);
//
//     result.fold((failure) => emit(CustomExercisesError(failure.errorMessage)), (
//       _,
//     ) {
//       loadCustomExercises(); // Reload list after deletion
//     });
//   }
// }
// custom_exercises_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomExercisesCubit extends Cubit<CustomExercisesState> {
  final ExerciseRepository _repository;

  CustomExercisesCubit(this._repository) : super(CustomExercisesInitial());

  Future<void> loadCustomExercises() async {
    emit(CustomExercisesLoading());

    final result = await _repository.getCustomExercises();

    result.fold(
      (failure) => emit(CustomExercisesError(failure.errorMessage)),
      (exercises) => emit(CustomExercisesLoaded(exercises)),
    );
  }

  /// Create a new custom exercise
  Future<void> createCustomExercise(CreateCustomExerciseRequest request) async {
    emit(CustomExercisesCreating());

    final result = await _repository.createCustomExercise(request);

    result.fold((failure) => emit(CustomExercisesError(failure.errorMessage)), (
      exercise,
    ) {
      emit(CustomExerciseCreated(exercise));
      // Reload list after creation
      loadCustomExercises();
    });
  }

  /// Update an existing custom exercise
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

    result.fold((failure) => emit(CustomExercisesError(failure.errorMessage)), (
      _,
    ) {
      // Reload list after update
      loadCustomExercises();
    });
  }

  Future<void> deleteCustomExercise(String exerciseId) async {
    // Preserve current exercises during deletion
    List<ExerciseModel> currentExercises = [];

    if (state is CustomExercisesLoaded) {
      currentExercises = (state as CustomExercisesLoaded).exercises;
      emit(CustomExercisesDeleting(currentExercises));
    } else if (state is CustomExercisesError) {
      currentExercises = (state as CustomExercisesError).exercises ?? [];
      emit(CustomExercisesDeleting(currentExercises));
    }

    final result = await _repository.deleteCustomExercise(exerciseId);

    result.fold(
      (failure) {
        // Keep the list visible when deletion fails
        emit(
          CustomExercisesError(
            failure.errorMessage,
            exercises: currentExercises,
          ),
        );
      },
      (_) {
        // Only reload on successful deletion
        loadCustomExercises();
      },
    );
  }
}
