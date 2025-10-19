import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitrix/core/networking/dio_helper.dart';
import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/error/failures.dart';
import '../../data/models/section_model.dart';
import '../../data/models/exercise_model.dart';
import '../../data/models/custom_exercise_request.dart';
import '../../data/models/section_group_model.dart';
import 'exercise_repository.dart';

class ExerciseRepositoryImpl implements ExerciseRepository {
  final ApiService _apiService;

  ExerciseRepositoryImpl(this._apiService);

  // ========== GET SECTIONS ==========
  @override
  Future<Either<Failure, List<SectionModel>>> getSections() async {
    try {
      final response = await _apiService.get(ApiEndpoints.getSections);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final sections = data
            .map((json) => SectionModel.fromJson(json as Map<String, dynamic>))
            .toList();
        return Right(sections);
      } else {
        return Left(
          ServerFailure('Failed to load sections: ${response.statusMessage}'),
        );
      }
    } on DioException catch (e) {
      return Left(ServerFailure(_handleDioError(e)));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  // ========== GET EXERCISES BY SECTION (FIXED) ==========
  @override
  Future<Either<Failure, List<ExerciseModel>>> getExercisesBySection({
    required String sectionId,
    String? searchTerm,
    String? difficulty,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'sectionId': sectionId,
        if (searchTerm != null && searchTerm.isNotEmpty)
          'searchTerm': searchTerm,
        if (difficulty != null && difficulty.isNotEmpty)
          'difficulty': difficulty,
      };

      final response = await _apiService.get(
        ApiEndpoints.getExercisesBySection,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        // ✅ FIX: API returns {exercise: [], customExercise: []}
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;

        final List<dynamic> exerciseList = data['exercise'] ?? [];
        final List<dynamic> customExerciseList = data['customExercise'] ?? [];

        // Combine both lists
        final allExercises = <ExerciseModel>[];

        // Add general exercises
        for (var json in exerciseList) {
          allExercises.add(
            ExerciseModel.fromJson(json as Map<String, dynamic>),
          );
        }

        // Add custom exercises
        for (var json in customExerciseList) {
          allExercises.add(
            ExerciseModel.fromJson(json as Map<String, dynamic>),
          );
        }

        return Right(allExercises);
      } else if (response.statusCode == 401) {
        return Left(ServerFailure('Unauthorized. Please login again.'));
      } else {
        return Left(
          ServerFailure('Failed to load exercises: ${response.statusMessage}'),
        );
      }
    } on DioException catch (e) {
      return Left(ServerFailure(_handleDioError(e)));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  // ========== GET EXERCISE BY ID ==========
  // @override
  // Future<Either<Failure, ExerciseModel>> getExerciseById(
  //   String exerciseId,
  // ) async {
  //   try {
  //     final response = await _apiService.get(
  //       ApiEndpoints.getExerciseById,
  //       queryParameters: {'exerciseId': exerciseId},
  //     );
  //
  //     if (response.statusCode == 200) {
  //       return Right(
  //         ExerciseModel.fromJson(response.data as Map<String, dynamic>),
  //       );
  //     } else if (response.statusCode == 401) {
  //       return Left(ServerFailure('Unauthorized. Please login again.'));
  //     } else {
  //       return Left(
  //         ServerFailure(
  //           'Failed to load exercise details: ${response.statusMessage}',
  //         ),
  //       );
  //     }
  //   } on DioException catch (e) {
  //     return Left(ServerFailure(_handleDioError(e)));
  //   } catch (e) {
  //     return Left(ServerFailure('Unexpected error: ${e.toString()}'));
  //   }
  // }

  // ========== GET CUSTOM EXERCISES ==========
  @override
  Future<Either<Failure, List<ExerciseModel>>> getCustomExercises({
    String? difficulty,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        if (difficulty != null && difficulty.isNotEmpty)
          'difficulty': difficulty,
      };

      final response = await _apiService.get(
        ApiEndpoints.getCustomExercises,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final exercises = data
            .map((json) => ExerciseModel.fromJson(json as Map<String, dynamic>))
            .toList();
        return Right(exercises);
      } else if (response.statusCode == 401) {
        return Left(ServerFailure('Unauthorized. Please login again.'));
      } else {
        return Left(
          ServerFailure(
            'Failed to load custom exercises: ${response.statusMessage}',
          ),
        );
      }
    } on DioException catch (e) {
      return Left(ServerFailure(_handleDioError(e)));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  // ========== CREATE CUSTOM EXERCISE ==========
  @override
  Future<Either<Failure, ExerciseModel>> createCustomExercise(
    CreateCustomExerciseRequest request,
  ) async {
    try {
      final formDataMap = <String, dynamic>{
        'Name': request.name,
        if (request.description != null) 'Description': request.description,
        if (request.instructions != null) 'Instructions': request.instructions,
        if (request.equipment != null) 'Equipment': request.equipment,
        if (request.difficultyLevel != null)
          'DifficultyLevel': request.difficultyLevel,
        if (request.imageFile != null)
          'ImageFile': await MultipartFile.fromFile(
            request.imageFile!.path,
            filename: request.imageFile!.path.split('/').last,
          ),
      };

      final formData = FormData.fromMap(formDataMap);

      final response = await _apiService.postRequestWithFormData(
        '${ApiEndpoints.createCustomExercise}?sectionId=${request.sectionId}',
        formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(
          ExerciseModel.fromJson(response.data as Map<String, dynamic>),
        );
      } else if (response.statusCode == 401) {
        return Left(ServerFailure('Unauthorized. Please login again.'));
      } else if (response.statusCode == 400) {
        return Left(
          ValidationFailure('Invalid data. Please check your input.'),
        );
      } else {
        return Left(
          ServerFailure(
            'Failed to create custom exercise: ${response.statusMessage}',
          ),
        );
      }
    } on DioException catch (e) {
      return Left(ServerFailure(_handleDioError(e)));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  // ========== UPDATE CUSTOM EXERCISE ==========
  @override
  Future<Either<Failure, bool>> updateCustomExercise(
    String exerciseId,
    String sectionId,
    UpdateCustomExerciseRequest request,
  ) async {
    try {
      final formDataMap = <String, dynamic>{
        if (request.name != null) 'Name': request.name,
        if (request.description != null) 'Description': request.description,
        if (request.instructions != null) 'Instructions': request.instructions,
        if (request.equipment != null) 'Equipment': request.equipment,
        if (request.difficultyLevel != null)
          'DifficultyLevel': request.difficultyLevel,
        if (request.imageFile != null)
          'ImageFile': await MultipartFile.fromFile(
            request.imageFile!.path,
            filename: request.imageFile!.path.split('/').last,
          ),
      };

      final formData = FormData.fromMap(formDataMap);

      final response = await _apiService.putRequestWithFormData(
        '${ApiEndpoints.updateCustomExercise}?exerciseId=$exerciseId&sectionId=$sectionId',
        formData,
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return const Right(true);
      } else if (response.statusCode == 401) {
        return Left(ServerFailure('Unauthorized. Please login again.'));
      } else if (response.statusCode == 400) {
        return Left(
          ValidationFailure('Invalid data. Please check your input.'),
        );
      } else if (response.statusCode == 404) {
        return Left(ServerFailure('Exercise not found.'));
      } else {
        return Left(
          ServerFailure(
            'Failed to update custom exercise: ${response.statusMessage}',
          ),
        );
      }
    } on DioException catch (e) {
      return Left(ServerFailure(_handleDioError(e)));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  // exercise_repository_impl.dart
  @override
  Future<Either<Failure, bool>> deleteCustomExercise(String exerciseId) async {
    try {
      final response = await _apiService.deleteRequest(
        ApiEndpoints.deleteCustomExercise,
        queryParameters: {'exerciseId': exerciseId},
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return const Right(true);
      } else if (response.statusCode == 400) {
        // Extract specific error message from API response
        final errorData = response.data;
        if (errorData != null && errorData is Map) {
          final errors = errorData['errors'];
          if (errors != null && errors is Map) {
            // Get first error message
            final firstError = errors.values.first;
            if (firstError is List && firstError.isNotEmpty) {
              return Left(ServerFailure(firstError.first.toString()));
            }
          }
        }
        return Left(ServerFailure('Cannot delete this exercise'));
      } else if (response.statusCode == 401) {
        return Left(ServerFailure('Unauthorized. Please login again.'));
      } else if (response.statusCode == 404) {
        return Left(ServerFailure('Exercise not found.'));
      } else {
        return Left(ServerFailure('Failed to delete exercise'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(_handleDioError(e)));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  // ========== CREATE SECTION GROUP ==========
  @override
  Future<Either<Failure, SectionGroupModel>> createSectionGroup({
    required String sectionId,
    required String name,
    String? description,
  }) async {
    try {
      final data = {
        'sectionId': sectionId,
        'name': name,
        if (description != null) 'description': description,
      };

      final response = await _apiService.postRequest(
        ApiEndpoints.createSectionGroup,
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(
          SectionGroupModel.fromJson(response.data as Map<String, dynamic>),
        );
      } else if (response.statusCode == 401) {
        return Left(ServerFailure('Unauthorized. Please login again.'));
      } else if (response.statusCode == 400) {
        return Left(
          ValidationFailure('Invalid data. Please check your input.'),
        );
      } else {
        return Left(
          ServerFailure(
            'Failed to create section group: ${response.statusMessage}',
          ),
        );
      }
    } on DioException catch (e) {
      return Left(ServerFailure(_handleDioError(e)));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  // ========== GET ALL SECTION GROUPS ==========
  @override
  Future<Either<Failure, List<SectionGroupModel>>> getAllSectionGroups(
    String sectionId,
  ) async {
    try {
      final response = await _apiService.get(
        ApiEndpoints.getAllSectionGroups,
        queryParameters: {'sectionId': sectionId},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final groups = data
            .map(
              (json) =>
                  SectionGroupModel.fromJson(json as Map<String, dynamic>),
            )
            .toList();
        return Right(groups);
      } else if (response.statusCode == 401) {
        return Left(ServerFailure('Unauthorized. Please login again.'));
      } else {
        return Left(
          ServerFailure(
            'Failed to load section groups: ${response.statusMessage}',
          ),
        );
      }
    } on DioException catch (e) {
      return Left(ServerFailure(_handleDioError(e)));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  // ========== ADD EXERCISE TO SECTION GROUP ==========
  @override
  Future<Either<Failure, SectionGroupModel>> addExerciseToSectionGroup({
    required String groupId,
    String? exerciseId,
    String? customExerciseId,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'groupId': groupId,
        if (exerciseId != null) 'exerciseId': exerciseId,
        if (customExerciseId != null) 'customExerciseId': customExerciseId,
      };

      final response = await _apiService.postRequest(
        ApiEndpoints.addExerciseToSectionGroup,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(
          SectionGroupModel.fromJson(response.data as Map<String, dynamic>),
        );
      } else if (response.statusCode == 401) {
        return Left(ServerFailure('Unauthorized. Please login again.'));
      } else if (response.statusCode == 400) {
        return Left(
          ValidationFailure('Invalid data. Please check your input.'),
        );
      } else if (response.statusCode == 404) {
        return Left(ServerFailure('Group or exercise not found.'));
      } else {
        return Left(
          ServerFailure(
            'Failed to add exercise to group: ${response.statusMessage}',
          ),
        );
      }
    } on DioException catch (e) {
      return Left(ServerFailure(_handleDioError(e)));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<ExerciseModel?> getExerciseById(String exerciseId) async {
    try {
      final response = await _apiService.get(
        '${ApiEndpoints.getExerciseById}?exerciseId=$exerciseId',
      );
      return ExerciseModel.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<ExerciseModel?> getCustomExerciseById(String customExerciseId) async {
    try {
      final response = await _apiService.get(
        '${ApiEndpoints.getCustomExercise}?exerciseId=$customExerciseId',
      );
      return ExerciseModel.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  // ========== ERROR HANDLER ==========
  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.sendTimeout:
        return 'Send timeout. Please try again.';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout. Please try again.';
      case DioExceptionType.badResponse:
        return 'Bad response: ${e.response?.statusCode} - ${e.response?.statusMessage}';
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.connectionError:
        return 'Connection error. Please check your internet connection.';
      case DioExceptionType.badCertificate:
        return 'Bad certificate. Please contact support.';
      case DioExceptionType.unknown:
        return 'Unknown error: ${e.message}';
      default:
        return 'Something went wrong: ${e.message}';
    }
  }
}
