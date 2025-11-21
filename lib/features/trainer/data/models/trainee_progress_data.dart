class TraineeProgressData {
  final Map<String, dynamic>? progressData;
  final List<dynamic>? workoutHistory;
  final Map<String, dynamic>? statistics;

  TraineeProgressData({
    this.progressData,
    this.workoutHistory,
    this.statistics,
  });

  factory TraineeProgressData.fromJson(Map<String, dynamic> json) =>
      TraineeProgressData(
        progressData: json['progressData'],
        workoutHistory: json['workoutHistory'],
        statistics: json['statistics'],
      );
}
