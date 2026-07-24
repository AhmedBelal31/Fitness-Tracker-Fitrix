import 'package:equatable/equatable.dart';

import '../../data/workout_session_model.dart';
//
// abstract class WorkoutsState extends Equatable {
//   const WorkoutsState();
//
//   @override
//   List<Object?> get props => [];
// }
//
// class WorkoutsInitial extends WorkoutsState {}
//
// class WorkoutsLoading extends WorkoutsState {}
//
// class WorkoutSessionCreated extends WorkoutsState {
//   final WorkoutSessionModel session;
//
//   const WorkoutSessionCreated(this.session);
//
//   @override
//   List<Object?> get props => [session];
// }
//
// class WorkoutHistoryLoaded extends WorkoutsState {
//   final List<WorkoutSessionModel> sessions;
//
//   const WorkoutHistoryLoaded(this.sessions);
//
//   @override
//   List<Object?> get props => [sessions];
// }
//
// class WorkoutSessionLoaded extends WorkoutsState {
//   final WorkoutSessionModel session;
//
//   const WorkoutSessionLoaded(this.session);
//
//   @override
//   List<Object?> get props => [session];
// }
//
// class ExerciseAddedToWorkout extends WorkoutsState {
//   final WorkoutExerciseModel workoutExercise;
//
//   const ExerciseAddedToWorkout(this.workoutExercise);
//
//   @override
//   List<Object?> get props => [workoutExercise];
// }
//
// class WorkoutSessionStarted extends WorkoutsState {}
//
// class WorkoutSessionCompleted extends WorkoutsState {}
//
// class SetAddedToExercise extends WorkoutsState {
//   final ExerciseSetModel exerciseSet;
//
//   const SetAddedToExercise(this.exerciseSet);
//
//   @override
//   List<Object?> get props => [exerciseSet];
// }
//
// class SetUpdated extends WorkoutsState {}
//
// class WorkoutsError extends WorkoutsState {
//   final String message;
//
//   const WorkoutsError(this.message);
//
//   @override
//   List<Object?> get props => [message];
// }

abstract class WorkoutsState {}

class WorkoutsInitial extends WorkoutsState {}

class WorkoutsLoading extends WorkoutsState {}

class WorkoutsUpdating extends WorkoutsState {
  final WorkoutSessionModel currentSession;

  WorkoutsUpdating(this.currentSession);
}

class WorkoutHistoryLoaded extends WorkoutsState {
  final List<WorkoutSessionModel> sessions;

  WorkoutHistoryLoaded(this.sessions);
}

class WorkoutSessionLoaded extends WorkoutsState {
  final WorkoutSessionModel session;

  WorkoutSessionLoaded(this.session);
}

class ExerciseAddedToWorkout extends WorkoutsState {
  final WorkoutExerciseModel workoutExercise;

  ExerciseAddedToWorkout(this.workoutExercise);
}

// ✅ NEW: Session action states that preserve data
class WorkoutSessionStarted extends WorkoutsState {
  final WorkoutSessionModel session;

  WorkoutSessionStarted(this.session);
}

class WorkoutSessionCompleted extends WorkoutsState {}

class SetAddedToExercise extends WorkoutsState {
  final ExerciseSetModel exerciseSet;

  SetAddedToExercise(this.exerciseSet);
}

class SetUpdated extends WorkoutsState {}

class WorkoutsError extends WorkoutsState {
  final String message;

  WorkoutsError(this.message);
}
