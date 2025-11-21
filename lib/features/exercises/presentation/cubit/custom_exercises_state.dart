// import 'package:equatable/equatable.dart';
// import '../../data/models/exercise_model.dart';
//
// abstract class CustomExercisesState extends Equatable {
//   const CustomExercisesState();
//
//   @override
//   List<Object?> get props => [];
// }
//
// class CustomExercisesInitial extends CustomExercisesState {}
//
// class CustomExercisesLoading extends CustomExercisesState {}
//
// class CustomExercisesLoaded extends CustomExercisesState {
//   final List<ExerciseModel> exercises;
//
//   const CustomExercisesLoaded(this.exercises);
//
//   @override
//   List<Object?> get props => [exercises];
// }
//
// class CustomExercisesCreating extends CustomExercisesState {}
//
// class CustomExerciseCreated extends CustomExercisesState {
//   final ExerciseModel exercise;
//
//   const CustomExerciseCreated(this.exercise);
//
//   @override
//   List<Object?> get props => [exercise];
// }
//
// class CustomExercisesError extends CustomExercisesState {
//   final String message;
//   final List<ExerciseModel>? exercises;
//
//   const CustomExercisesError(this.message, {this.exercises});
// }
//
// class CustomExercisesDeleting extends CustomExercisesState {
//   final List<ExerciseModel> exercises;
//
//   const CustomExercisesDeleting(this.exercises);
// }
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
  final List<ExerciseModel>? exercises;

  const CustomExercisesError(this.message, {this.exercises});

  @override
  List<Object?> get props => [message, exercises];
}

class CustomExercisesDeleting extends CustomExercisesState {
  final List<ExerciseModel> exercises;

  const CustomExercisesDeleting(this.exercises);

  @override
  List<Object?> get props => [exercises];
}
