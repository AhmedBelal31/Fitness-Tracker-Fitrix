import '../../exercises/data/models/exercise_progress_response.dart';
import '../data/models/measurement_chart_models.dart';
import '../data/models/progress_models.dart';
import '../data/models/statistics_model.dart';

abstract class ProgressRepository {
  Future<MeasurementCardsResponse> getMeasurementCards();
  Future<MeasurementChartResponse> getMeasurementCharts({int days = 30});
  Future<StatisticsResponse> getStatistics();
  Future<ExerciseProgressResponse> getExerciseProgress(
    String exerciseId, {
    int days = 30,
  });
}
