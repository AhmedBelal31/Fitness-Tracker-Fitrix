import 'package:fitrix/core/networking/api_constants.dart';
import 'package:fitrix/core/networking/dio_helper.dart';
import '../../../core/networking/error/failures.dart';
import '../../exercises/data/models/exercise_progress_response.dart';
import '../data/models/measurement_chart_models.dart';
import '../data/models/progress_models.dart';
import '../data/models/statistics_model.dart';
import 'progress_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'dart:developer';

class ProgressRepositoryImpl implements ProgressRepository {
  final ApiService apiService;

  ProgressRepositoryImpl({required this.apiService});

  @override
  Future<Either<Failure, MeasurementCardsResponse>>
  getMeasurementCards() async {
    try {
      final response = await apiService.get(ApiEndpoints.measurementCards);

      final data = MeasurementCardsResponse.fromJson(response.data);
      return Right(data);
    } on DioException catch (e) {
      log('❌ getMeasurementCards failed', error: e);
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      log('❌ Unexpected error in getMeasurementCards', error: e);
      return Left(UnexpectedFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, MeasurementChartResponse>> getMeasurementCharts({
    int days = 30,
  }) async {
    try {
      final response = await apiService.get(
        '${ApiEndpoints.measurementCharts}?days=$days',
      );

      final data = MeasurementChartResponse.fromJson(response.data);
      return Right(data);
    } on DioException catch (e) {
      log('❌ getMeasurementCharts failed', error: e);
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      log('❌ Unexpected error in getMeasurementCharts', error: e);
      return Left(UnexpectedFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, StatisticsResponse>> getStatistics() async {
    try {
      final response = await apiService.get(ApiEndpoints.recordsStates);

      final data = StatisticsResponse.fromJson(response.data);
      return Right(data);
    } on DioException catch (e) {
      log('❌ getStatistics failed', error: e);
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      log('❌ Unexpected error in getStatistics', error: e);
      return Left(UnexpectedFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, ExerciseProgressResponse>> getExerciseProgress(
    String exerciseId, {
    int days = 30,
  }) async {
    try {
      final response = await apiService.get(
        '${ApiEndpoints.exerciseProgressCharts(exerciseId)}?days=$days',
      );

      final data = ExerciseProgressResponse.fromJson(response.data);
      return Right(data);
    } on DioException catch (e) {
      log('❌ getExerciseProgress failed', error: e);
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      log('❌ Unexpected error in getExerciseProgress', error: e);
      return Left(UnexpectedFailure('Unexpected error: $e'));
    }
  }
}
