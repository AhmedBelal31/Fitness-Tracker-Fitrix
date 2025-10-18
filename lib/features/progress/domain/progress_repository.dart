import '../data/models/measurement_chart_models.dart';
import '../data/models/progress_models.dart';
import '../data/models/statistics_model.dart';

abstract class ProgressRepository {
  Future<MeasurementCardsResponse> getMeasurementCards();
  Future<MeasurementChartResponse> getMeasurementCharts({int days = 30});
  Future<StatisticsResponse> getStatistics();
}
