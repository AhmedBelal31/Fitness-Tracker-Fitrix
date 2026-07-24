class StatisticsResponse {
  final int workoutsCount;
  final int customExercisesCount;
  final int recordsCount;
  final int daysSinceLastWorkout;
  final int daysSinceLastRecord;
  final double averageWorkoutDuration;
  final double averageWorkoutsPerWeek;
  final double personalBestWeight;
  final int personalBestReps;
  final double personalBestVolume;

  StatisticsResponse({
    required this.workoutsCount,
    required this.customExercisesCount,
    required this.recordsCount,
    required this.daysSinceLastWorkout,
    required this.daysSinceLastRecord,
    required this.averageWorkoutDuration,
    required this.averageWorkoutsPerWeek,
    required this.personalBestWeight,
    required this.personalBestReps,
    required this.personalBestVolume,
  });

  factory StatisticsResponse.fromJson(Map<String, dynamic> json) {
    return StatisticsResponse(
      workoutsCount: json['workoutsCount'] ?? 0,
      customExercisesCount: json['customExercisesCount'] ?? 0,
      recordsCount: json['recordsCount'] ?? 0,
      daysSinceLastWorkout: json['daysSinceLastWorkout'] ?? 0,
      daysSinceLastRecord: json['daysSinceLastRecord'] ?? 0,
      averageWorkoutDuration: (json['averageWorkoutDuration'] ?? 0).toDouble(),
      averageWorkoutsPerWeek: (json['averageWorkoutsPerWeek'] ?? 0).toDouble(),
      personalBestWeight: (json['personalBestWeight'] ?? 0).toDouble(),
      personalBestReps: json['personalBestReps'] ?? 0,
      personalBestVolume: (json['personalBestVolume'] ?? 0).toDouble(),
    );
  }
}
