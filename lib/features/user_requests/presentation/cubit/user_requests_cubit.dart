import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repo/user_requests_repository.dart';
import 'user_requests_state.dart';
import 'dart:async';

// class UserRequestsCubit extends Cubit<UserRequestsState> {
//   final UserRequestsRepository _repository;
//   Timer? _debounceTimer;
//
//   UserRequestsCubit(this._repository) : super(UserRequestsInitial());
//
//   // ✅ Fetch received requests
//   Future<void> getReceivedRequests({
//     int pageSize = 10,
//     int pageNumber = 1,
//   }) async {
//     // Set loading for requests
//     if (state is UserRequestsData) {
//       emit((state as UserRequestsData).copyWith(isRequestsLoading: true));
//     } else {
//       emit(UserRequestsData(isRequestsLoading: true));
//     }
//
//     final result = await _repository.getReceivedRequests(
//       pageSize: pageSize,
//       pageNumber: pageNumber,
//     );
//
//     result.fold(
//       (failure) {
//         if (state is UserRequestsData) {
//           emit(
//             (state as UserRequestsData).copyWith(
//               isRequestsLoading: false,
//               error: failure.errorMessage,
//             ),
//           );
//         } else {
//           emit(
//             UserRequestsData(
//               isRequestsLoading: false,
//               error: failure.errorMessage,
//             ),
//           );
//         }
//       },
//       (requests) {
//         if (state is UserRequestsData) {
//           emit(
//             (state as UserRequestsData).copyWith(
//               requests: requests,
//               isRequestsLoading: false,
//               error: null,
//             ),
//           );
//         } else {
//           emit(UserRequestsData(requests: requests, isRequestsLoading: false));
//         }
//       },
//     );
//   }
//
//   // ✅ Accept request
//   Future<void> acceptRequest(String requestId) async {
//     final result = await _repository.acceptRequest(requestId);
//     result.fold(
//       (failure) {
//         // Emit error state
//         if (state is UserRequestsData) {
//           emit(
//             (state as UserRequestsData).copyWith(error: failure.errorMessage),
//           );
//         }
//       },
//       (_) {
//         // Refresh requests on success
//         getReceivedRequests();
//       },
//     );
//   }
//
//   // ✅ Reject request
//   Future<void> rejectRequest(String requestId) async {
//     final result = await _repository.rejectRequest(requestId);
//     result.fold(
//       (failure) {
//         // Emit error state
//         if (state is UserRequestsData) {
//           emit(
//             (state as UserRequestsData).copyWith(error: failure.errorMessage),
//           );
//         }
//       },
//       (_) {
//         // Refresh requests on success
//         getReceivedRequests();
//       },
//     );
//   }
//
//   Future<void> sendRequest(String trainerId, {String? message}) async {
//     final result = await _repository.sendRequest(trainerId, message: message);
//
//     result.fold(
//       (failure) {
//         // ✅ Emit error state
//         if (state is UserRequestsData) {
//           emit(
//             (state as UserRequestsData).copyWith(error: failure.errorMessage),
//           );
//         }
//       },
//       (_) {
//         // ✅ Only refresh on success
//         getAllTrainers();
//       },
//     );
//   }
//
//   // ✅ Get all trainers with search (debounced)
//   void searchTrainers(
//     String searchTerm, {
//     int pageSize = 20,
//     int pageNumber = 1,
//   }) {
//     _debounceTimer?.cancel();
//     _debounceTimer = Timer(const Duration(milliseconds: 500), () {
//       _fetchTrainers(
//         searchTerm: searchTerm,
//         pageSize: pageSize,
//         pageNumber: pageNumber,
//       );
//     });
//   }
//
//   // ✅ Fetch trainers (called after debounce)
//   Future<void> _fetchTrainers({
//     String searchTerm = '',
//     int pageSize = 20,
//     int pageNumber = 1,
//   }) async {
//     // Set loading for trainers
//     if (state is UserRequestsData) {
//       emit((state as UserRequestsData).copyWith(isTrainersLoading: true));
//     } else {
//       emit(UserRequestsData(isTrainersLoading: true));
//     }
//
//     final result = await _repository.getAllTrainers(
//       searchTerm: searchTerm,
//       pageSize: pageSize,
//       pageNumber: pageNumber,
//     );
//
//     result.fold(
//       (failure) {
//         if (state is UserRequestsData) {
//           emit(
//             (state as UserRequestsData).copyWith(
//               isTrainersLoading: false,
//               error: failure.errorMessage,
//             ),
//           );
//         } else {
//           emit(
//             UserRequestsData(
//               isTrainersLoading: false,
//               error: failure.errorMessage,
//             ),
//           );
//         }
//       },
//       (trainers) {
//         if (state is UserRequestsData) {
//           emit(
//             (state as UserRequestsData).copyWith(
//               trainers: trainers,
//               isTrainersLoading: false,
//               error: null,
//             ),
//           );
//         } else {
//           emit(UserRequestsData(trainers: trainers, isTrainersLoading: false));
//         }
//       },
//     );
//   }
//
//   // ✅ Get trainers without debounce (initial load)
//   Future<void> getAllTrainers({int pageSize = 20, int pageNumber = 1}) async {
//     await _fetchTrainers(
//       searchTerm: '',
//       pageSize: pageSize,
//       pageNumber: pageNumber,
//     );
//   }
//
//   @override
//   Future<void> close() {
//     _debounceTimer?.cancel();
//     return super.close();
//   }
// }
// user_requests_state.dart

