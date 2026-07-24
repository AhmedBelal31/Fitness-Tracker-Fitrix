// lib/features/trainer/domain/repositories/trainer_repository.dart
import 'package:dartz/dartz.dart';
import '../../../../core/networking/error/failures.dart';
import '../../data/models/trainee_data.dart';
import '../../data/models/trainee_progress_data.dart';
import '../../data/models/trainer_dashboard_data.dart';
import '../../data/models/trainer_request.dart';
import '../../data/models/user_dto.dart';
import '../../data/models/workout_session_res.dart';

abstract class TrainerRepository {
  Future<Either<Failure, List<TraineeData>>> getTrainees();

  Future<Either<Failure, TraineeData>> getTrainee(String traineeId);

  Future<Either<Failure, Unit>> removeTrainee(String traineeId);

  Future<Either<Failure, TrainerDashboardData>> getDashboard();

  Future<Either<Failure, WorkoutSessionRes>> createSessionForTrainee({
    required String traineeId,
    required DateTime date,
    String? notes,
  });

  Future<Either<Failure, List<WorkoutSessionRes>>> getTraineeSessions({
    required String traineeId,
    int pageSize = 10,
    int pageNumber = 1,
  });

  Future<Either<Failure, TraineeProgressData>> getTraineeProgress({
    required String traineeId,
    int days = 30,
    String? sectionId,
  });

  Future<Either<Failure, List<TrainerRequestResponse>>> getReceivedRequests({
    int pageSize = 10,
    int pageNumber = 1,
  });

  Future<Either<Failure, TrainerRequestResponse>> acceptRequest(
    String requestId,
  );

  Future<Either<Failure, TrainerRequestResponse>> rejectRequest(
    String requestId,
  );

  Future<Either<Failure, TrainerRequestResponse>> sendRequest({
    required String userId,
    String? message,
  });

  Future<Either<Failure, Unit>> cancelRequest(String requestId);

  Future<Either<Failure, List<UserDto>>> getAllUsers({
    String? searchTerm,
    int pageSize = 10,
    int pageNumber = 1,
  });
}
