class WorkoutStatsModel {
  final int totalWorkouts;
  final int thisMonth;
  final int lastMonth;
  final int averageDuration;
  final int completionRate;
  final List<String>? mostFrequentExercises;

  WorkoutStatsModel({
    required this.totalWorkouts,
    required this.thisMonth,
    required this.lastMonth,
    required this.averageDuration,
    required this.completionRate,
    this.mostFrequentExercises,
  });

  factory WorkoutStatsModel.fromJson(Map<String, dynamic> json) {
    return WorkoutStatsModel(
      totalWorkouts: json['totalWorkouts'] ?? 0,
      thisMonth: json['thisMonth'] ?? 0,
      lastMonth: json['lastMonth'] ?? 0,
      averageDuration: json['averageDuration'] ?? 0,
      completionRate: json['completionRate'] ?? 0,
      mostFrequentExercises: (json['mostFrequentExercises'] as List?)
          ?.cast<String>(),
    );
  }
}
