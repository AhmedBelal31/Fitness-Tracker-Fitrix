import 'package:equatable/equatable.dart';
import '../../data/models/exercise_model.dart';

abstract class CustomExercisesState extends Equatable {
  const CustomExercisesState();

  @override
  List<Object?> get props => [];
}

class CustomExercisesInitial extends CustomExercisesState {}

class CustomExercisesLoading extends CustomExercisesState {}

class CustomExercisesLoaded extends CustomExercisesState {
  final List<ExerciseModel> exercises;

  const CustomExercisesLoaded(this.exercises);

  @override
  List<Object?> get props => [exercises];
}

class CustomExercisesCreating extends CustomExercisesState {}

class CustomExerciseCreated extends CustomExercisesState {
  final ExerciseModel exercise;

  const CustomExerciseCreated(this.exercise);

  @override
  List<Object?> get props => [exercise];
}

class CustomExercisesError extends CustomExercisesState {
  final String message;

  const CustomExercisesError(this.message);

  @override
  List<Object?> get props => [message];
}
