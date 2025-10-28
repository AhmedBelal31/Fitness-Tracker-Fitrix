import 'package:equatable/equatable.dart';
import '../../data/models/trainee_request_model.dart';

// abstract class TrainerRequestsState extends Equatable {
//   @override
//   List<Object?> get props => [];
// }
//
// class TrainerRequestsInitial extends TrainerRequestsState {}
//
// class TrainerRequestsData extends TrainerRequestsState {
//   final List<TraineeRequest>? requests;
//   final bool isLoading;
//   final String? error;
//
//   TrainerRequestsData({this.requests, this.isLoading = false, this.error});
//
//   TrainerRequestsData copyWith({
//     List<TraineeRequest>? requests,
//     bool? isLoading,
//     String? error,
//   }) {
//     return TrainerRequestsData(
//       requests: requests ?? this.requests,
//       isLoading: isLoading ?? this.isLoading,
//       error: error,
//     );
//   }
//
//   @override
//   List<Object?> get props => [requests, isLoading, error];
// }
abstract class TrainerRequestsState {}

class TrainerRequestsInitial extends TrainerRequestsState {}

class TrainerRequestsData extends TrainerRequestsState {
  final List<TraineeRequest>? requests;
  final List<Trainee>? trainees;
  final bool isRequestsLoading;
  final bool isTraineesLoading;
  final String? error;

  TrainerRequestsData({
    this.requests,
    this.trainees,
    this.isRequestsLoading = false,
    this.isTraineesLoading = false,
    this.error,
  });

  TrainerRequestsData copyWith({
    List<TraineeRequest>? requests,
    List<Trainee>? trainees,
    bool? isRequestsLoading,
    bool? isTraineesLoading,
    String? error,
  }) {
    return TrainerRequestsData(
      requests: requests ?? this.requests,
      trainees: trainees ?? this.trainees,
      isRequestsLoading: isRequestsLoading ?? this.isRequestsLoading,
      isTraineesLoading: isTraineesLoading ?? this.isTraineesLoading,
      error: error,
    );
  }
}
