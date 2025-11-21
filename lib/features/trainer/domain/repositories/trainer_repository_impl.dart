import 'package:dartz/dartz.dart';
import '../../../../core/networking/dio_helper.dart';
import '../../../../core/networking/error/failures.dart';
import '../../data/models/trainee_data.dart';
import '../../data/models/trainee_progress_data.dart';
import '../../data/models/trainer_dashboard_data.dart';
import '../../data/models/trainer_request.dart';
import '../../data/models/user_dto.dart';
import '../../data/models/workout_session_res.dart';
import 'trainer_repository.dart';

// Move from: lib/features/trainer/domain/repositories/trainer_repository_impl.dart
// To: lib/features/trainer/data/repositories/trainer_repository_impl.dart

import 'package:dartz/dartz.dart';

class TrainerRepositoryImpl implements TrainerRepository {
  final ApiService _apiService;

  TrainerRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, List<TraineeData>>> getTrainees() async {
    try {
      final response = await _apiService.get('/Trainer/trainees');
      final trainees = (response.data as List)
          .map((e) => TraineeData.fromJson(e))
          .toList();
      return Right(trainees);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // lib/features/trainer/data/repositories/trainer_repository_impl.dart
  // lib/features/trainer/data/repositories/trainer_repository_impl.dart

  @override
  Future<Either<Failure, TraineeData>> getTrainee(String traineeId) async {
    try {
      // Get all trainees (since the API returns a list)
      final response = await _apiService.get(
        '/Trainer/trainees', // Remove trailing slash
      );

      // Parse the list
      if (response.data is List) {
        final traineesList = response.data as List;

        // Find the trainee with matching ID
        final traineeJson = traineesList.firstWhere(
          (item) => item['traineeId'] == traineeId,
          orElse: () => null,
        );

        if (traineeJson != null) {
          return Right(
            TraineeData.fromJson(traineeJson as Map<String, dynamic>),
          );
        } else {
          return Left(ServerFailure('Trainee not found with ID: $traineeId'));
        }
      }

      return Left(ServerFailure('Invalid response format'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeTrainee(String traineeId) async {
    try {
      await _apiService.deleteRequest('/Trainer/trainees/$traineeId');
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TrainerDashboardData>> getDashboard() async {
    try {
      final response = await _apiService.get('/Trainer/dashboard');
      return Right(TrainerDashboardData.fromJson(response.data));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, WorkoutSessionRes>> createSessionForTrainee({
    required String traineeId,
    required DateTime date,
    String? notes,
  }) async {
    try {
      final response = await _apiService.postRequest(
        '/Trainer/trainees/$traineeId/sessions',
        queryParameters: {
          'date': date.toIso8601String(),
          if (notes != null) 'notes': notes,
        },
      );
      return Right(WorkoutSessionRes.fromJson(response.data));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<WorkoutSessionRes>>> getTraineeSessions({
    required String traineeId,
    int pageSize = 10,
    int pageNumber = 1,
  }) async {
    try {
      final response = await _apiService.get(
        '/Trainer/trainees/$traineeId/sessions',
        queryParameters: {'pageSize': pageSize, 'pageNumber': pageNumber},
      );
      final sessions = (response.data as List)
          .map((e) => WorkoutSessionRes.fromJson(e))
          .toList();
      return Right(sessions);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TraineeProgressData>> getTraineeProgress({
    required String traineeId,
    int days = 30,
    String? sectionId,
  }) async {
    try {
      final response = await _apiService.get(
        '/Trainer/trainees/$traineeId/progress',
        queryParameters: {
          'days': days,
          if (sectionId != null) 'sectionId': sectionId,
        },
      );
      return Right(TraineeProgressData.fromJson(response.data));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TrainerRequestResponse>>> getReceivedRequests({
    int pageSize = 10,
    int pageNumber = 1,
  }) async {
    try {
      final response = await _apiService.get(
        '/TrainerRequest/received',
        queryParameters: {'pageSize': pageSize, 'pageNumber': pageNumber},
      );
      final requests = (response.data['requests'] as List)
          .map((e) => TrainerRequestResponse.fromJson(e))
          .toList();
      return Right(requests);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TrainerRequestResponse>> acceptRequest(
    String requestId,
  ) async {
    try {
      final response = await _apiService.postRequest(
        '/TrainerRequest/accept/$requestId',
      );
      return Right(TrainerRequestResponse.fromJson(response.data));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TrainerRequestResponse>> rejectRequest(
    String requestId,
  ) async {
    try {
      final response = await _apiService.postRequest(
        '/TrainerRequest/reject/$requestId',
      );
      return Right(TrainerRequestResponse.fromJson(response.data));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TrainerRequestResponse>> sendRequest({
    required String userId,
    String? message,
  }) async {
    try {
      final response = await _apiService.postRequest(
        '/TrainerRequest/send',
        data: {'traineeId': userId, if (message != null) 'message': message},
      );
      return Right(TrainerRequestResponse.fromJson(response.data));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> cancelRequest(String requestId) async {
    try {
      await _apiService.deleteRequest('/TrainerRequest/cancel/$requestId');
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UserDto>>> getAllUsers({
    String? searchTerm,
    int pageSize = 10,
    int pageNumber = 1,
  }) async {
    try {
      final response = await _apiService.get(
        '/TrainerRequest/all-users',
        queryParameters: {
          if (searchTerm != null) 'searchTerm': searchTerm,
          'pageSize': pageSize,
          'pageNumber': pageNumber,
        },
      );
      final users = (response.data as List)
          .map((e) => UserDto.fromJson(e))
          .toList();
      return Right(users);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