class UserRequestsCubit extends Cubit<UserRequestsState> {
  final UserRequestsRepository _repository;
  Timer? _debounceTimer;

  UserRequestsCubit(this._repository) : super(UserRequestsInitial());

  // Helper to get current data or create new one
  UserRequestsData _getCurrentData() {
    if (state is UserRequestsData) {
      return state as UserRequestsData;
    }
    return UserRequestsData();
  }

  // ✅ Fetch received requests
  Future<void> getReceivedRequests({
    int pageSize = 10,
    int pageNumber = 1,
  }) async {
    emit(_getCurrentData().copyWith(isRequestsLoading: true));

    final result = await _repository.getReceivedRequests(
      pageSize: pageSize,
      pageNumber: pageNumber,
    );

    result.fold(
      (failure) {
        emit(
          _getCurrentData().copyWith(
            isRequestsLoading: false,
            error: failure.errorMessage,
          ),
        );
      },
      (requests) {
        emit(
          _getCurrentData().copyWith(
            requests: requests,
            isRequestsLoading: false,
            error: null,
          ),
        );
      },
    );
  }

  // ✅ Accept request
  Future<void> acceptRequest(String requestId) async {
    final result = await _repository.acceptRequest(requestId);
    result.fold(
      (failure) {
        emit(_getCurrentData().copyWith(error: failure.errorMessage));
      },
      (_) {
        // Refresh requests on success
        getReceivedRequests();
      },
    );
  }

  // ✅ Reject request
  Future<void> rejectRequest(String requestId) async {
    final result = await _repository.rejectRequest(requestId);
    result.fold(
      (failure) {
        emit(_getCurrentData().copyWith(error: failure.errorMessage));
      },
      (_) {
        // Refresh requests on success
        getReceivedRequests();
      },
    );
  }

  // ✅ Send request
  Future<void> sendRequest(String trainerId, {String? message}) async {
    final result = await _repository.sendRequest(trainerId, message: message);

    result.fold(
      (failure) {
        emit(_getCurrentData().copyWith(error: failure.errorMessage));
      },
      (_) {
        // Refresh trainers to update hasRequestPending status
        getAllTrainers();
      },
    );
  }

  // ✅ Get all trainers with search (debounced)
  void searchTrainers(
    String searchTerm, {
    int pageSize = 20,
    int pageNumber = 1,
  }) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _fetchTrainers(
        searchTerm: searchTerm,
        pageSize: pageSize,
        pageNumber: pageNumber,
      );
    });
  }

  // ✅ Fetch trainers (called after debounce)
  Future<void> _fetchTrainers({
    String searchTerm = '',
    int pageSize = 20,
    int pageNumber = 1,
  }) async {
    emit(_getCurrentData().copyWith(isTrainersLoading: true));

    final result = await _repository.getAllTrainers(
      searchTerm: searchTerm,
      pageSize: pageSize,
      pageNumber: pageNumber,
    );

    result.fold(
      (failure) {
        emit(
          _getCurrentData().copyWith(
            isTrainersLoading: false,
            error: failure.errorMessage,
          ),
        );
      },
      (trainers) {
        emit(
          _getCurrentData().copyWith(
            trainers: trainers,
            isTrainersLoading: false,
            error: null,
          ),
        );
      },
    );
  }

  // ✅ Get trainers without debounce (initial load)
  Future<void> getAllTrainers({int pageSize = 20, int pageNumber = 1}) async {
    await _fetchTrainers(
      searchTerm: '',
      pageSize: pageSize,
      pageNumber: pageNumber,
    );
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
