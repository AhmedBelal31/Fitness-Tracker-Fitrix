import '../../../progress/data/models/measurement_chart_models.dart';

class ExerciseProgressResponse {
  final List<ChartDataPoint> weightProgression;
  final List<ChartDataPoint> volumeProgression;
  final List<ChartDataPoint> repsProgression;

  ExerciseProgressResponse({
    required this.weightProgression,
    required this.volumeProgression,
    required this.repsProgression,
  });

  factory ExerciseProgressResponse.fromJson(Map<String, dynamic> json) {
    return ExerciseProgressResponse(
      weightProgression:
          (json['weightProgression'] as List?)
              ?.map((e) => ChartDataPoint.fromJson(e))
              .toList() ??
          [],
      volumeProgression:
          (json['volumeProgression'] as List?)
              ?.map((e) => ChartDataPoint.fromJson(e))
              .toList() ??
          [],
      repsProgression:
          (json['repsProgression'] as List?)
              ?.map((e) => ChartDataPoint.fromJson(e))
              .toList() ??
          [],
    );
  }
}
