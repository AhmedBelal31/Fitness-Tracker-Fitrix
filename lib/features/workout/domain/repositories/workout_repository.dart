import 'package:dartz/dartz.dart';
import '../../../../core/networking/error/failures.dart';
import '../../data/workout_session_model.dart';

abstract class WorkoutRepository {
  Future<Either<Failure, String>> createSession({
    required DateTime date,
    String? notes,
  });

  Future<Either<Failure, WorkoutExerciseModel>> addExerciseToWorkout({
    required String sessionId,
    String? exerciseId,
    String? customExerciseId,
  });

  Future<Either<Failure, List<WorkoutSessionModel>>> getWorkoutHistory({
    int pageSize = 20,
    int pageNumber = 1,
    DateTime? toDate,
  });

  Future<Either<Failure, WorkoutSessionModel>> getSessionById(String sessionId);

  Future<Either<Failure, void>> startWorkoutSession(String sessionId);

  Future<Either<Failure, void>> completeWorkoutSession(
    String sessionId,
    String? notes,
  );

  Future<Either<Failure, ExerciseSetModel>> addSetToExercise({
    required String sessionId,
    required String exerciseId,
    required int setNumber,
    required int reps,
    required double weightKg,
    int? restTimeSeconds,
    String? notes,
  });

  Future<Either<Failure, void>> updateExerciseSet({
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
