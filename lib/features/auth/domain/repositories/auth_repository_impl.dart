import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitrix/core/networking/token_manager.dart';
import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/dio_helper.dart';
import '../../../../core/networking/error/error_response_model.dart';
import '../../../../core/networking/error/failures.dart';
import '../../data/models/login_params.dart';
import '../../data/models/login_response_model.dart';
import '../../data/models/register_params.dart';
import '../../data/models/user_model.dart';
import 'auth_repository.dart';
import 'dart:developer' as dev;

class AuthRepositoryImpl implements AuthRepository {
  final ApiService _apiService;
  AuthRepositoryImpl(this._apiService);
  final TokenManager _tokenManager = TokenManager.instance;

  @override
  Future<Either<Failure, UserModel>> register(RegisterParams params) async {
    try {
      dev.log('🚀 Starting registration request', name: 'AuthRepository');
      dev.log('📦 Request data: ${params.toJson()}', name: 'AuthRepository');

      // Make POST request to register endpoint
      final response = await _apiService.postRequest(
        ApiEndpoints.register,
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
  Future<Either<Failure, LoginResponseModel>> login(LoginParams params) async {
    try {
      dev.log('🚀 Starting login request', name: 'AuthRepository');
      dev.log('📦 Request data: ${params.toJson()}', name: 'AuthRepository');

      final response = await _apiService.postRequest(
        ApiEndpoints.login,
        data: params.toJson(),
      );

      dev.log(
        '✅ Response received: ${response.statusCode}',
        name: 'AuthRepository',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final loginResponse = LoginResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        );

        // Save tokens
        await _tokenManager.saveTokens(
          accessToken: loginResponse.accessToken,
          refreshToken: loginResponse.refreshToken,
          expiresOnUtc: loginResponse.expiresOnUtc,
        );

        dev.log('✅ Login successful, tokens saved', name: 'AuthRepository');
        return Right(loginResponse);
      } else if (response.statusCode == 404) {
        // 404 on login means invalid credentials
        dev.log('❌ Invalid credentials (404)', name: 'AuthRepository');
        return Left(
          ServerFailure('Invalid email or password. Please try again.'),
        );
      } else if (response.statusCode == 401) {
        // 401 means unauthorized
        return Left(
          ServerFailure('Invalid email or password. Please try again.'),
        );
      } else {
        return Left(_handleErrorResponse(response.statusCode, response.data));
      }
    } on DioException catch (e) {
      dev.log(
        '❌ Login DioException: ${e.type} - ${e.message}',
        name: 'AuthRepository',
      );

      // Handle 404 specifically
      if (e.response?.statusCode == 404) {
        return Left(
          ServerFailure('Invalid email or password. Please try again.'),
        );
      } else if (e.response?.statusCode == 401) {
        return Left(
          ServerFailure('Invalid email or password. Please try again.'),
        );
      }

      return Left(_handleDioException(e));
    } catch (e) {
      dev.log('❌ Login Unexpected error: $e', name: 'AuthRepository');
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getProfile() async {
    try {
      dev.log('🚀 Fetching user profile', name: 'AuthRepository');

      // Verify token exists before making request
      final token = await _tokenManager.getAccessToken();
      if (token == null || token.isEmpty) {
        dev.log('❌ No access token found', name: 'AuthRepository');
        return Left(
          ServerFailure('Authentication required. Please login again.'),
        );
      }

      final response = await _apiService.get(
        ApiEndpoints.getProfile,
        queryParams: {'pageSize': 1, 'page': 1},
      );

      dev.log(
        '✅ Profile response: ${response.statusCode}',
        name: 'AuthRepository',
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final userData = data['data'] ?? data['user'] ?? data;
        final user = UserModel.fromJson(userData as Map<String, dynamic>);

        dev.log('✅ Profile fetched successfully', name: 'AuthRepository');
        return Right(user);
      } else if (response.statusCode == 404) {
        // Profile not found - user needs to complete profile
        dev.log('⚠️ Profile not found (404)', name: 'AuthRepository');
        return Left(ProfileNotFoundFailure('User profile not found.'));
      } else if (response.statusCode == 401) {
        // Unauthorized - token invalid or expired
        dev.log(
          '❌ Unauthorized (401) - clearing tokens',
          name: 'AuthRepository',
        );
        await _tokenManager.clearTokens();
        return Left(ServerFailure('Session expired. Please login again.'));
      } else {
        return Left(_handleErrorResponse(response.statusCode, response.data));
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return Left(ProfileNotFoundFailure('User profile not found.'));
      } else if (e.response?.statusCode == 401) {
        await _tokenManager.clearTokens();
        return Left(ServerFailure('Session expired. Please login again.'));
      }
      dev.log(
        '❌ Profile DioException: ${e.type} - ${e.message}',
        name: 'AuthRepository',
      );
      return Left(_handleDioException(e));
    } catch (e) {
      dev.log('❌ Profile Unexpected error: $e', name: 'AuthRepository');
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final response = await _apiService.postRequest(ApiEndpoints.logout);

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
      final response = await _apiService.get(ApiEndpoints.currentUser);

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

  // In AuthRepositoryImpl:
  @override
  Future<Either<Failure, void>> forgotPassword(String email) async {
    try {
      final response = await _apiService.postRequest(
        ApiEndpoints.forgotPassword,
        data: {"email": email},
      );
      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        return Left(
          ServerFailure.fromResponse(response.statusCode, response.data),
        );
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

class ServerFailureWithFields extends ServerFailure {
  final Map<String, String>? fieldErrors;

  ServerFailureWithFields(super.errorMessage, {this.fieldErrors});
}
