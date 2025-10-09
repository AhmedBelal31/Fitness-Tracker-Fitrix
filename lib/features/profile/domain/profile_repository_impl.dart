import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitrix/core/networking/api_constants.dart';
import '../../../core/networking/dio_helper.dart';
import '../../../core/networking/error/failures.dart';
import '../data/models/complete_profile_params.dart';
import 'profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ApiService _apiService;

  ProfileRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, void>> completeProfile(
    CompleteProfileParams params,
  ) async {
    try {
      final response = await _apiService.postRequestWithFormData(
        ApiEndpoints.completeProfile,
        params.toFormData(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
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
