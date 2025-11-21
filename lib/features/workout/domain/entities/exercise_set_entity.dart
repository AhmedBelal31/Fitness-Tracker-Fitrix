class ExerciseSetEntity {
  final String id;
  final String workoutExerciseId;
  final int setNumber;
  final int reps;
  final double weightKg;
  final int? restTimeSeconds;
  final bool isCompleted;
  final bool isPersonalRecord;
  final String? notes;
  final DateTime createdAtUtc;

  ExerciseSetEntity({
    required this.id,
    required this.workoutExerciseId,
    required this.setNumber,
    required this.reps,
    required this.weightKg,
    this.restTimeSeconds,
    required this.isCompleted,
    required this.isPersonalRecord,
    this.notes,
    required this.createdAtUtc,
  });
}
