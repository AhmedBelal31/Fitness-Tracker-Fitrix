// lib/features/workouts/data/models/workout_session_res.dart
class WorkoutSessionRes {
  final String id;
  final String userId;
  final DateTime date;
  final String? notes;
  final DateTime createdAt;
  final DateTime? updatedAt;

  WorkoutSessionRes({
    required this.id,
    required this.userId,
    required this.date,
    this.notes,
    required this.createdAt,
    this.updatedAt,
  });

  factory WorkoutSessionRes.fromJson(Map<String, dynamic> json) =>
      WorkoutSessionRes(
        id: json['id'] ?? '',
        userId: json['userId'] ?? '',
        date: DateTime.parse(json['date']),
        notes: json['notes'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : null,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'date': date.toIso8601String(),
    'notes': notes,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };
}
