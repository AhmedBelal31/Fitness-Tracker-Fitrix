import 'workout_stats_model.dart';
import 'body_progress_model.dart';

class DashboardModel {
  final String userId;
  final String fullName;
  final String role;
  final BodyProgressModel? bodyProgress;
  final WorkoutStatsModel? workoutStats;
  final List<PersonalRecordModel>? personalRecords;
  final List<RecentWorkoutModel>? recentWorkouts;

  DashboardModel({
    required this.userId,
    required this.fullName,
    required this.role,
    this.bodyProgress,
    this.workoutStats,
    this.personalRecords,
    this.recentWorkouts,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      userId: json['userId'] ?? '',
      fullName: json['fullName'] ?? '',
      role: json['role'] ?? 'User',
      bodyProgress: json['bodyProgress'] != null
          ? BodyProgressModel.fromJson(json['bodyProgress'])
          : null,
      workoutStats: json['workoutStats'] != null
          ? WorkoutStatsModel.fromJson(json['workoutStats'])
          : null,
      personalRecords: json['personalRecords'] != null
          ? (json['personalRecords'] as List)
                .map((e) => PersonalRecordModel.fromJson(e))
                .toList()
          : null,
      recentWorkouts: json['recentWorkouts'] != null
          ? (json['recentWorkouts'] as List)
                .map((e) => RecentWorkoutModel.fromJson(e))
                .toList()
          : null,
    );
  }
}

class PersonalRecordModel {
  final String id;
  final String exerciseName;
  final String recordType;
  final double value;
  final String achievedDate;

  PersonalRecordModel({
    required this.id,
    required this.exerciseName,
    required this.recordType,
    required this.value,
    required this.achievedDate,
  });

  factory PersonalRecordModel.fromJson(Map<String, dynamic> json) {
    return PersonalRecordModel(
      id: json['id'] ?? '',
      exerciseName: json['exerciseName'] ?? '',
      recordType: json['recordType'] ?? '',
      value: (json['value'] ?? 0).toDouble(),
      achievedDate: json['achievedDate'] ?? '',
    );
  }
}

class RecentWorkoutModel {
  final String id;
  final String date;
  final int duration;
  final List<String> exercises;
  final int totalSets;
  final bool isCompleted;

  RecentWorkoutModel({
    required this.id,
    required this.date,
    required this.duration,
    required this.exercises,
    required this.totalSets,
    required this.isCompleted,
  });

  factory RecentWorkoutModel.fromJson(Map<String, dynamic> json) {
    return RecentWorkoutModel(
      id: json['id'] ?? '',
      date: json['date'] ?? '',
      duration: json['duration'] ?? 0,
      exercises: (json['exercises'] as List?)?.cast<String>() ?? [],
      totalSets: json['totalSets'] ?? 0,
      isCompleted: json['isCompleted'] ?? false,
    );
  }
}
