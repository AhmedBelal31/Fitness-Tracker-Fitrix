part of 'trainee_progress_cubit.dart';

abstract class TraineeProgressState {
  const TraineeProgressState();
}

class TraineeProgressInitial extends TraineeProgressState {}

class TraineeProgressLoading extends TraineeProgressState {}

class TraineeProgressLoaded extends TraineeProgressState {
  final TraineeProgressData progress;

  const TraineeProgressLoaded(this.progress);
}

class TraineeProgressError extends TraineeProgressState {
  final String message;

  const TraineeProgressError(this.message);
}
