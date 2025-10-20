import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/workout_session_model.dart';
import '../../domain/repositories/workout_repository.dart';
import 'workouts_state.dart';

// class WorkoutsCubit extends Cubit<WorkoutsState> {
//   final WorkoutRepository repository;
//   WorkoutSessionModel? _currentSession;
//
//   WorkoutsCubit({required this.repository}) : super(WorkoutsInitial());
//
//   Future<void> createWorkoutSession({
//     required DateTime date,
//     String? notes,
//   }) async {
//     await _executeWithLoading(() async {
//       final sessionId = await repository.createSession(
//         date: date,
//         notes: notes,
//       );
//       await loadSessionById(sessionId);
//       await loadWorkoutHistory();
//     });
//   }
//
//   // ✅ Module 2: Session Loading
//   Future<void> loadWorkoutHistory({
//     int pageSize = 20,
//     int pageNumber = 1,
//     DateTime? toDate,
//   }) async {
//     await _executeWithLoading(() async {
//       final sessions = await repository.getWorkoutHistory(
//         pageSize: pageSize,
//         pageNumber: pageNumber,
//         toDate: toDate,
//       );
//       emit(WorkoutHistoryLoaded(sessions));
//     });
//   }
//
//   Future<void> loadSessionById(String sessionId) async {
//     await _executeWithLoading(() async {
//       final session = await repository.getSessionById(sessionId);
//       _currentSession = session; // ✅ Cache it
//       emit(WorkoutSessionLoaded(session));
//     });
//   }
//
//   // ✅ Module 3: Exercise Management
//   Future<void> addExerciseToWorkout({
//     required String sessionId,
//     String? exerciseId,
//     String? customExerciseId,
//   }) async {
//     try {
//       // ✅ Emit updating state instead of loading
//       if (_currentSession != null) {
//         emit(WorkoutsUpdating(_currentSession!));
//       } else {
//         emit(WorkoutsLoading());
//       }
//
//       final workoutExercise = await repository.addExerciseToWorkout(
//         sessionId: sessionId,
//         exerciseId: exerciseId,
//         customExerciseId: customExerciseId,
//       );
//
//       emit(ExerciseAddedToWorkout(workoutExercise));
//       await Future.delayed(const Duration(milliseconds: 100));
//       await loadSessionById(sessionId);
//     } catch (e) {
//       emit(WorkoutsError(e.toString()));
//     }
//   }
//
//   // ✅ Module 4: Session Control (NO LOADING STATE)
//   Future<void> startWorkoutSession(String sessionId) async {
//     try {
//       // ✅ DON'T emit loading - just perform action
//       await repository.startWorkoutSession(sessionId);
//
//       // ✅ Reload session silently
//       final session = await repository.getSessionById(sessionId);
//       _currentSession = session;
//
//       // ✅ Emit success state with updated data
//       emit(WorkoutSessionStarted(session));
//     } catch (e) {
//       emit(WorkoutsError(e.toString()));
//     }
//   }
//
//   // Future<void> completeWorkoutSession(String sessionId, String? notes) async {
//   //   try {
//   //     // ✅ DON'T emit loading - just perform action
//   //     await repository.completeWorkoutSession(sessionId, notes);
//   //
//   //     emit(WorkoutSessionCompleted());
//   //
//   //     // ✅ Reload history after completion
//   //     await Future.delayed(const Duration(milliseconds: 100));
//   //     await loadWorkoutHistory();
//   //   } catch (e) {
//   //     emit(WorkoutsError(e.toString()));
//   //   }
//   // }
//   Future<void> completeWorkoutSession(String sessionId, String? notes) async {
//     try {
//       // ✅ Complete the workout
//       await repository.completeWorkoutSession(sessionId, notes);
//
//       emit(WorkoutSessionCompleted());
//
//       // ✅ Reload the specific session to update cache with completed status
//       await Future.delayed(const Duration(milliseconds: 100));
//
//       // ✅ Reload both session and history
//       await loadSessionById(sessionId);
//       await loadWorkoutHistory();
//     } catch (e) {
//       emit(WorkoutsError(e.toString()));
//     }
//   }
//
//   // ✅ Module 5: Set Management
//   Future<void> addSetToExercise({
//     required String sessionId,
//     required String exerciseId,
//     required int reps,
//     required double weightKg,
//     int? restTimeSeconds,
//     String? notes,
//     required int setNumber,
//   }) async {
//     try {
//       // ✅ Use updating state instead of loading
//       if (_currentSession != null) {
//         emit(WorkoutsUpdating(_currentSession!));
//       } else {
//         emit(WorkoutsLoading());
//       }
//
//       final exerciseSet = await repository.addSetToExercise(
//         sessionId: sessionId,
//         exerciseId: exerciseId,
//         reps: reps,
//         weightKg: weightKg,
//         restTimeSeconds: restTimeSeconds,
//         notes: notes,
//         setNumber: setNumber,
//       );
//
//       emit(SetAddedToExercise(exerciseSet));
//       await Future.delayed(const Duration(milliseconds: 100));
//
//       // ✅ Reload session
//       final session = await repository.getSessionById(sessionId);
//       _currentSession = session;
//       emit(WorkoutSessionLoaded(session));
//     } catch (e) {
//       emit(WorkoutsError(e.toString()));
//     }
//   }
//
//   Future<void> updateExerciseSet({
//     required String sessionId,
//     required String exerciseId,
//     required String setId,
//     required int setNumber,
//     required int reps,
//     required double weightKg,
//     int? restTimeSeconds,
//     String? notes,
//     bool? isCompleted,
//     bool? isPersonalRecord,
//   }) async {
//     try {
//       // ✅ Use updating state instead of loading
//       if (_currentSession != null) {
//         emit(WorkoutsUpdating(_currentSession!));
//       } else {
//         emit(WorkoutsLoading());
//       }
//
//       await repository.updateExerciseSet(
//         sessionId: sessionId,
//         exerciseId: exerciseId,
//         setId: setId,
//         setNumber: setNumber,
//         reps: reps,
//         weightKg: weightKg,
//         restTimeSeconds: restTimeSeconds,
//         notes: notes,
//         isCompleted: isCompleted,
//         isPersonalRecord: isPersonalRecord,
//       );
//
//       emit(SetUpdated());
//       await Future.delayed(const Duration(milliseconds: 100));
//
//       // ✅ Reload session
//       final session = await repository.getSessionById(sessionId);
//       _currentSession = session;
//       emit(WorkoutSessionLoaded(session));
//     } catch (e) {
//       emit(WorkoutsError(e.toString()));
//     }
//   }
//
//   // ✅ Helper Methods (Private)
//   Future<void> _executeWithLoading(Future<void> Function() action) async {
//     try {
//       emit(WorkoutsLoading());
//       await action();
//     } catch (e) {
//       emit(WorkoutsError(e.toString()));
//     }
//   }
// }

