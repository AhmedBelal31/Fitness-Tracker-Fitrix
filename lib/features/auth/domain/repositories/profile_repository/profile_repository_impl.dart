import 'dart:developer' as dev;
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/networking/api_constants.dart';
import '../../../../../core/networking/dio_helper.dart';
import '../../../../../core/networking/error/failures.dart';
import '../../../data/models/login_profile_model.dart';
import '../../../data/models/params/complete_profile_params.dart';
import '../../../data/models/params/reset_password_request_params.dart';
import '../../../data/models/params/update_profile_params.dart';
import 'profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ApiService _apiService;

  ProfileRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, LoginProfileModel>> completeProfile(
    CompleteProfileParams params,
  ) async {
    try {
      dev.log('📤 Sending complete profile request', name: 'ProfileRepository');

      final response = await _apiService.postRequestWithUrlEncoded(
        ApiEndpoints.completeProfile,
        params.toMap(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        dev.log('✅ Profile completion successful', name: 'ProfileRepository');

        final profileData = response.data;

        if (profileData == null) {
          dev.log('⚠️ No profile data in response', name: 'ProfileRepository');
          return Left(ServerFailure('No profile data received'));
        }

        try {
          final profileModel = LoginProfileModel.fromJson(profileData);

          dev.log(
            '✅ Profile parsed: ${profileModel.firstName} ${profileModel.lastName} (Role: ${profileModel.role})',
            name: 'ProfileRepository',
          );

          return Right(profileModel);
        } catch (e) {
          dev.log(
            '❌ Failed to parse profile data: $e',
            name: 'ProfileRepository',
          );
          return Left(ServerFailure('Failed to parse profile data: $e'));
        }
      } else {
        dev.log(
          '❌ Profile completion failed: ${response.statusCode}',
          name: 'ProfileRepository',
        );
        return Left(
          ServerFailure.fromResponse(response.statusCode, response.data),
        );
      }
    } on DioException catch (e) {
      dev.log(
        '❌ DioException during profile completion: ${e.message}',
        name: 'ProfileRepository',
      );
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      dev.log(
        '❌ Unexpected error during profile completion: $e',
        name: 'ProfileRepository',
      );
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LoginProfileModel>> getProfile() async {
    try {
      dev.log('📤 Fetching user profile', name: 'ProfileRepository');

      final response = await _apiService.get(ApiEndpoints.getProfile);

      if (response.statusCode == 200) {
        dev.log('✅ Profile retrieved successfully', name: 'ProfileRepository');

        final profileData = response.data;

        if (profileData == null) {
          dev.log('⚠️ No profile data in response', name: 'ProfileRepository');
          return Left(ServerFailure('No profile data received'));
        }

        try {
          final profileModel = LoginProfileModel.fromJson(profileData);

          dev.log(
            '✅ Profile parsed: ${profileModel.firstName} ${profileModel.lastName}',
            name: 'ProfileRepository',
          );

          return Right(profileModel);
        } catch (e) {
          dev.log(
            '❌ Failed to parse profile data: $e',
            name: 'ProfileRepository',
          );
          return Left(ServerFailure('Failed to parse profile data: $e'));
        }
      } else {
        dev.log(
          '❌ Profile retrieval failed: ${response.statusCode}',
          name: 'ProfileRepository',
        );
        return Left(
          ServerFailure.fromResponse(response.statusCode, response.data),
        );
      }
    } on DioException catch (e) {
      dev.log(
        '❌ DioException during profile retrieval: ${e.message}',
        name: 'ProfileRepository',
      );
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      dev.log(
        '❌ Unexpected error during profile retrieval: $e',
        name: 'ProfileRepository',
      );
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LoginProfileModel>> updateProfile(
    UpdateProfileParams params,
  ) async {
    try {
      dev.log(
        '📤 Sending update profile request (PATCH with URL encoded data)',
        name: 'ProfileRepository',
      );

      // ✅ Use patchRequest with URL encoded data
      final response = await _apiService.patchRequestWithUrlEncoded(
        ApiEndpoints.updateProfile,
        data: params.toMap(), // ✅ Send as Map, not FormData
      );

      if (response.statusCode == 200) {
        dev.log('✅ Profile update successful', name: 'ProfileRepository');

        final profileData = response.data;

        if (profileData == null) {
          dev.log('⚠️ No profile data in response', name: 'ProfileRepository');
          return Left(ServerFailure('No profile data received'));
        }

        try {
          final profileModel = LoginProfileModel.fromJson(profileData);

          dev.log(
            '✅ Updated profile parsed: ${profileModel.firstName} ${profileModel.lastName}',
            name: 'ProfileRepository',
          );

          return Right(profileModel);
        } catch (e) {
          dev.log(
            '❌ Failed to parse profile data: $e',
            name: 'ProfileRepository',
          );
          return Left(ServerFailure('Failed to parse profile data: $e'));
        }
      } else {
        dev.log(
          '❌ Profile update failed: ${response.statusCode}',
          name: 'ProfileRepository',
        );
        return Left(
          ServerFailure.fromResponse(response.statusCode, response.data),
        );
      }
    } on DioException catch (e) {
      dev.log(
        '❌ DioException during profile update: ${e.message}',
        name: 'ProfileRepository',
      );
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      dev.log(
        '❌ Unexpected error during profile update: $e',
        name: 'ProfileRepository',
      );
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> changePassword(
    ChangePasswordRequest request,
  ) async {
    try {
      dev.log('📤 Sending change password request', name: 'ProfileRepository');

      final response = await _apiService.postRequest(
        ApiEndpoints.changePassword,
        data: request.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        dev.log('✅ Password changed successfully', name: 'ProfileRepository');
        return const Right(null);
      } else {
        dev.log(
          '❌ Password change failed: ${response.statusCode}',
          name: 'ProfileRepository',
        );
        return Left(
          ServerFailure.fromResponse(response.statusCode, response.data),
        );
      }
    } on DioException catch (e) {
      dev.log(
        '❌ DioException during password change: ${e.message}',
        name: 'ProfileRepository',
      );
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      dev.log(
        '❌ Unexpected error during password change: $e',
        name: 'ProfileRepository',
      );
      return Left(ServerFailure(e.toString()));
    }
  }
}
