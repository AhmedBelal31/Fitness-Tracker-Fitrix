import 'package:dartz/dartz.dart';
import '../../../../core/networking/error/failures.dart';
import '../../data/models/trainee_request_model.dart';

abstract class TrainerRequestsRepository {
  Future<Either<Failure, List<TraineeRequest>>> getSentRequests({
    int pageSize = 10,
    int pageNumber = 1,
  });

  Future<Either<Failure, List<Trainee>>> getAllTrainees({
    String searchTerm = '',
    int pageSize = 20,
    int pageNumber = 1,
  });

  Future<Either<Failure, void>> acceptRequest(String requestId);

  Future<Either<Failure, void>> rejectRequest(String requestId);

  // ✅ ADD THIS
  Future<Either<Failure, void>> sendRequest(
    String traineeId, {
    String? message,
  });
}
