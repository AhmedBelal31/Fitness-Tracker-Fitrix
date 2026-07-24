import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitrix/core/networking/dio_helper.dart';
import 'package:fitrix/core/networking/api_constants.dart';
import 'package:fitrix/core/networking/error/failures.dart';
import 'package:fitrix/generated/l10n.dart';
import '../data/achievements_models.dart';
import 'achievements_repository.dart';

class AchievementsRepositoryImpl implements AchievementsRepository {
  final ApiService _dioClient;
  final S _locale = S.current;

  AchievementsRepositoryImpl(this._dioClient);

  @override
  Future<Either<Failure, AchievementsResponse>> getAchievements() async {
    try {
      final response = await _dioClient.get(ApiEndpoints.recordsAchievements);

      if (response.statusCode == 200) {
        final achievements = AchievementsResponse.fromJson(response.data);
        return Right(achievements);
      } else {
        return Left(_handleStatusCode(response.statusCode ?? 0));
      }
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      log("❌ Unexpected Error in getAchievements: $e");
      return Left(ServerFailure(_locale.error_unexpected));
    }
  }

  // Handle HTTP Status Codes
  Failure _handleStatusCode(int statusCode) {
    switch (statusCode) {
      case 400:
        return ServerFailure(_locale.error_400);
      case 401:
        return ServerFailure(_locale.error_401);
      case 403:
        return ServerFailure(_locale.error_401_403);
      case 404:
        return ServerFailure(_locale.error_404);
      case 405:
        return ServerFailure(_locale.error_405);
      case 406:
        return ServerFailure(_locale.error_406);
      case 408:
        return ServerFailure(_locale.error_408);
      case 409:
        return ServerFailure(_locale.error_409);
      case 410:
        return ServerFailure(_locale.error_410);
      case 411:
        return ServerFailure(_locale.error_411);
      case 412:
        return ServerFailure(_locale.error_412);
      case 413:
        return ServerFailure(_locale.error_413);
      case 414:
        return ServerFailure(_locale.error_414);
      case 415:
        return ServerFailure(_locale.error_415);
      case 422:
        return ServerFailure(_locale.error_422);
      case 429:
        return ServerFailure(_locale.error_429);
      case 500:
        return ServerFailure(_locale.error_500);
      case 501:
        return ServerFailure(_locale.error_501);
      case 502:
        return ServerFailure(_locale.error_502);
      case 503:
        return ServerFailure(_locale.error_503);
      case 504:
        return ServerFailure(_locale.error_504);
      case 505:
        return ServerFailure(_locale.error_505);
      default:
        log("❌ Unexpected Error: $statusCode");
        return ServerFailure(_locale.error_unexpected);
    }
  }

  // Handle DioException
  Failure _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        log("❌ Timeout Error: ${e.message}");
        return ServerFailure(_locale.error_timeout);

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode ?? 0;
        log("❌ Bad Response: $statusCode");
        return _handleStatusCode(statusCode);

      case DioExceptionType.cancel:
        log("❌ Request Cancelled");
        return ServerFailure(_locale.error_cancelled);

      case DioExceptionType.connectionError:
        log("❌ Connection Error: ${e.message}");
        return ServerFailure(_locale.error_connection);

      default:
        log("❌ Unknown Dio Error: ${e.message}");
        return ServerFailure(_locale.error_unexpected);
    }
  }
}
