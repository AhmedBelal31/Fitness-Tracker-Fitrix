// lib/features/trainer/presentation/cubits/trainer_requests_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/trainer_request.dart';
import '../../data/models/user_dto.dart';
import '../../domain/repositories/trainer_repository.dart';
part 'trainer_requests_state.dart';

class TrainerRequestsCubit extends Cubit<TrainerRequestsState> {
  final TrainerRepository _repository;

  TrainerRequestsCubit(this._repository) : super(TrainerRequestsInitial());

  /// Load received trainer requests
  Future<void> loadReceivedRequests({
    int pageSize = 20,
    int pageNumber = 1,
  }) async {
    emit(TrainerRequestsLoading());
    final result = await _repository.getReceivedRequests(
      pageSize: pageSize,
      pageNumber: pageNumber,
    );
    result.fold(
      (failure) => emit(TrainerRequestsError(failure.errorMessage)),
      (requests) => emit(ReceivedRequestsLoaded(requests)),
    );
  }

  /// Accept a trainer request
  Future<void> acceptRequest(String requestId) async {
    final result = await _repository.acceptRequest(requestId);
    result.fold(
      (failure) => emit(TrainerRequestsError(failure.errorMessage)),
      (_) => emit(RequestActionSuccess('Request accepted successfully')),
    );
  }

  /// Reject a trainer request
  Future<void> rejectRequest(String requestId) async {
    final result = await _repository.rejectRequest(requestId);
    result.fold(
      (failure) => emit(TrainerRequestsError(failure.errorMessage)),
      (_) => emit(RequestActionSuccess('Request rejected')),
    );
  }

  /// Send a request to a user
  Future<void> sendRequest({required String userId, String? message}) async {
    final result = await _repository.sendRequest(
      userId: userId,
      message: message,
    );
    result.fold(
      (failure) => emit(TrainerRequestsError(failure.errorMessage)),
      (_) => emit(RequestActionSuccess('Request sent successfully')),
    );
  }

  /// Get all users (for searching potential clients)
  Future<void> getAllUsers({
    String? searchTerm,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    emit(TrainerRequestsLoading());
    final result = await _repository.getAllUsers(
      searchTerm: searchTerm,
      pageNumber: pageNumber,
      pageSize: pageSize,
    );
    result.fold(
      (failure) => emit(TrainerRequestsError(failure.errorMessage)),
      (users) => emit(AllUsersLoaded(users)),
    );
  }

  /// Cancel a sent request
  Future<void> cancelRequest(String requestId) async {
    final result = await _repository.cancelRequest(requestId);
    result.fold(
      (failure) => emit(TrainerRequestsError(failure.errorMessage)),
      (_) => emit(RequestActionSuccess('Request cancelled')),
    );
  }

  /// Reset state to initial
  void resetState() {
    emit(TrainerRequestsInitial());
  }
}
