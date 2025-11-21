import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitrix/features/user_requests/data/user_request.dart';
import 'dart:developer' as dev;
import '../../../../core/helpers/repository_helper.dart';
import '../../../../core/networking/dio_helper.dart';
import '../../../../core/networking/error/failures.dart';
import '../../../../core/networking/api_constants.dart';
import '../../data/trainer.dart';
import 'user_requests_repository.dart';

// class UserRequestsRepositoryImpl implements UserRequestsRepository {
//   final ApiService _apiService;
//
//   UserRequestsRepositoryImpl(this._apiService);
//
//   // ✅ Send a request to a trainer
//   // ✅ Send a request to a trainer
//   @override
//   // ✅ Send a request to a trainer
//   @override
//   Future<Either<Failure, void>> sendRequest(
//     String trainerId, {
//     String? message,
//   }) async {
//     try {
//       dev.log(
//         '📤 Sending request to trainer: $trainerId',
//         name: 'UserRequestsRepo',
//       );
//
//       final res = await _apiService.postRequest(
//         ApiEndpoints.sendUserRequest,
//         queryParameters: {'TrainerId': trainerId},
//         data: {
//           'message': message, // ✅ Optional message from user
//         },
//       );
//
//       if (res.statusCode == 200 ||
//           res.statusCode == 201 ||
//           res.statusCode == 204) {
//         dev.log('✅ Request sent successfully', name: 'UserRequestsRepo');
//         return const Right(null);
//       } else {
//         dev.log(
//           '❌ Failed to send request (${res.statusCode})',
//           name: 'UserRequestsRepo',
//         );
//         return Left(ServerFailure.fromResponse(res.statusCode, res.data));
//       }
//     } on DioException catch (e) {
//       dev.log('❌ DioException: ${e.message}', name: 'UserRequestsRepo');
//       return Left(ServerFailure.fromDioException(e));
//     } catch (e) {
//       dev.log('❌ Unexpected error: $e', name: 'UserRequestsRepo');
//       return Left(ServerFailure(e.toString()));
//     }
//   }
//
//   // ✅ Get all sent requests (with pagination)
//   // ✅ Get all sent requests (sent by the user)
//   @override
//   Future<Either<Failure, List<UserRequest>>> getSentRequests({
//     int pageSize = 10,
//     int pageNumber = 1,
//   }) async {
//     try {
//       dev.log('📡 Fetching sent requests...', name: 'UserRequestsRepo');
//
//       final response = await _apiService.get(
//         ApiEndpoints.sentUserRequests,
//         queryParameters: {'pageSize': pageSize, 'pageNumber': pageNumber},
//       );
//
//       if (response.statusCode == 200) {
//         // ✅ Parse the wrapper object
//         final responseData = response.data as Map<String, dynamic>;
//         final requestsList = responseData['requests'] as List;
//
//         final data = requestsList
//             .map((json) => UserRequest.fromJson(json))
//             .toList();
//
//         dev.log(
//           '✅ ${data.length} sent requests fetched.',
//           name: 'UserRequestsRepo',
//         );
//         return Right(data);
//       } else {
//         dev.log(
//           '❌ Failed to fetch sent requests (${response.statusCode})',
//           name: 'UserRequestsRepo',
//         );
//         return Left(
//           ServerFailure.fromResponse(response.statusCode, response.data),
//         );
//       }
//     } on DioException catch (e) {
//       dev.log('❌ DioException: ${e.message}', name: 'UserRequestsRepo');
//       return Left(ServerFailure.fromDioException(e));
//     } catch (e) {
//       dev.log('❌ Unexpected error: $e', name: 'UserRequestsRepo');
//       return Left(ServerFailure(e.toString()));
//     }
//   }
//
//   // ✅ Get all received requests (with pagination)
//   // ✅ Get all received requests (from trainers)
//   @override
//   Future<Either<Failure, List<UserRequest>>> getReceivedRequests({
//     int pageSize = 10,
//     int pageNumber = 1,
//   }) async {
//     try {
//       dev.log('📡 Fetching received requests...', name: 'UserRequestsRepo');
//
//       final response = await _apiService.get(
//         ApiEndpoints.receivedUserRequests,
//         queryParameters: {'pageSize': pageSize, 'pageNumber': pageNumber},
//       );
//
//       if (response.statusCode == 200) {
//         final responseData = response.data as Map<String, dynamic>;
//         final requestsList = responseData['requests'] as List;
//
//         final data = requestsList
//             .map((json) => UserRequest.fromJson(json))
//             .where((request) => request.isPending) // ✅ Only pending
//             .toList();
//
//         dev.log(
//           '✅ ${data.length} pending requests fetched.',
//           name: 'UserRequestsRepo',
//         );
//         return Right(data);
//       } else {
//         dev.log(
//           '❌ Failed to fetch received requests (${response.statusCode})',
//           name: 'UserRequestsRepo',
//         );
//         return Left(
//           ServerFailure.fromResponse(response.statusCode, response.data),
//         );
//       }
//     } on DioException catch (e) {
//       dev.log('❌ DioException: ${e.message}', name: 'UserRequestsRepo');
//       return Left(ServerFailure.fromDioException(e));
//     } catch (e) {
//       dev.log('❌ Unexpected error: $e', name: 'UserRequestsRepo');
//       return Left(ServerFailure(e.toString()));
//     }
//   }
//
//   // ✅ Cancel a sent request
//   @override
//   Future<Either<Failure, void>> cancelRequest(String requestId) async {
//     try {
//       dev.log('📤 Canceling request: $requestId', name: 'UserRequestsRepo');
//
//       final res = await _apiService.deleteRequest(
//         ApiEndpoints.cancelUserRequest(requestId),
//       );
//
//       if (res.statusCode == 200 || res.statusCode == 204) {
//         dev.log('✅ Request canceled successfully', name: 'UserRequestsRepo');
//         return const Right(null);
//       } else {
//         dev.log(
//           '❌ Failed to cancel request (${res.statusCode})',
//           name: 'UserRequestsRepo',
//         );
//         return Left(ServerFailure.fromResponse(res.statusCode, res.data));
//       }
//     } on DioException catch (e) {
//       dev.log('❌ DioException: ${e.message}', name: 'UserRequestsRepo');
//       return Left(ServerFailure.fromDioException(e));
//     } catch (e) {
//       dev.log('❌ Unexpected error: $e', name: 'UserRequestsRepo');
//       return Left(ServerFailure(e.toString()));
//     }
//   }
//
//   // ✅ Accept a received request
//   @override
//   Future<Either<Failure, void>> acceptRequest(String requestId) async {
//     try {
//       dev.log('📤 Accepting request: $requestId', name: 'UserRequestsRepo');
//
//       final res = await _apiService.postRequest(
//         ApiEndpoints.acceptUserRequest(requestId),
//       );
//
//       if (res.statusCode == 200 || res.statusCode == 204) {
//         dev.log('✅ Request accepted successfully', name: 'UserRequestsRepo');
//         return const Right(null);
//       } else {
//         dev.log(
//           '❌ Failed to accept request (${res.statusCode})',
//           name: 'UserRequestsRepo',
//         );
//         return Left(ServerFailure.fromResponse(res.statusCode, res.data));
//       }
//     } on DioException catch (e) {
//       dev.log('❌ DioException: ${e.message}', name: 'UserRequestsRepo');
//       return Left(ServerFailure.fromDioException(e));
//     } catch (e) {
//       dev.log('❌ Unexpected error: $e', name: 'UserRequestsRepo');
//       return Left(ServerFailure(e.toString()));
//     }
//   }
//
//   // ✅ Reject a received request
//   @override
//   Future<Either<Failure, void>> rejectRequest(String requestId) async {
//     try {
//       dev.log('📤 Rejecting request: $requestId', name: 'UserRequestsRepo');
//
//       final res = await _apiService.postRequest(
//         ApiEndpoints.rejectUserRequest(requestId),
//       );
//
//       if (res.statusCode == 200 || res.statusCode == 204) {
//         dev.log('✅ Request rejected successfully', name: 'UserRequestsRepo');
//         return const Right(null);
//       } else {
//         dev.log(
//           '❌ Failed to reject request (${res.statusCode})',
//           name: 'UserRequestsRepo',
//         );
//         return Left(ServerFailure.fromResponse(res.statusCode, res.data));
//       }
//     } on DioException catch (e) {
//       dev.log('❌ DioException: ${e.message}', name: 'UserRequestsRepo');
//       return Left(ServerFailure.fromDioException(e));
//     } catch (e) {
//       dev.log('❌ Unexpected error: $e', name: 'UserRequestsRepo');
//       return Left(ServerFailure(e.toString()));
//     }
//   }
//
//   // ✅ Get all trainers (with search and pagination)
//   @override
//   Future<Either<Failure, List<Trainer>>> getAllTrainers({
//     String searchTerm = '',
//     int pageSize = 10,
//     int pageNumber = 1,
//   }) async {
//     try {
//       dev.log('📡 Fetching trainers...', name: 'UserRequestsRepo');
//
//       final response = await _apiService.get(
//         ApiEndpoints.allTrainers,
//         queryParameters: {
//           'searchTerm': searchTerm,
//           'pageSize': pageSize,
//           'pageNumber': pageNumber,
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final data = (response.data as List)
//             .map((json) => Trainer.fromJson(json))
//             .toList();
//
//         dev.log('✅ ${data.length} trainers fetched.', name: 'UserRequestsRepo');
//         return Right(data);
//       } else {
//         dev.log(
//           '❌ Failed to fetch trainers (${response.statusCode})',
//           name: 'UserRequestsRepo',
//         );
//         return Left(
//           ServerFailure.fromResponse(response.statusCode, response.data),
//         );
//       }
//     } on DioException catch (e) {
//       dev.log('❌ DioException: ${e.message}', name: 'UserRequestsRepo');
//       return Left(ServerFailure.fromDioException(e));
//     } catch (e) {
//       dev.log('❌ Unexpected error: $e', name: 'UserRequestsRepo');
//       return Left(ServerFailure(e.toString()));
//     }
//   }
//
//   // ✅ Get request details by ID
//   @override
//   Future<Either<Failure, UserRequest>> getRequestById(String requestId) async {
//     try {
//       dev.log(
//         '📡 Fetching request details: $requestId',
//         name: 'UserRequestsRepo',
//       );
//
//       final response = await _apiService.get(
//         ApiEndpoints.getUserRequestById(requestId),
//       );
//
//       if (response.statusCode == 200) {
//         final request = UserRequest.fromJson(response.data);
//         dev.log('✅ Request details fetched.', name: 'UserRequestsRepo');
//         return Right(request);
//       } else {
//         dev.log(
//           '❌ Failed to fetch request details (${response.statusCode})',
//           name: 'UserRequestsRepo',
//         );
//         return Left(
//           ServerFailure.fromResponse(response.statusCode, response.data),
//         );
//       }
//     } on DioException catch (e) {
//       dev.log('❌ DioException: ${e.message}', name: 'UserRequestsRepo');
//       return Left(ServerFailure.fromDioException(e));
//     } catch (e) {
//       dev.log('❌ Unexpected error: $e', name: 'UserRequestsRepo');
//       return Left(ServerFailure(e.toString()));
//     }
//   }
// }

