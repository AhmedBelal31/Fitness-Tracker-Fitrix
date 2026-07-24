import 'package:equatable/equatable.dart';

import '../../data/models/trainee_data.dart';

abstract class TraineesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TraineesInitial extends TraineesState {}

class TraineesLoading extends TraineesState {}

class TraineesLoaded extends TraineesState {
  final List<TraineeData> trainees;

  TraineesLoaded(this.trainees);

  @override
  List<Object?> get props => [trainees];
}

class TraineesError extends TraineesState {
  final String message;

  TraineesError(this.message);

  @override
  List<Object?> get props => [message];
}
