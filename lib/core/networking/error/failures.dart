import 'dart:developer';
import 'package:dio/dio.dart';
import '../../../generated/l10n.dart';
import 'error_response_model.dart';

abstract class Failure {
  final String errorMessage;
  const Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);

  factory ServerFailure.fromDioException(DioException dioException) {
    log("❌ DioException: ${dioException.message}");

    if (dioException.response != null) {
      log("❌ Response Data: ${dioException.response?.data}");
      return ServerFailure.fromResponse(
        dioException.response?.statusCode,
        dioException.response?.data,
      );
    } else {
      switch (dioException.type) {
        case DioExceptionType.connectionTimeout:
          return ServerFailure(
            'Connection timeout with the API server. Please try again later.',
          );
        case DioExceptionType.sendTimeout:
          return ServerFailure(
            'Send timeout with the API server. Please try again later.',
          );
        case DioExceptionType.receiveTimeout:
          return ServerFailure(
            'Receive timeout with the API server. Please try again later.',
          );
        case DioExceptionType.cancel:
          return ServerFailure('Request to the API server was cancelled.');
        case DioExceptionType.connectionError:
          return ServerFailure(
            'Connection error occurred. Please check your internet connection and try again.',
          );
        case DioExceptionType.unknown:
        default:
          return ServerFailure(
            'An unknown error occurred. Please try again later.',
          );
      }
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    log("❌ Handling Response Error - Status Code: $statusCode");

    try {
      if (response is Map<String, dynamic>) {
        final errorResponse = ErrorResponseModel.fromJson(response);

        log(
          "❌ ErrorResponseModel: ${errorResponse.message} - ${errorResponse.details}",
        );

        return ServerFailure(errorResponse.details ?? errorResponse.message);
      }
    } catch (e) {
      log("❌ Failed to parse ErrorResponseModel: $e");
    }

    // fallback based on status code if parsing fails
    final locale = S.current;

    switch (statusCode) {
      case 400:
        return ServerFailure(locale.error_400);
      case 401:
        return ServerFailure(locale.error_401);
      case 403:
        return ServerFailure(locale.error_401_403);
      case 404:
        return ServerFailure(locale.error_404);
      case 405:
        return ServerFailure(locale.error_405);
      case 406:
        return ServerFailure(locale.error_406);
      case 408:
        return ServerFailure(locale.error_408);
      case 409:
        return ServerFailure(locale.error_409);
      case 410:
        return ServerFailure(locale.error_410);
      case 411:
        return ServerFailure(locale.error_411);
      case 412:
        return ServerFailure(locale.error_412);
      case 413:
        return ServerFailure(locale.error_413);
      case 414:
        return ServerFailure(locale.error_414);
      case 415:
        return ServerFailure(locale.error_415);
      case 422:
        return ServerFailure(locale.error_422);
      case 429:
        return ServerFailure(locale.error_429);
      case 500:
        return ServerFailure(locale.error_500);
      case 501:
        return ServerFailure(locale.error_501);
      case 502:
        return ServerFailure(locale.error_502);
      case 503:
        return ServerFailure(locale.error_503);
      case 504:
        return ServerFailure(locale.error_504);
      case 505:
        return ServerFailure(locale.error_505);
      default:
        log("❌ Unexpected Error: $statusCode");
        return ServerFailure(locale.error_unexpected);
    }
  }
}

class ProfileNotFoundFailure extends Failure {
  const ProfileNotFoundFailure(super.errorMessage);
}
