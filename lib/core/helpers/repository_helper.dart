import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../networking/error/error_response_model.dart';
import '../networking/error/failures.dart';

abstract class RepositoryHelper {
  Future<Either<Failure, T>> execute<T>(Future<T> Function() apiCall) async {
    try {
      final result = await apiCall();
      return Right(result);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  ServerFailure _handleDioException(DioException e) {
    if (e.response != null) {
      return _handleErrorResponse(e.response?.statusCode, e.response?.data);
    }
    return ServerFailure.fromDioException(e);
  }

  ServerFailure _handleErrorResponse(int? statusCode, dynamic responseData) {
    try {
      if (responseData is Map<String, dynamic>) {
        final errorModel = ErrorResponseModel.fromJson(responseData);
        if (errorModel.hasValidationErrors) {
          return ServerFailureWithFields(
            errorModel.formattedMessage,
            fieldErrors: _convertToFieldErrorMap(errorModel.errors),
          );
        }
        return ServerFailure.fromResponse(statusCode, responseData);
      }
    } catch (_) {}
    return ServerFailure.fromResponse(statusCode, responseData);
  }

  Map<String, String>? _convertToFieldErrorMap(
    Map<String, List<String>>? errors,
  ) {
    if (errors == null || errors.isEmpty) return null;
    final Map<String, String> fieldErrors = {};
    errors.forEach((field, messages) {
      if (messages.isNotEmpty) fieldErrors[field] = messages.first;
    });
    return fieldErrors.isNotEmpty ? fieldErrors : null;
  }
}

class ServerFailureWithFields extends ServerFailure {
  final Map<String, String>? fieldErrors;
  ServerFailureWithFields(super.errorMessage, {this.fieldErrors});
}
