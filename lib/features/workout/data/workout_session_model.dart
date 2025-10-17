// class WorkoutSessionModel {
//   final String id;
//   final String clientProfileId;
//   final String? createdByTrainerId;
//   final DateTime date;
//   final DateTime? startTime;
//   final DateTime? endTime;
//   final bool isCompleted;
//   final int? durationMinutes;
//   final String? notes;
//   final List<WorkoutExerciseModel> workoutExercises;
//
//   WorkoutSessionModel({
//     required this.id,
//     required this.clientProfileId,
//     this.createdByTrainerId,
//     required this.date,
//     this.startTime,
//     this.endTime,
//     required this.isCompleted,
//     this.durationMinutes,
//     this.notes,
//     required this.workoutExercises,
//   });
//
//   factory WorkoutSessionModel.fromJson(Map<String, dynamic> json) {
//     return WorkoutSessionModel(
//       id: json['id'],
//       clientProfileId: json['clientProfileId'],
//       createdByTrainerId: json['createdByTrainerId'],
//       date: DateTime.parse(json['date']),
//       startTime: json['startTime'] != null
//           ? DateTime.parse(json['startTime'])
//           : null,
//       endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
//       isCompleted: json['isCompleted'],
//       durationMinutes: json['durationMinutes'],
//       notes: json['notes'],
//       workoutExercises:
//           (json['workoutExercises'] as List?)
//               ?.map((e) => WorkoutExerciseModel.fromJson(e))
//               .toList() ??
//           [],
//     );
//   }
// }
import '../domain/entities/exercise_set_entity.dart';
import '../domain/entities/workout_exercise_entity.dart';
import '../domain/entities/workout_session_entity.dart';

class WorkoutSessionModel extends WorkoutSessionEntity {
  WorkoutSessionModel({
    required super.id,
    required super.clientProfileId,
    super.createdByTrainerId,
    required super.date,
    super.startTime,
    super.endTime,
    required super.isCompleted,
    super.durationMinutes,
    super.notes,
    required super.workoutExercises,
  });

  factory WorkoutSessionModel.fromJson(Map<String, dynamic> json) {
    return WorkoutSessionModel(
      id: json['id'],
      clientProfileId: json['clientProfileId'],
      createdByTrainerId: json['createdByTrainerId'],
      date: DateTime.parse(json['date']),
      startTime: json['startTime'] != null
          ? DateTime.parse(json['startTime'])
          : null,
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
      isCompleted: json['isCompleted'],
      durationMinutes: json['durationMinutes'],
      notes: json['notes'],
      workoutExercises:
          (json['workoutExercises'] as List?)
              ?.map((e) => WorkoutExerciseModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientProfileId': clientProfileId,
      'createdByTrainerId': createdByTrainerId,
      'date': date.toIso8601String(),
      'startTime': startTime?.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'isCompleted': isCompleted,
      'durationMinutes': durationMinutes,
      'notes': notes,
      'workoutExercises': workoutExercises
          .map((e) => (e as WorkoutExerciseModel).toJson())
          .toList(),
    };
  }
}

class WorkoutExerciseModel extends WorkoutExerciseEntity {
  WorkoutExerciseModel({
    required super.id,
    required super.workoutSessionId,
    super.exerciseId,
    super.exerciseName,
    super.userExerciseId,
    super.userExerciseName,
    required super.clientProfileId,
    required super.sets,
  });

  factory WorkoutExerciseModel.fromJson(Map<String, dynamic> json) {
    return WorkoutExerciseModel(
      id: json['id'],
      workoutSessionId: json['workoutSessionId'],
      exerciseId: json['exerciseId'],
      exerciseName: json['exerciseName'],
      userExerciseId: json['userExerciseId'],
      userExerciseName: json['userExerciseName'],
      clientProfileId: json['clientProfileId'],
      sets:
          (json['sets'] as List?)
              ?.map((e) => ExerciseSetModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'workoutSessionId': workoutSessionId,
      'exerciseId': exerciseId,
      'exerciseName': exerciseName,
      'userExerciseId': userExerciseId,
      'userExerciseName': userExerciseName,
      'clientProfileId': clientProfileId,
      'sets': sets.map((e) => (e as ExerciseSetModel).toJson()).toList(),
    };
  }
}

class ExerciseSetModel extends ExerciseSetEntity {
  ExerciseSetModel({
    required super.id,
    required super.workoutExerciseId,
    required super.setNumber,
    required super.reps,
    required super.weightKg,
    super.restTimeSeconds,
    required super.isCompleted,
    required super.isPersonalRecord,
    super.notes,
    required super.createdAtUtc,
  });

