import 'dart:developer' as dev;
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/networking/api_constants.dart';
import '../../../../../core/networking/dio_helper.dart';
import '../../../../../core/networking/error/failures.dart';
import '../../../data/models/login_profile_model.dart';
import '../../../data/models/params/complete_profile_params.dart';
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

      final response = await _apiService.postRequestWithFormData(
        ApiEndpoints.completeProfile,
        params.toFormData(),
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
}
