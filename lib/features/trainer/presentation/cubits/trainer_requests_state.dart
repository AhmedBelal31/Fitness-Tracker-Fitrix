// States
// lib/features/trainer/presentation/cubits/trainer_requests_state.dart
part of 'trainer_requests_cubit.dart';

abstract class TrainerRequestsState {
  const TrainerRequestsState();
}

class TrainerRequestsInitial extends TrainerRequestsState {}

class TrainerRequestsLoading extends TrainerRequestsState {}

class ReceivedRequestsLoaded extends TrainerRequestsState {
  final List<TrainerRequestResponse> requests;

  const ReceivedRequestsLoaded(this.requests);
}

class AllUsersLoaded extends TrainerRequestsState {
  final List<UserDto> users;

  const AllUsersLoaded(this.users);
}

class TrainerRequestsError extends TrainerRequestsState {
  final String message;

  const TrainerRequestsError(this.message);
}

class RequestActionSuccess extends TrainerRequestsState {
  final String message;

  const RequestActionSuccess(this.message);
}
