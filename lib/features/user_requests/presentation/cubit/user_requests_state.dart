import 'package:equatable/equatable.dart';
import '../../data/trainer.dart';
import '../../data/user_request.dart';

// abstract class UserRequestsState extends Equatable {
//   @override
//   List<Object?> get props => [];
// }
//
// class UserRequestsInitial extends UserRequestsState {}
//
// class UserRequestsData extends UserRequestsState {
//   final List<UserRequest>? requests;
//   final List<Trainer>? trainers;
//   final bool isRequestsLoading;
//   final bool isTrainersLoading;
//   final String? error;
//
//   UserRequestsData({
//     this.requests,
//     this.trainers,
//     this.isRequestsLoading = false,
//     this.isTrainersLoading = false,
//     this.error,
//   });
//
//   UserRequestsData copyWith({
//     List<UserRequest>? requests,
//     List<Trainer>? trainers,
//     bool? isRequestsLoading,
//     bool? isTrainersLoading,
//     String? error,
//   }) {
//     return UserRequestsData(
//       requests: requests ?? this.requests,
//       trainers: trainers ?? this.trainers,
//       isRequestsLoading: isRequestsLoading ?? this.isRequestsLoading,
//       isTrainersLoading: isTrainersLoading ?? this.isTrainersLoading,
//       error: error,
//     );
//   }
// }
// user_requests_state.dart

abstract class UserRequestsState {}

class UserRequestsInitial extends UserRequestsState {}

class UserRequestsData extends UserRequestsState {
  final List<UserRequest>? requests;
  final List<Trainer>? trainers;
  final bool isRequestsLoading;
  final bool isTrainersLoading;
  final String? error;

  UserRequestsData({
    this.requests,
    this.trainers,
    this.isRequestsLoading = false,
    this.isTrainersLoading = false,
    this.error,
  });

  UserRequestsData copyWith({
    List<UserRequest>? requests,
    List<Trainer>? trainers,
    bool? isRequestsLoading,
    bool? isTrainersLoading,
    String? error,
  }) {
    return UserRequestsData(
      requests: requests ?? this.requests,
      trainers: trainers ?? this.trainers,
      isRequestsLoading: isRequestsLoading ?? this.isRequestsLoading,
      isTrainersLoading: isTrainersLoading ?? this.isTrainersLoading,
      error: error,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserRequestsData &&
        other.requests == requests &&
        other.trainers == trainers &&
        other.isRequestsLoading == isRequestsLoading &&
        other.isTrainersLoading == isTrainersLoading &&
        other.error == error;
  }

  @override
  int get hashCode {
    return requests.hashCode ^
        trainers.hashCode ^
        isRequestsLoading.hashCode ^
        isTrainersLoading.hashCode ^
        error.hashCode;
  }
}
