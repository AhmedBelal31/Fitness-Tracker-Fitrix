import '../../../core/networking/error/failures.dart';
import '../../exercises/data/models/exercise_progress_response.dart';
import '../data/models/measurement_chart_models.dart';
import '../data/models/progress_models.dart';
import '../data/models/statistics_model.dart';
import 'package:dartz/dartz.dart';

abstract class ProgressRepository {
  Future<Either<Failure, MeasurementCardsResponse>> getMeasurementCards();

  Future<Either<Failure, MeasurementChartResponse>> getMeasurementCharts({
    int days = 30,
  });

  Future<Either<Failure, StatisticsResponse>> getStatistics();

  Future<Either<Failure, ExerciseProgressResponse>> getExerciseProgress(
    String exerciseId, {
    int days = 30,
  });
}
