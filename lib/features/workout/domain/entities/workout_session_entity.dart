import 'workout_exercise_entity.dart';

class WorkoutSessionEntity {
  final String id;
  final String clientProfileId;
  final String? createdByTrainerId;
  final DateTime date;
  final DateTime? startTime;
  final DateTime? endTime;
  final bool isCompleted;
  final int? durationMinutes;
  final String? notes;
  final List<WorkoutExerciseEntity> workoutExercises;

  WorkoutSessionEntity({
    required this.id,
    required this.clientProfileId,
    this.createdByTrainerId,
    required this.date,
    this.startTime,
    this.endTime,
    required this.isCompleted,
    this.durationMinutes,
    this.notes,
    required this.workoutExercises,
  });
}
