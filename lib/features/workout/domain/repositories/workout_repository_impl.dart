import 'package:dio/dio.dart';
import 'package:fitrix/core/networking/dio_helper.dart';
import '../../../../../core/networking/api_constants.dart';
import '../../data/workout_session_model.dart';
import 'workout_repository.dart';

class WorkoutRepositoryImpl implements WorkoutRepository {
  final ApiService apiService;

  WorkoutRepositoryImpl({required this.apiService});

  @override
  Future<String> createSession({required DateTime date, String? notes}) async {
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
      return session.id;
    } catch (e) {
      throw Exception('Failed to create workout session: $e');
    }
  }

  @override
  Future<List<WorkoutSessionModel>> getWorkoutHistory({
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

      return (response.data as List)
          .map((json) => WorkoutSessionModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to load workout history: $e');
    }
  }

  @override
  Future<WorkoutSessionModel> getSessionById(String sessionId) async {
    try {
      final response = await apiService.get(
        ApiEndpoints.getWorkoutSession,
        queryParameters: {'id': sessionId},
      );

      return WorkoutSessionModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load workout session: $e');
    }
  }

  @override
  Future<WorkoutExerciseModel> addExerciseToWorkout({
    required String sessionId,
    String? exerciseId,
    String? customExerciseId,
  }) async {
    try {
      final response = await apiService.postRequest(
        ApiEndpoints.addExerciseToWorkout,
        queryParameters: {
          'sessionId': sessionId,
          if (exerciseId != null) 'exerciseId': exerciseId,
          if (customExerciseId != null) 'userExerciseId': customExerciseId,
        },
      );

      if (response.data == null) {
        throw Exception('Empty response from server');
      }

      return WorkoutExerciseModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        final errors = e.response?.data['errors'];
        if (errors != null && errors['Session_Completed'] != null) {
          throw Exception('Cannot add exercises to completed session');
        }
        throw Exception(e.response?.data['title'] ?? 'Bad request');
      }
      throw Exception('Failed to add exercise to workout: ${e.message}');
    } catch (e) {
      throw Exception('Failed to add exercise to workout: $e');
    }
  }

  @override
  Future<void> startWorkoutSession(String sessionId) async {
    try {
      await apiService.putRequest(
        ApiEndpoints.startWorkoutSession,
        queryParameters: {'id': sessionId},
      );
    } catch (e) {
      throw Exception('Failed to start workout session: $e');
    }
  }

  // @override
  // Future<void> completeWorkoutSession(String sessionId, String? notes) async {
  //   try {
  //     await apiService.postRequest(
  //       ApiEndpoints.completeWorkoutSession,
  //       queryParameters: {'id': sessionId, if (notes != null) 'notes': notes},
  //     );
  //   } catch (e) {
  //     throw Exception('Failed to complete workout session: $e');
  //   }
  // }
  @override
  Future<void> completeWorkoutSession(String sessionId, String? notes) async {
    try {
      await apiService.putRequest(
        ApiEndpoints.completeWorkoutSession,
        queryParameters: {
          'id': sessionId,
          if (notes != null && notes.isNotEmpty) 'notes': notes,
        },
      );
    } catch (e) {
      throw Exception('Failed to complete workout session: $e');
    }
  }

  @override
  Future<ExerciseSetModel> addSetToExercise({
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

      return ExerciseSetModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to add set: $e');
    }
  }

  @override
  Future<void> updateExerciseSet({
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
      // ✅ Try PATCH first (common for partial updates)
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
        throw Exception('Failed to update exercise set');
      }
    } on DioException catch (e) {
      // ✅ If PATCH fails with 405, try PUT
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
            throw Exception('Failed to update exercise set');
          }
        } catch (putError) {
          throw Exception('Error updating exercise set: $putError');
        }
      } else {
        throw Exception('Error updating exercise set: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error updating exercise set: $e');
    }
  }
}
