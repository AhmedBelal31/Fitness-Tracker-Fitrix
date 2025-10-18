import 'package:equatable/equatable.dart';

class AchievementsResponse extends Equatable {
  final int totalRecords;
  final int weightRecords;
  final int repsRecords;
  final int volumeRecords;
  final List<RecordModel> recentRecords;
  final List<RecordBySection> recordsBySection;
  final List<MilestoneModel> milestones;

  const AchievementsResponse({
    required this.totalRecords,
    required this.weightRecords,
    required this.repsRecords,
    required this.volumeRecords,
    required this.recentRecords,
    required this.recordsBySection,
    required this.milestones,
  });

  factory AchievementsResponse.fromJson(Map<String, dynamic> json) {
    return AchievementsResponse(
      totalRecords: json['totalRecords'] ?? 0,
      weightRecords: json['weightRecords'] ?? 0,
      repsRecords: json['repsRecords'] ?? 0,
      volumeRecords: json['volumeRecords'] ?? 0,
      recentRecords:
          (json['recentRecords'] as List?)
              ?.map((e) => RecordModel.fromJson(e))
              .toList() ??
          [],
      recordsBySection:
          (json['recordsBySection'] as List?)
              ?.map((e) => RecordBySection.fromJson(e))
              .toList() ??
          [],
      milestones:
          (json['milestones'] as List?)
              ?.map((e) => MilestoneModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  @override
  List<Object?> get props => [
    totalRecords,
    weightRecords,
    repsRecords,
    volumeRecords,
    recentRecords,
    recordsBySection,
    milestones,
  ];
}

class MilestoneModel extends Equatable {
  final String title;
  final String description;
  final String icon;
  final RecordModel record;
  final DateTime date;

  const MilestoneModel({
    required this.title,
    required this.description,
    required this.icon,
    required this.record,
    required this.date,
  });

  factory MilestoneModel.fromJson(Map<String, dynamic> json) {
    return MilestoneModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      icon: json['icon'] ?? '🏆',
      record: RecordModel.fromJson(json['record']),
      date: DateTime.parse(json['date']),
    );
  }

  @override
  List<Object?> get props => [title, description, icon, record, date];
}

class RecordModel extends Equatable {
  final String id;
  final int recordType; // 1=Weight, 2=Reps, 3=Volume
  final double value;
  final DateTime createdAtUtc;
  final UserExerciseModel? userExercise;
  final WorkoutSessionModel? workoutSession;

  const RecordModel({
    required this.id,
    required this.recordType,
    required this.value,
    required this.createdAtUtc,
    this.userExercise,
    this.workoutSession,
  });

  factory RecordModel.fromJson(Map<String, dynamic> json) {
    return RecordModel(
      id: json['id'] ?? '',
      recordType: json['recordType'] ?? 1,
      value: (json['value'] ?? 0).toDouble(),
      createdAtUtc: DateTime.parse(json['createdAtUtc']),
      userExercise: json['userExercise'] != null
          ? UserExerciseModel.fromJson(json['userExercise'])
          : null,
      workoutSession: json['workoutSession'] != null
          ? WorkoutSessionModel.fromJson(json['workoutSession'])
          : null,
    );
  }

  String get recordTypeString {
    switch (recordType) {
      case 1:
        return 'Weight';
      case 2:
        return 'Reps';
      case 3:
        return 'Volume';
      default:
        return 'Unknown';
    }
  }

  @override
  List<Object?> get props => [
    id,
    recordType,
    value,
    createdAtUtc,
    userExercise,
    workoutSession,
  ];
}

class UserExerciseModel extends Equatable {
  final String id;
  final String name;
  final String? description;

  const UserExerciseModel({
    required this.id,
    required this.name,
    this.description,
  });

  factory UserExerciseModel.fromJson(Map<String, dynamic> json) {
    return UserExerciseModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
    );
  }

  @override
  List<Object?> get props => [id, name, description];
}

class WorkoutSessionModel extends Equatable {
  final String id;
  final DateTime date;
  final DateTime? startTime;
  final DateTime? endTime;
  final bool isCompleted;
  final int? durationMinutes;
  final String? notes;

  const WorkoutSessionModel({
    required this.id,
    required this.date,
    this.startTime,
    this.endTime,
    required this.isCompleted,
    this.durationMinutes,
    this.notes,
  });

  factory WorkoutSessionModel.fromJson(Map<String, dynamic> json) {
    return WorkoutSessionModel(
      id: json['id'] ?? '',
      date: DateTime.parse(json['date']),
      startTime: json['startTime'] != null
          ? DateTime.parse(json['startTime'])
          : null,
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
      isCompleted: json['isCompleted'] ?? false,
      durationMinutes: json['durationMinutes'],
      notes: json['notes'],
    );
  }

  @override
  List<Object?> get props => [
    id,
    date,
    startTime,
    endTime,
    isCompleted,
    durationMinutes,
    notes,
  ];
}

class RecordBySection extends Equatable {
  final String sectionName;
  final int recordCount;
  final DateTime latestRecord;

  const RecordBySection({
    required this.sectionName,
    required this.recordCount,
    required this.latestRecord,
  });

  factory RecordBySection.fromJson(Map<String, dynamic> json) {
    return RecordBySection(
      sectionName: json['sectionName'] ?? '',
      recordCount: json['recordCount'] ?? 0,
      latestRecord: DateTime.parse(json['latestRecord']),
    );
  }

  @override
  List<Object?> get props => [sectionName, recordCount, latestRecord];
}