class WorkoutsCubit extends Cubit<WorkoutsState> {
  final WorkoutRepository repository;
  WorkoutSessionModel? _currentSession;

  WorkoutsCubit({required this.repository}) : super(WorkoutsInitial());

  // ✅ Module 1: Session Creation
  Future<void> createWorkoutSession({
    required DateTime date,
    String? notes,
  }) async {
    emit(WorkoutsLoading());

    final result = await repository.createSession(date: date, notes: notes);

    result.fold((failure) => emit(WorkoutsError(failure.errorMessage)), (
      sessionId,
    ) async {
      await loadSessionById(sessionId);
      await loadWorkoutHistory();
    });
  }

  // ✅ Module 2: Session Loading
  Future<void> loadWorkoutHistory({
    int pageSize = 20,
    int pageNumber = 1,
    DateTime? toDate,
  }) async {
    emit(WorkoutsLoading());

    final result = await repository.getWorkoutHistory(
      pageSize: pageSize,
      pageNumber: pageNumber,
      toDate: toDate,
    );

    result.fold(
      (failure) => emit(WorkoutsError(failure.errorMessage)),
      (sessions) => emit(WorkoutHistoryLoaded(sessions)),
    );
  }

  Future<void> loadSessionById(String sessionId) async {
    emit(WorkoutsLoading());

    final result = await repository.getSessionById(sessionId);

    result.fold((failure) => emit(WorkoutsError(failure.errorMessage)), (
      session,
    ) {
      _currentSession = session;
      emit(WorkoutSessionLoaded(session));
    });
  }

