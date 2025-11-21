import 'package:dio/dio.dart';
import 'package:fitrix/core/networking/dio_helper.dart';
import '../../../../../core/networking/api_constants.dart';
import '../../../../core/networking/error/failures.dart';
import '../../data/workout_session_model.dart';
import 'workout_repository.dart';

// class WorkoutRepositoryImpl implements WorkoutRepository {
//   final ApiService apiService;
//
//   WorkoutRepositoryImpl({required this.apiService});
//
//   @override
//   Future<String> createSession({required DateTime date, String? notes}) async {
//     try {
//       final dateString =
//           '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
//
//       final response = await apiService.postRequest(
//         ApiEndpoints.createWorkoutSession,
//         data: {
//           'date': dateString,
//           if (notes != null && notes.isNotEmpty) 'notes': notes,
//         },
//       );
//
//       final session = WorkoutSessionModel.fromJson(response.data);
//       return session.id;
//     } catch (e) {
//       throw Exception('Failed to create workout session: $e');
//     }
//   }
//
//   @override
//   Future<List<WorkoutSessionModel>> getWorkoutHistory({
//     int pageSize = 20,
//     int pageNumber = 1,
//     DateTime? toDate,
//   }) async {
//     try {
//       final response = await apiService.get(
//         ApiEndpoints.getWorkoutHistory,
//         queryParameters: {
//           'pageSize': pageSize,
//           'pageNumber': pageNumber,
//           if (toDate != null) 'toDate': toDate.toIso8601String(),
//         },
//       );
//
//       return (response.data as List)
//           .map((json) => WorkoutSessionModel.fromJson(json))
//           .toList();
//     } catch (e) {
//       throw Exception('Failed to load workout history: $e');
//     }
//   }
//
//   @override
//   Future<WorkoutSessionModel> getSessionById(String sessionId) async {
//     try {
//       final response = await apiService.get(
//         ApiEndpoints.getWorkoutSession,
//         queryParameters: {'id': sessionId},
//       );
//
//       return WorkoutSessionModel.fromJson(response.data);
//     } catch (e) {
//       throw Exception('Failed to load workout session: $e');
//     }
//   }
//
//   @override
//   Future<WorkoutExerciseModel> addExerciseToWorkout({
//     required String sessionId,
//     String? exerciseId,
//     String? customExerciseId,
//   }) async {
//     try {
//       final response = await apiService.postRequest(
//         ApiEndpoints.addExerciseToWorkout,
//         queryParameters: {
//           'sessionId': sessionId,
//           if (exerciseId != null) 'exerciseId': exerciseId,
//           if (customExerciseId != null) 'userExerciseId': customExerciseId,
//         },
//       );
//
//       if (response.data == null) {
//         throw Exception('Empty response from server');
//       }
//
//       return WorkoutExerciseModel.fromJson(response.data);
//     } on DioException catch (e) {
//       if (e.response?.statusCode == 400) {
//         final errors = e.response?.data['errors'];
//         if (errors != null && errors['Session_Completed'] != null) {
//           throw Exception('Cannot add exercises to completed session');
//         }
//         throw Exception(e.response?.data['title'] ?? 'Bad request');
//       }
//       throw Exception('Failed to add exercise to workout: ${e.message}');
//     } catch (e) {
//       throw Exception('Failed to add exercise to workout: $e');
//     }
//   }
//
//   @override
//   Future<void> startWorkoutSession(String sessionId) async {
//     try {
//       await apiService.putRequest(
//         ApiEndpoints.startWorkoutSession,
//         queryParameters: {'id': sessionId},
//       );
//     } catch (e) {
//       throw Exception('Failed to start workout session: $e');
//     }
//   }
//
//   @override
//   Future<void> completeWorkoutSession(String sessionId, String? notes) async {
//     try {
//       await apiService.putRequest(
//         ApiEndpoints.completeWorkoutSession,
//         queryParameters: {
//           'id': sessionId,
//           if (notes != null && notes.isNotEmpty) 'notes': notes,
//         },
//       );
//     } catch (e) {
//       throw Exception('Failed to complete workout session: $e');
//     }
//   }
//
//   @override
//   Future<ExerciseSetModel> addSetToExercise({
//     required String sessionId,
//     required String exerciseId,
//     required int setNumber,
//     required int reps,
//     required double weightKg,
//     int? restTimeSeconds,
//     String? notes,
//   }) async {
//     try {
//       final response = await apiService.postRequest(
//         ApiEndpoints.addSetToExercise,
//         queryParameters: {'sessionId': sessionId, 'exerciseId': exerciseId},
//         data: {
//           'setNumber': setNumber,
//           'reps': reps,
//           'weightKg': weightKg,
//           if (restTimeSeconds != null) 'restTimeSeconds': restTimeSeconds,
//           if (notes != null && notes.isNotEmpty) 'notes': notes,
//         },
//       );
//
//       return ExerciseSetModel.fromJson(response.data);
//     } catch (e) {
//       throw Exception('Failed to add set: $e');
//     }
//   }
//
//   @override
//   Future<void> updateExerciseSet({
//     required String sessionId,
//     required String exerciseId,
//     required String setId,
//     required int setNumber,
//     required int reps,
//     required double weightKg,
//     int? restTimeSeconds,
//     String? notes,
//     bool? isCompleted,
//     bool? isPersonalRecord,
//   }) async {
//     try {
//       // ✅ Try PATCH first (common for partial updates)
//       final data = {
//         'reps': reps,
//         'weightKg': weightKg,
//         if (restTimeSeconds != null) 'restTimeSeconds': restTimeSeconds,
//         if (notes != null && notes.isNotEmpty) 'notes': notes,
//       };
//
//       final response = await apiService.patchRequest(
//         ApiEndpoints.updateExerciseSet,
//         queryParameters: {
//           'sessionId': sessionId,
//           'exerciseId': exerciseId,
//           'setId': setId,
//         },
//         data: data,
//       );
//
//       if (response.statusCode != 200 && response.statusCode != 204) {
//         throw Exception('Failed to update exercise set');
//       }
//     } on DioException catch (e) {
//       // ✅ If PATCH fails with 405, try PUT
//       if (e.response?.statusCode == 405) {
//         try {
//           final data = {
//             'reps': reps,
//             'weightKg': weightKg,
//             if (restTimeSeconds != null) 'restTimeSeconds': restTimeSeconds,
//             if (notes != null && notes.isNotEmpty) 'notes': notes,
//           };
//
//           final response = await apiService.putRequest(
//             ApiEndpoints.updateExerciseSet,
//             queryParameters: {
//               'sessionId': sessionId,
//               'exerciseId': exerciseId,
//               'setId': setId,
//             },
//             data: data,
//           );
//
//           if (response.statusCode != 200 && response.statusCode != 204) {
//             throw Exception('Failed to update exercise set');
//           }
//         } catch (putError) {
//           throw Exception('Error updating exercise set: $putError');
//         }
//       } else {
//         throw Exception('Error updating exercise set: ${e.message}');
//       }
//     } catch (e) {
//       throw Exception('Error updating exercise set: $e');
//     }
//   }
// }
import 'dart:developer' as dev;
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class WorkoutRepositoryImpl implements WorkoutRepository {
  final ApiService apiService;

  WorkoutRepositoryImpl({required this.apiService});

  @override
  Future<Either<Failure, String>> createSession({
    required DateTime date,
    String? notes,
  }) async {
    try {
      final dateString =
          '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

      final response = await apiService.postRequest(
        ApiEndpoints.createWorkoutSession,
        data: {
          'date': dateString,
          if (notes != null && notes.isNotEmpty) 'notes': notes,
        },
      );

      final session = WorkoutSessionModel.fromJson(response.data);
      return Right(session.id);
    } on DioException catch (e) {
      dev.log('❌ DioException during session creation: ${e.message}');
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      dev.log('❌ Unexpected error during session creation: $e');
      return Left(ServerFailure('Failed to create workout session: $e'));
    }
  }

  @override
  Future<Either<Failure, WorkoutExerciseModel>> addExerciseToWorkout({
    required String sessionId,
    String? exerciseId,
    String? customExerciseId,
  }) async {
    try {
      dev.log(
        '📤 Adding exercise to workout - Session: $sessionId',
        name: 'WorkoutRepository',
      );

      final response = await apiService.postRequest(
        ApiEndpoints.addExerciseToWorkout,
        queryParameters: {
          'sessionId': sessionId,
          if (exerciseId != null) 'exerciseId': exerciseId,
          if (customExerciseId != null) 'userExerciseId': customExerciseId,
        },
      );

      // ✅ Check status code BEFORE parsing
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          dev.log('❌ Empty response from server', name: 'WorkoutRepository');
          return Left(ServerFailure('No data received from server'));
        }

        dev.log('✅ Exercise added successfully', name: 'WorkoutRepository');
        return Right(WorkoutExerciseModel.fromJson(response.data));
      } else {
        // ✅ Handle non-success status codes
        dev.log(
          '❌ Failed to add exercise: ${response.statusCode}',
          name: 'WorkoutRepository',
        );
        return Left(
          ServerFailure.fromResponse(response.statusCode, response.data),
        );
      }
    } on DioException catch (e) {
      dev.log(
        '❌ DioException during add exercise: ${e.response?.statusCode}',
        name: 'WorkoutRepository',
      );

      // ✅ Use ServerFailure.fromDioException to properly parse error
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      dev.log(
        '❌ Unexpected error during add exercise: $e',
        name: 'WorkoutRepository',
      );
      return Left(ServerFailure('Failed to add exercise: $e'));
    }
  }

  @override
  Future<Either<Failure, List<WorkoutSessionModel>>> getWorkoutHistory({
    int pageSize = 20,
    int pageNumber = 1,
    DateTime? toDate,
  }) async {
    try {
      final response = await apiService.get(
        ApiEndpoints.getWorkoutHistory,
        queryParameters: {
          'pageSize': pageSize,
          'pageNumber': pageNumber,
          if (toDate != null) 'toDate': toDate.toIso8601String(),
        },
      );

      final sessions = (response.data as List)
          .map((json) => WorkoutSessionModel.fromJson(json))
          .toList();

      return Right(sessions);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure('Failed to load workout history: $e'));
    }
  }

  @override
  Future<Either<Failure, WorkoutSessionModel>> getSessionById(
    String sessionId,
  ) async {
    try {
      final response = await apiService.get(
        ApiEndpoints.getWorkoutSession,
        queryParameters: {'id': sessionId},
      );

      return Right(WorkoutSessionModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure('Failed to load workout session: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> startWorkoutSession(String sessionId) async {
    try {
      await apiService.putRequest(
        ApiEndpoints.startWorkoutSession,
        queryParameters: {'id': sessionId},
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure('Failed to start workout session: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> completeWorkoutSession(
    String sessionId,
    String? notes,
  ) async {
    try {
      await apiService.putRequest(
        ApiEndpoints.completeWorkoutSession,
        queryParameters: {
          'id': sessionId,
          if (notes != null && notes.isNotEmpty) 'notes': notes,
        },
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure('Failed to complete workout session: $e'));
    }
  }

  @override
  Future<Either<Failure, ExerciseSetModel>> addSetToExercise({
    required String sessionId,
    required String exerciseId,
    required int setNumber,
    required int reps,
    required double weightKg,
    int? restTimeSeconds,
    String? notes,
  }) async {
    try {
      final response = await apiService.postRequest(
        ApiEndpoints.addSetToExercise,
        queryParameters: {'sessionId': sessionId, 'exerciseId': exerciseId},
        data: {
          'setNumber': setNumber,
          'reps': reps,
          'weightKg': weightKg,
          if (restTimeSeconds != null) 'restTimeSeconds': restTimeSeconds,
          if (notes != null && notes.isNotEmpty) 'notes': notes,
        },
      );

      return Right(ExerciseSetModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure('Failed to add set: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateExerciseSet({
    required String sessionId,
    required String exerciseId,
    required String setId,
    required int setNumber,
    required int reps,
    required double weightKg,
    int? restTimeSeconds,
    String? notes,
    bool? isCompleted,
    bool? isPersonalRecord,
  }) async {
    try {
      final data = {
        'reps': reps,
        'weightKg': weightKg,
        if (restTimeSeconds != null) 'restTimeSeconds': restTimeSeconds,
        if (notes != null && notes.isNotEmpty) 'notes': notes,
      };

      final response = await apiService.patchRequest(
        ApiEndpoints.updateExerciseSet,
        queryParameters: {
          'sessionId': sessionId,
          'exerciseId': exerciseId,
          'setId': setId,
        },
        data: data,
      );

      if (response.statusCode != 200 && response.statusCode != 204) {
        return Left(ServerFailure('Failed to update exercise set'));
      }

      return const Right(null);
    } on DioException catch (e) {
      // If PATCH fails with 405, try PUT
      if (e.response?.statusCode == 405) {
        try {
          final data = {
            'reps': reps,
            'weightKg': weightKg,
            if (restTimeSeconds != null) 'restTimeSeconds': restTimeSeconds,
            if (notes != null && notes.isNotEmpty) 'notes': notes,
          };

          final response = await apiService.putRequest(
            ApiEndpoints.updateExerciseSet,
            queryParameters: {
              'sessionId': sessionId,
              'exerciseId': exerciseId,
              'setId': setId,
            },
            data: data,
          );

          if (response.statusCode != 200 && response.statusCode != 204) {
            return Left(ServerFailure('Failed to update exercise set'));
          }

          return const Right(null);
        } on DioException catch (putError) {
          return Left(ServerFailure.fromDioException(putError));
        }
      }

      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure('Error updating exercise set: $e'));
    }
  }

  @override
  Future<Either<Failure, String>> createSessionForTrainee({
    required String traineeId,
    required DateTime date,
    String? notes,
  }) async {
    try {
      dev.log(
        '📤 Creating workout session for trainee: $traineeId',
        name: 'WorkoutRepository',
      );

      final response = await apiService.postRequest(
        '/Trainer/trainees/$traineeId/sessions',
        queryParameters: {
          'date': date.toIso8601String(),
          if (notes != null && notes.isNotEmpty) 'notes': notes,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final session = WorkoutSessionModel.fromJson(response.data);
        dev.log(
          '✅ Workout session created for trainee: ${session.id}',
          name: 'WorkoutRepository',
        );
        return Right(session.id);
      } else {
        dev.log(
          '❌ Failed to create session: ${response.statusCode}',
          name: 'WorkoutRepository',
        );
        return Left(
          ServerFailure.fromResponse(response.statusCode, response.data),
        );
      }
    } on DioException catch (e) {
      dev.log(
        '❌ DioException during session creation: ${e.message}',
        name: 'WorkoutRepository',
      );
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      dev.log(
        '❌ Unexpected error during session creation: $e',
        name: 'WorkoutRepository',
      );
      return Left(
        ServerFailure('Failed to create workout session for trainee: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, List<WorkoutSessionModel>>>
  getWorkoutHistoryForTrainee({
    required String traineeId,
    int pageSize = 20,
    int pageNumber = 1,
  }) async {
    try {
      dev.log(
        '📤 Getting workout history for trainee: $traineeId',
        name: 'WorkoutRepository',
      );

      final response = await apiService.get(
        '/Trainer/trainees/$traineeId/sessions',
        queryParameters: {'pageSize': pageSize, 'pageNumber': pageNumber},
      );

      final sessions = (response.data as List)
          .map((json) => WorkoutSessionModel.fromJson(json))
          .toList();

      dev.log(
        '✅ Loaded ${sessions.length} workouts for trainee',
        name: 'WorkoutRepository',
      );

      return Right(sessions);
    } on DioException catch (e) {
      dev.log(
        '❌ DioException loading trainee workouts: ${e.message}',
        name: 'WorkoutRepository',
      );
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      dev.log(
        '❌ Error loading trainee workouts: $e',
        name: 'WorkoutRepository',
      );
      return Left(ServerFailure('Failed to load trainee workout history: $e'));
    }
  }
}
