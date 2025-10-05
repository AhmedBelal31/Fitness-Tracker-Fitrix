import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/dio_helper.dart';
import '../../../../core/networking/error/error_response_model.dart';
import '../../../../core/networking/error/failures.dart';
import '../../data/models/register_params.dart';
import '../../data/models/user_model.dart';
import 'auth_repository.dart';
import 'dart:developer' as dev;
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../data/models/register_params.dart';
import '../../data/models/user_model.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiService _apiService;

  AuthRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, UserModel>> register(RegisterParams params) async {
    try {
      dev.log('🚀 Starting registration request', name: 'AuthRepository');
      dev.log('📦 Request data: ${params.toJson()}', name: 'AuthRepository');

      // Make POST request to register endpoint
      final response = await _apiService.postRequest(
        ApiConstants.register,
        data: params.toJson(),
      );

      dev.log(
        '✅ Response received: ${response.statusCode}',
        name: 'AuthRepository',
      );
      dev.log('📥 Response data: ${response.data}', name: 'AuthRepository');

      // Check response status
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse response data
        final data = response.data;

        // Handle different response structures
        final userData = data['data'] ?? data['user'] ?? data;

        // Create UserModel from response
        final user = UserModel.fromJson(userData as Map<String, dynamic>);

        dev.log(
          '✅ User created successfully: ${user.userName}',
          name: 'AuthRepository',
        );
        return Right(user);
      } else {
        // Handle error response with field errors
        dev.log(
          '❌ Error response: ${response.statusCode}',
          name: 'AuthRepository',
        );
        return Left(_handleErrorResponse(response.statusCode, response.data));
      }
    } on DioException catch (e) {
      // Enhanced error logging
      dev.log('❌ DioException caught', name: 'AuthRepository');
      dev.log('Type: ${e.type}', name: 'AuthRepository');
      dev.log('Message: ${e.message}', name: 'AuthRepository');
      dev.log('Error: ${e.error}', name: 'AuthRepository');
      dev.log('Response: ${e.response?.data}', name: 'AuthRepository');
      dev.log(
        'RequestOptions: ${e.requestOptions.baseUrl}${e.requestOptions.path}',
        name: 'AuthRepository',
      );
      dev.log('Headers: ${e.requestOptions.headers}', name: 'AuthRepository');

      // Handle DioException
      return Left(_handleDioException(e));
    } catch (e, stackTrace) {
      // Handle unexpected errors
      dev.log('❌ Unexpected error: $e', name: 'AuthRepository');
      dev.log('StackTrace: $stackTrace', name: 'AuthRepository');
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

  /// Handle error response with field validation errors
  ServerFailure _handleErrorResponse(int? statusCode, dynamic responseData) {
    try {
      if (responseData is Map<String, dynamic>) {
        final errorModel = ErrorResponseModel.fromJson(responseData);

        // If there are field validation errors, include them in the message
        if (errorModel.hasValidationErrors) {
          return ServerFailureWithFields(
            errorModel.formattedMessage,
            fieldErrors: _convertToFieldErrorMap(errorModel.errors),
          );
        }

        return ServerFailure.fromResponse(statusCode, responseData);
      }
    } catch (e) {
      dev.log('❌ Error parsing response: $e', name: 'AuthRepository');
    }

    return ServerFailure.fromResponse(statusCode, responseData);
  }

  /// Handle DioException with detailed logging
  ServerFailure _handleDioException(DioException e) {
    // Log the full request details
    dev.log(
      '🔍 Request URL: ${e.requestOptions.baseUrl}${e.requestOptions.path}',
      name: 'DioError',
    );
    dev.log('🔍 Request Method: ${e.requestOptions.method}', name: 'DioError');
    dev.log('🔍 Request Data: ${e.requestOptions.data}', name: 'DioError');

    if (e.response != null) {
      return _handleErrorResponse(e.response?.statusCode, e.response?.data);
    }

    return ServerFailure.fromDioException(e);
  }

  /// Convert error model field errors to simple Map<String, String>
  Map<String, String>? _convertToFieldErrorMap(
    Map<String, List<String>>? errors,
  ) {
    if (errors == null || errors.isEmpty) return null;

    final Map<String, String> fieldErrors = {};
    errors.forEach((field, messages) {
      if (messages.isNotEmpty) {
        fieldErrors[field] = messages.first;
      }
    });

    return fieldErrors.isNotEmpty ? fieldErrors : null;
  }

  @override
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      dev.log('🚀 Starting login_widgets request', name: 'AuthRepository');

      final response = await _apiService.postRequest(
        ApiConstants.login,
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        final userData = data['data'] ?? data['user'] ?? data;
        final user = UserModel.fromJson(userData as Map<String, dynamic>);

        return Right(user);
      } else {
        return Left(_handleErrorResponse(response.statusCode, response.data));
      }
    } on DioException catch (e) {
      dev.log(
        '❌ Login DioException: ${e.type} - ${e.message}',
        name: 'AuthRepository',
      );
      return Left(_handleDioException(e));
    } catch (e) {
      dev.log('❌ Login Unexpected error: $e', name: 'AuthRepository');
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final response = await _apiService.postRequest(ApiConstants.logout);

      if (response.statusCode == 200 || response.statusCode == 204) {
        return const Right(null);
      } else {
        return Left(_handleErrorResponse(response.statusCode, response.data));
      }
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getCurrentUser() async {
    try {
      final response = await _apiService.getRequest(ApiConstants.currentUser);

      if (response.statusCode == 200) {
        final data = response.data;
        final userData = data['data'] ?? data['user'] ?? data;
        final user = UserModel.fromJson(userData as Map<String, dynamic>);

        return Right(user);
      } else {
        return Left(_handleErrorResponse(response.statusCode, response.data));
      }
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }
}

class ServerFailureWithFields extends ServerFailure {
  final Map<String, String>? fieldErrors;

  ServerFailureWithFields(super.errorMessage, {this.fieldErrors});
}