  // ✅ Module 3: Exercise Management
  Future<void> addExerciseToWorkout({
    required String sessionId,
    String? exerciseId,
    String? customExerciseId,
  }) async {
    // Emit updating state instead of loading
    if (_currentSession != null) {
      emit(WorkoutsUpdating(_currentSession!));
    } else {
      emit(WorkoutsLoading());
    }

    final result = await repository.addExerciseToWorkout(
      sessionId: sessionId,
      exerciseId: exerciseId,
      customExerciseId: customExerciseId,
    );

    result.fold((failure) => emit(WorkoutsError(failure.errorMessage)), (
      workoutExercise,
    ) async {
      emit(ExerciseAddedToWorkout(workoutExercise));
      await Future.delayed(const Duration(milliseconds: 100));
      await loadSessionById(sessionId);
    });
  }

  // ✅ Module 4: Session Control
  Future<void> startWorkoutSession(String sessionId) async {
    final result = await repository.startWorkoutSession(sessionId);

    await result.fold(
      (failure) async {
        emit(WorkoutsError(failure.errorMessage));
      },
      (_) async {
        // Reload session silently
        final sessionResult = await repository.getSessionById(sessionId);

        sessionResult.fold(
          (failure) => emit(WorkoutsError(failure.errorMessage)),
          (session) {
            _currentSession = session;
            emit(WorkoutSessionStarted(session));
          },
        );
      },
    );
  }

  Future<void> completeWorkoutSession(String sessionId, String? notes) async {
    final result = await repository.completeWorkoutSession(sessionId, notes);

    await result.fold(
      (failure) async {
        emit(WorkoutsError(failure.errorMessage));
      },
      (_) async {
        emit(WorkoutSessionCompleted());

        await Future.delayed(const Duration(milliseconds: 100));

        // Reload both session and history
        await loadSessionById(sessionId);
        await loadWorkoutHistory();
      },
    );
  }

  // ✅ Module 5: Set Management
  Future<void> addSetToExercise({
    required String sessionId,
    required String exerciseId,
    required int reps,
    required double weightKg,
    int? restTimeSeconds,
    String? notes,
    required int setNumber,
  }) async {
    // Use updating state instead of loading
    if (_currentSession != null) {
      emit(WorkoutsUpdating(_currentSession!));
    } else {
      emit(WorkoutsLoading());
    }

    final result = await repository.addSetToExercise(
      sessionId: sessionId,
      exerciseId: exerciseId,
      reps: reps,
      weightKg: weightKg,
      restTimeSeconds: restTimeSeconds,
      notes: notes,
      setNumber: setNumber,
    );

    await result.fold(
      (failure) async {
        emit(WorkoutsError(failure.errorMessage));
      },
      (exerciseSet) async {
        emit(SetAddedToExercise(exerciseSet));
        await Future.delayed(const Duration(milliseconds: 100));

        // Reload session
        final sessionResult = await repository.getSessionById(sessionId);

        sessionResult.fold(
          (failure) => emit(WorkoutsError(failure.errorMessage)),
          (session) {
            _currentSession = session;
            emit(WorkoutSessionLoaded(session));
          },
        );
      },
    );
  }

  Future<void> updateExerciseSet({
    required String sessionId,
    required String exerciseId,
    required String setId,
    required int setNumber,
    required int reps,
    required double weightKg,
    int? restTimeSeconds,
    String? notes,
    bool? isCompleted,
    bool? isPersonalRecord,
  }) async {
    // Use updating state instead of loading
    if (_currentSession != null) {
      emit(WorkoutsUpdating(_currentSession!));
    } else {
      emit(WorkoutsLoading());
    }

    final result = await repository.updateExerciseSet(
      sessionId: sessionId,
      exerciseId: exerciseId,
      setId: setId,
      setNumber: setNumber,
      reps: reps,
      weightKg: weightKg,
      restTimeSeconds: restTimeSeconds,
      notes: notes,
      isCompleted: isCompleted,
      isPersonalRecord: isPersonalRecord,
    );

    await result.fold(
      (failure) async {
        emit(WorkoutsError(failure.errorMessage));
      },
      (_) async {
        emit(SetUpdated());
        await Future.delayed(const Duration(milliseconds: 100));

        // Reload session
        final sessionResult = await repository.getSessionById(sessionId);

        sessionResult.fold(
          (failure) => emit(WorkoutsError(failure.errorMessage)),
          (session) {
            _currentSession = session;
            emit(WorkoutSessionLoaded(session));
          },
        );
      },
    );
  }
}