class UserRequestsRepositoryImpl extends RepositoryHelper
    implements UserRequestsRepository {
  final ApiService _apiService;

  UserRequestsRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, void>> sendRequest(
    String trainerId, {
    String? message,
  }) => execute(() async {
    final res = await _apiService.postRequest(
      ApiEndpoints.sendUserRequest,
      queryParameters: {'TrainerId': trainerId},
      data: {'message': message},
    );

    // ✅ Check for success status codes
    if (res.statusCode == 200 ||
        res.statusCode == 201 ||
        res.statusCode == 204) {
      return;
    }

    // ✅ Throw error for any other status (including 409)
    throw DioException(requestOptions: res.requestOptions, response: res);
  });

  // @override
  // Future<Either<Failure, List<UserRequest>>> getReceivedRequests({
  //   int pageSize = 10,
  //   int pageNumber = 1,
  // }) => execute(() async {
  //   final response = await _apiService.get(
  //     ApiEndpoints.receivedUserRequests,
  //     queryParameters: {'pageSize': pageSize, 'pageNumber': pageNumber},
  //   );
  //   final responseData = response.data as Map<String, dynamic>;
  //   final requestsList = responseData['requests'] as List;
  //   return requestsList
  //       .map((json) => UserRequest.fromJson(json))
  //       .where((request) => request.isPending)
  //       .toList();
  // });
  Future<Either<Failure, List<UserRequest>>> getReceivedRequests({
    int pageSize = 10,
    int pageNumber = 1,
  }) async {
    try {
      final response = await _apiService.get(
        ApiEndpoints.receivedUserRequests,
        queryParameters: {'pageSize': pageSize, 'pageNumber': pageNumber},
      );

      // Parse the nested response
      final responseData = UserRequestResponse.fromJson(response.data);

      // Only return pending requests (status = 1)
      final pendingRequests = responseData.requests
          .where((request) => request.status == 1)
          .toList();

      return Right(pendingRequests);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UserRequest>>> getSentRequests({
    int pageSize = 10,
    int pageNumber = 1,
  }) => execute(() async {
    final response = await _apiService.get(
      ApiEndpoints.sentUserRequests,
      queryParameters: {'pageSize': pageSize, 'pageNumber': pageNumber},
    );
    final responseData = response.data as Map<String, dynamic>;
    final requestsList = responseData['requests'] as List;
    return requestsList.map((json) => UserRequest.fromJson(json)).toList();
  });

  @override
  Future<Either<Failure, void>> acceptRequest(String requestId) =>
      execute(() async {
        final res = await _apiService.postRequest(
          ApiEndpoints.acceptUserRequest(requestId),
        );
        if (res.statusCode == 200 || res.statusCode == 204) return;
        throw DioException(requestOptions: res.requestOptions, response: res);
      });

  @override
  Future<Either<Failure, void>> rejectRequest(String requestId) =>
      execute(() async {
        final res = await _apiService.postRequest(
          ApiEndpoints.rejectUserRequest(requestId),
        );
        if (res.statusCode == 200 || res.statusCode == 204) return;
        throw DioException(requestOptions: res.requestOptions, response: res);
      });

  @override
  Future<Either<Failure, void>> cancelRequest(String requestId) =>
      execute(() async {
        final res = await _apiService.deleteRequest(
          ApiEndpoints.cancelUserRequest(requestId),
        );
        if (res.statusCode == 200 || res.statusCode == 204) return;
        throw DioException(requestOptions: res.requestOptions, response: res);
      });

  @override
  Future<Either<Failure, List<Trainer>>> getAllTrainers({
    String searchTerm = '',
    int pageSize = 10,
    int pageNumber = 1,
  }) => execute(() async {
    final response = await _apiService.get(
      ApiEndpoints.allTrainers,
      queryParameters: {
        'searchTerm': searchTerm,
        'pageSize': pageSize,
        'pageNumber': pageNumber,
      },
    );
    return (response.data as List)
        .map((json) => Trainer.fromJson(json))
        .toList();
  });

  @override
  Future<Either<Failure, UserRequest>> getRequestById(String requestId) =>
      execute(() async {
        final response = await _apiService.get(
          ApiEndpoints.getUserRequestById(requestId),
        );
        return UserRequest.fromJson(response.data);
      });
}
