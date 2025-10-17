import '../../data/workout_session_model.dart';

abstract class WorkoutRepository {
  Future<String> createSession({required DateTime date, String? notes});

  Future<List<WorkoutSessionModel>> getWorkoutHistory({
    int pageSize = 20,
    int pageNumber = 1,
    DateTime? toDate,
  });

  Future<WorkoutSessionModel> getSessionById(String sessionId);

  Future<WorkoutExerciseModel> addExerciseToWorkout({
    required String sessionId,
    String? exerciseId,
    String? customExerciseId,
  });

  Future<void> startWorkoutSession(String sessionId);

  Future<void> completeWorkoutSession(String sessionId, String? notes);

  Future<ExerciseSetModel> addSetToExercise({
    required String sessionId,
    required String exerciseId,
    required int setNumber,
    required int reps,
    required double weightKg,
    int? restTimeSeconds,
    String? notes,
  });

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
  });
}
