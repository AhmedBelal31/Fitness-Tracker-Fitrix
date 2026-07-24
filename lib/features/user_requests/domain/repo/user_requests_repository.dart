import 'package:dartz/dartz.dart';
import '../../../../core/networking/error/failures.dart';
import '../../data/trainer.dart';
import '../../data/user_request.dart';

abstract class UserRequestsRepository {
  /// Send a trainer request to a specific trainer by ID
  Future<Either<Failure, void>> sendRequest(
    String trainerId, {
    String? message,
  });

  /// Get all sent requests (requests sent by the user)
  /// Supports pagination
  Future<Either<Failure, List<UserRequest>>> getSentRequests({
    int pageSize = 10,
    int pageNumber = 1,
  });

  /// Get all received requests (requests received from trainers)
  /// Supports pagination
  Future<Either<Failure, List<UserRequest>>> getReceivedRequests({
    int pageSize = 10,
    int pageNumber = 1,
  });

  /// Cancel a sent request by ID
  Future<Either<Failure, void>> cancelRequest(String requestId);

  /// Accept a received request by ID
  Future<Either<Failure, void>> acceptRequest(String requestId);

  /// Reject a received request by ID
  Future<Either<Failure, void>> rejectRequest(String requestId);

  /// Get all available trainers with search and pagination support
  Future<Either<Failure, List<Trainer>>> getAllTrainers({
    String searchTerm = '',
    int pageSize = 10,
    int pageNumber = 1,
  });

  /// Get details of a specific request by ID
  Future<Either<Failure, UserRequest>> getRequestById(String requestId);
}
