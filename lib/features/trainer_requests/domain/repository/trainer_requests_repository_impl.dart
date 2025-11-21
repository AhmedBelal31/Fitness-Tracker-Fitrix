import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/helpers/repository_helper.dart';
import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/dio_helper.dart';
import '../../../../core/networking/error/failures.dart';
import '../../data/models/trainee_request_model.dart';
import '../../domain/repository/trainer_requests_repository.dart';

//
// class TrainerRequestsRepositoryImpl extends RepositoryHelper
//     implements TrainerRequestsRepository {
//   final ApiService _apiService;
//
//   TrainerRequestsRepositoryImpl(this._apiService);
//
//   @override
//   Future<Either<Failure, List<TraineeRequest>>> getSentRequests({
//     int pageSize = 10,
//     int pageNumber = 1,
//   }) => execute(() async {
//     final response = await _apiService.get(
//       ApiEndpoints.receivedTrainerRequests,
//       queryParameters: {'pageSize': pageSize, 'pageNumber': pageNumber},
//     );
//
//     if (response.data == null || response.data == '') {
//       return [];
//     }
//
//     if (response.data is! Map<String, dynamic>) {
//       throw Exception('Invalid response format: ${response.data}');
//     }
//
//     final responseData = response.data as Map<String, dynamic>;
//
//     if (!responseData.containsKey('requests')) {
//       throw Exception('Missing "requests" key in response');
//     }
//
//     final requestsList = responseData['requests'];
//
//     if (requestsList is! List) {
//       throw Exception(
//         'Invalid "requests" format: expected List, got ${requestsList.runtimeType}',
//       );
//     }
//
//     return requestsList
//         .map((json) => TraineeRequest.fromJson(json as Map<String, dynamic>))
//         .where((request) => request.isPending)
//         .toList();
//   });
//
//   @override
//   Future<Either<Failure, void>> acceptRequest(String requestId) =>
//       execute(() async {
//         try {
//           final res = await _apiService.postRequest(
//             ApiEndpoints.acceptTrainerRequest(requestId),
//           );
//           if (res.statusCode == 200 || res.statusCode == 204) return;
//           throw DioException(requestOptions: res.requestOptions, response: res);
//         } catch (e) {
//           if (e is DioException && e.response?.statusCode == 500) {
//             final errorData = e.response?.data;
//             if (errorData is Map) {
//               final ioError = errorData['errors']?['IO']?.toString() ?? '';
//               if (ioError.contains('filename')) {
//                 return;
//               }
//             }
//           }
//           rethrow;
//         }
//       });
//
//   @override
//   Future<Either<Failure, void>> rejectRequest(String requestId) =>
//       execute(() async {
//         try {
//           final res = await _apiService.postRequest(
//             ApiEndpoints.rejectTrainerRequest(requestId),
//           );
//           if (res.statusCode == 200 || res.statusCode == 204) return;
//           throw DioException(requestOptions: res.requestOptions, response: res);
//         } catch (e) {
//           if (e is DioException && e.response?.statusCode == 500) {
//             final errorData = e.response?.data;
//             if (errorData is Map) {
//               final ioError = errorData['errors']?['IO']?.toString() ?? '';
//               if (ioError.contains('filename')) {
//                 return;
//               }
//             }
//           }
//           rethrow;
//         }
//       });
// }

class TrainerRequestsRepositoryImpl extends RepositoryHelper
    implements TrainerRequestsRepository {
  final ApiService _apiService;

  TrainerRequestsRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, List<TraineeRequest>>> getSentRequests({
    int pageSize = 10,
    int pageNumber = 1,
  }) => execute(() async {
    final response = await _apiService.get(
      ApiEndpoints.receivedTrainerRequests,
      queryParameters: {'pageSize': pageSize, 'pageNumber': pageNumber},
    );

    if (response.data == null || response.data == '') {
      return [];
    }

    if (response.data is! Map<String, dynamic>) {
      throw Exception('Invalid response format: ${response.data}');
    }

    final responseData = response.data as Map<String, dynamic>;

    if (!responseData.containsKey('requests')) {
      throw Exception('Missing "requests" key in response');
    }

    final requestsList = responseData['requests'];

    if (requestsList is! List) {
      throw Exception(
        'Invalid "requests" format: expected List, got ${requestsList.runtimeType}',
      );
    }

    // Parse and filter pending requests
    return requestsList
        .map((json) => TraineeRequest.fromJson(json as Map<String, dynamic>))
        .where((request) => request.isPending)
        .toList();
  });

  @override
  Future<Either<Failure, List<Trainee>>> getAllTrainees({
    String searchTerm = '',
    int pageSize = 20,
    int pageNumber = 1,
  }) => execute(() async {
    final response = await _apiService.get(
      ApiEndpoints.allUsers, // ✅ FIXED: Changed to correct endpoint
      queryParameters: {
        'searchTerm': searchTerm,
        'pageSize': pageSize,
        'pageNumber': pageNumber,
      },
    );

    if (response.data == null) {
      return [];
    }

    // ✅ The endpoint returns array of UserDto directly
    if (response.data is! List) {
      throw Exception(
        'Invalid response format: expected List, got ${response.data.runtimeType}',
      );
    }

    return (response.data as List)
        .map((json) => Trainee.fromJson(json as Map<String, dynamic>))
        .toList();
  });

  @override
  Future<Either<Failure, void>> acceptRequest(String requestId) =>
      execute(() async {
        try {
          final res = await _apiService.postRequest(
            ApiEndpoints.acceptTrainerRequest(requestId),
          );

          if (res.statusCode == 200 || res.statusCode == 204) {
            return;
          }

          throw DioException(requestOptions: res.requestOptions, response: res);
        } catch (e) {
          if (e is DioException && e.response?.statusCode == 500) {
            final errorData = e.response?.data;
            if (errorData is Map) {
              final ioError = errorData['errors']?['IO']?.toString() ?? '';
              if (ioError.contains('filename')) {
                return;
              }
            }
          }
          rethrow;
        }
      });

  @override
  Future<Either<Failure, void>> rejectRequest(String requestId) =>
      execute(() async {
        try {
          final res = await _apiService.postRequest(
            ApiEndpoints.rejectTrainerRequest(requestId),
          );

          if (res.statusCode == 200 || res.statusCode == 204) {
            return;
          }

          throw DioException(requestOptions: res.requestOptions, response: res);
        } catch (e) {
          if (e is DioException && e.response?.statusCode == 500) {
            final errorData = e.response?.data;
            if (errorData is Map) {
              final ioError = errorData['errors']?['IO']?.toString() ?? '';
              if (ioError.contains('filename')) {
                return;
              }
            }
          }
          rethrow;
        }
      });

  @override
  Future<Either<Failure, void>> sendRequest(
    String traineeId, {
    String? message,
  }) => execute(() async {
    try {
      final res = await _apiService.postRequest(
        ApiEndpoints.sendTrainerRequest,
        queryParameters: {'traineeId': traineeId},
        data: {
          'message': message, // ✅ Always send message (can be null)
        },
      );

      if (res.statusCode == 200 ||
          res.statusCode == 201 ||
          res.statusCode == 204) {
        return;
      }

      throw DioException(requestOptions: res.requestOptions, response: res);
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 500) {
        final errorData = e.response?.data;
        if (errorData is Map) {
          final ioError = errorData['errors']?['IO']?.toString() ?? '';
          if (ioError.contains('filename')) {
            return;
          }
        }
      }
      rethrow;
    }
  });
}
