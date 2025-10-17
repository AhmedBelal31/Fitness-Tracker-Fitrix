import 'exercise_set_entity.dart';

class WorkoutExerciseEntity {
  final String id;
  final String workoutSessionId;
  final String? exerciseId;
  final String? exerciseName;
  final String? userExerciseId;
  final String? userExerciseName;
  final String clientProfileId;
  final List<ExerciseSetEntity> sets;

  WorkoutExerciseEntity({
    required this.id,
    required this.workoutSessionId,
    this.exerciseId,
    this.exerciseName,
    this.userExerciseId,
    this.userExerciseName,
    required this.clientProfileId,
    required this.sets,
  });

  // ✅ Helper to get display name
  String get displayName =>
      exerciseName ?? userExerciseName ?? 'Unknown Exercise';

  bool get isCustomExercise => userExerciseId != null;
}
