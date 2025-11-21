// lib/features/trainer/presentation/cubits/trainee_details_state.dart
part of 'trainee_details_cubit.dart';

abstract class TraineeDetailsState {
  const TraineeDetailsState();
}

class TraineeDetailsInitial extends TraineeDetailsState {}

class TraineeDetailsLoading extends TraineeDetailsState {}

class TraineeDetailsLoaded extends TraineeDetailsState {
  final TraineeData trainee;

  const TraineeDetailsLoaded(this.trainee);
}

class TraineeDetailsError extends TraineeDetailsState {
  final String message;

  const TraineeDetailsError(this.message);
}
