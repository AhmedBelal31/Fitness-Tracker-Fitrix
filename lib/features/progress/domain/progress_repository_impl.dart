import 'package:fitrix/core/networking/api_constants.dart';
import 'package:fitrix/core/networking/dio_helper.dart';
import '../../exercises/data/models/exercise_progress_response.dart';
import '../data/models/measurement_chart_models.dart';
import '../data/models/progress_models.dart';
import '../data/models/statistics_model.dart';
import 'progress_repository.dart';

class ProgressRepositoryImpl implements ProgressRepository {
  final ApiService apiService;

  ProgressRepositoryImpl({required this.apiService});

  @override
  Future<MeasurementCardsResponse> getMeasurementCards() async {
    try {
      final response = await apiService.get(ApiEndpoints.measurementCards);

      return MeasurementCardsResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load measurement cards: $e');
    }
  }

  @override
  Future<MeasurementChartResponse> getMeasurementCharts({int days = 30}) async {
    final response = await apiService.get(
      '${ApiEndpoints.measurementCharts}?days=$days',
    );
    return MeasurementChartResponse.fromJson(response.data);
  }

  @override
  Future<StatisticsResponse> getStatistics() async {
    try {
      final response = await apiService.get(ApiEndpoints.recordsStates);
      return StatisticsResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load statistics: $e');
    }
  }

  @override
  Future<ExerciseProgressResponse> getExerciseProgress(
    String exerciseId, {
    int days = 30,
  }) async {
    try {
      final response = await apiService.get(
        '${ApiEndpoints.exerciseProgressCharts(exerciseId)}?days=$days',
      );
      return ExerciseProgressResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load exercise progress: $e');
    }
  }
}