  factory ExerciseSetModel.fromJson(Map<String, dynamic> json) {
    return ExerciseSetModel(
      id: json['id'],
      workoutExerciseId: json['workoutExerciseId'],
      setNumber: json['setNumber'],
      reps: json['reps'],
      weightKg: (json['weightKg'] as num).toDouble(),
      restTimeSeconds: json['restTimeSeconds'],
      isCompleted: json['isCompleted'],
      isPersonalRecord: json['isPersonalRecord'],
      notes: json['notes'],
      createdAtUtc: DateTime.parse(json['createdAtUtc']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'workoutExerciseId': workoutExerciseId,
      'setNumber': setNumber,
      'reps': reps,
      'weightKg': weightKg,
      'restTimeSeconds': restTimeSeconds,
      'isCompleted': isCompleted,
      'isPersonalRecord': isPersonalRecord,
      'notes': notes,
      'createdAtUtc': createdAtUtc.toIso8601String(),
    };
  }
}

// class WorkoutExerciseModel {
//   final String id;
//   final String workoutSessionId;
//   final String? exerciseId;
//   final String? userExerciseId;
//   final String clientProfileId;
//   final List<ExerciseSetModel> sets;
//
//   WorkoutExerciseModel({
//     required this.id,
//     required this.workoutSessionId,
//     this.exerciseId,
//     this.userExerciseId,
//     required this.clientProfileId,
//     required this.sets,
//   });
//
//   factory WorkoutExerciseModel.fromJson(Map<String, dynamic> json) {
//     return WorkoutExerciseModel(
//       id: json['id'],
//       workoutSessionId: json['workoutSessionId'],
//       exerciseId: json['exerciseId'],
//       userExerciseId: json['userExerciseId'],
//       clientProfileId: json['clientProfileId'],
//       sets:
//           (json['sets'] as List?)
//               ?.map((e) => ExerciseSetModel.fromJson(e))
//               .toList() ??
//           [],
//     );
//   }
// }

// class ExerciseSetModel {
//   final String id;
//   final String workoutExerciseId;
//   final String? exerciseName;
//   final String? userExerciseName;
//   final int setNumber;
//   final int reps;
//   final double weightKg;
//   final int? restTimeSeconds;
//   final bool isCompleted;
//   final bool isPersonalRecord;
//   final String? notes;
//   final DateTime createdAtUtc;
//
//   ExerciseSetModel({
//     required this.id,
//     required this.workoutExerciseId,
//     required this.setNumber,
//     required this.reps,
//     required this.weightKg,
//     this.restTimeSeconds,
//     required this.isCompleted,
//     required this.isPersonalRecord,
//     this.notes,
//     this.exerciseName,
//     this.userExerciseName,
//     required this.createdAtUtc,
//   });
//
//   factory ExerciseSetModel.fromJson(Map<String, dynamic> json) {
//     return ExerciseSetModel(
//       id: json['id'],
//       workoutExerciseId: json['workoutExerciseId'],
//       setNumber: json['setNumber'],
//       reps: json['reps'],
//       weightKg: (json['weightKg'] as num).toDouble(),
//       restTimeSeconds: json['restTimeSeconds'],
//       isCompleted: json['isCompleted'],
//       isPersonalRecord: json['isPersonalRecord'],
//       notes: json['notes'],
//       createdAtUtc: DateTime.parse(json['createdAtUtc']),
//       exerciseName: json['exerciseName'],
//       userExerciseName: json['userExerciseName'],
//     );
//   }
// }
