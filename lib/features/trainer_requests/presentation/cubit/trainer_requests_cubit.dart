import 'package:flutter_bloc/flutter_bloc.dart';
import 'trainer_requests_state.dart';
import '../../domain/repository/trainer_requests_repository.dart';

// class TrainerRequestsCubit extends Cubit<TrainerRequestsState> {
//   final TrainerRequestsRepository _repository;
//
//   TrainerRequestsCubit(this._repository) : super(TrainerRequestsInitial());
//
//   Future<void> getSentRequests({int pageSize = 10, int pageNumber = 1}) async {
//     if (state is TrainerRequestsData) {
//       emit((state as TrainerRequestsData).copyWith(isLoading: true));
//     } else {
//       emit(TrainerRequestsData(isLoading: true));
//     }
//
//     final result = await _repository.getSentRequests(
//       pageSize: pageSize,
//       pageNumber: pageNumber,
//     );
//
//     result.fold(
//       (failure) {
//         if (state is TrainerRequestsData) {
//           emit(
//             (state as TrainerRequestsData).copyWith(
//               isLoading: false,
//               error: failure.errorMessage,
//             ),
//           );
//         } else {
//           emit(
//             TrainerRequestsData(isLoading: false, error: failure.errorMessage),
//           );
//         }
//       },
//       (requests) {
//         if (state is TrainerRequestsData) {
//           emit(
//             (state as TrainerRequestsData).copyWith(
//               requests: requests,
//               isLoading: false,
//               error: null,
//             ),
//           );
//         } else {
//           emit(TrainerRequestsData(requests: requests, isLoading: false));
//         }
//       },
//     );
//   }
//
//   Future<void> acceptRequest(String requestId) async {
//     final result = await _repository.acceptRequest(requestId);
//     result.fold((failure) {
//       if (state is TrainerRequestsData) {
//         emit(
//           (state as TrainerRequestsData).copyWith(error: failure.errorMessage),
//         );
//       }
//     }, (_) => getSentRequests());
//   }
//
//   Future<void> rejectRequest(String requestId) async {
//     final result = await _repository.rejectRequest(requestId);
//     result.fold((failure) {
//       if (state is TrainerRequestsData) {
//         emit(
//           (state as TrainerRequestsData).copyWith(error: failure.errorMessage),
//         );
//       }
//     }, (_) => getSentRequests());
//   }
// }
import 'dart:async';

import 'trainer_requests_state.dart';

class TrainerRequestsCubit extends Cubit<TrainerRequestsState> {
  final TrainerRequestsRepository _repository;
  Timer? _debounceTimer;

  TrainerRequestsCubit(this._repository) : super(TrainerRequestsInitial());

  TrainerRequestsData _getCurrentData() {
    if (state is TrainerRequestsData) {
      return state as TrainerRequestsData;
    }
    return TrainerRequestsData();
  }

  // ✅ Fetch received requests (pending trainees wanting to join)
  Future<void> getSentRequests({int pageSize = 10, int pageNumber = 1}) async {
    emit(_getCurrentData().copyWith(isRequestsLoading: true));

    final result = await _repository.getSentRequests(
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

  // ✅ Accept trainee request
  Future<void> acceptRequest(String requestId) async {
    final result = await _repository.acceptRequest(requestId);
    result.fold(
      (failure) {
        emit(_getCurrentData().copyWith(error: failure.errorMessage));
      },
      (_) {
        getSentRequests();
        getAllTrainees(); // Refresh trainees list
      },
    );
  }

  // ✅ Reject trainee request
  Future<void> rejectRequest(String requestId) async {
    final result = await _repository.rejectRequest(requestId);
    result.fold(
      (failure) {
        emit(_getCurrentData().copyWith(error: failure.errorMessage));
      },
      (_) {
        getSentRequests();
      },
    );
  }

  // ✅ Get all trainees with search (debounced)
  void searchTrainees(
    String searchTerm, {
    int pageSize = 20,
    int pageNumber = 1,
  }) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _fetchTrainees(
        searchTerm: searchTerm,
        pageSize: pageSize,
        pageNumber: pageNumber,
      );
    });
  }

  // ✅ Fetch trainees
  Future<void> _fetchTrainees({
    String searchTerm = '',
    int pageSize = 20,
    int pageNumber = 1,
  }) async {
    emit(_getCurrentData().copyWith(isTraineesLoading: true));

    final result = await _repository.getAllTrainees(
      searchTerm: searchTerm,
      pageSize: pageSize,
      pageNumber: pageNumber,
    );

    result.fold(
      (failure) {
        emit(
          _getCurrentData().copyWith(
            isTraineesLoading: false,
            error: failure.errorMessage,
          ),
        );
      },
      (trainees) {
        emit(
          _getCurrentData().copyWith(
            trainees: trainees,
            isTraineesLoading: false,
            error: null,
          ),
        );
      },
    );
  }

  // ✅ Get trainees without debounce (initial load)
  Future<void> getAllTrainees({int pageSize = 20, int pageNumber = 1}) async {
    await _fetchTrainees(
      searchTerm: '',
      pageSize: pageSize,
      pageNumber: pageNumber,
    );
  }

  // Add to TrainerRequestsCubit

  // ✅ Send invitation request to trainee
  Future<void> sendRequest(String traineeId, {String? message}) async {
    final result = await _repository.sendRequest(traineeId, message: message);

    result.fold(
      (failure) {
        emit(_getCurrentData().copyWith(error: failure.errorMessage));
      },
      (_) {
        // Refresh trainees to update hasRequestPending status
        getAllTrainees();
      },
    );
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
