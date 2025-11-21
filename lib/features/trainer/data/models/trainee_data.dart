import 'profile_response.dart';

// lib/features/trainer/domain/models/trainee_data.dart

class TraineeData {
  final String id;
  final String firstName;
  final String lastName;
  final String? fullName;
  final String email;
  final String? image; // ADD THIS
  final int? gender;
  final int? age;
  final double? heightCm;
  final double? currentWeight;
  final int? activeWorkouts;
  final int? completedWorkouts;
  final int? totalWorkouts;
  final DateTime? lastWorkoutDate;
  final DateTime? assignedDate;
  final int? personalRecords;
  final ProfileResponse? profile;

  TraineeData({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.fullName,
    required this.email,
    this.image, // ADD THIS
    this.gender,
    this.age,
    this.heightCm,
    this.currentWeight,
    this.activeWorkouts,
    this.completedWorkouts,
    this.totalWorkouts,
    this.lastWorkoutDate,
    this.assignedDate,
    this.personalRecords,
    this.profile,
  });

  factory TraineeData.fromJson(Map<String, dynamic> json) => TraineeData(
    id: json['traineeId'] ?? json['id'] ?? '',
    firstName: json['firstName'] ?? '',
    lastName: json['lastName'] ?? '',
    fullName: json['fullName'],
    email: json['email'] ?? '',
    image: json['image'], // ADD THIS
    gender: json['gender'],
    age: json['age'],
    heightCm: json['heightCm']?.toDouble(),
    currentWeight: json['currentWeight']?.toDouble(),
    activeWorkouts: json['activeWorkouts'],
    completedWorkouts: json['completedWorkouts'] ?? json['totalWorkouts'],
    totalWorkouts: json['totalWorkouts'],
    lastWorkoutDate: json['lastWorkout'] != null
        ? DateTime.parse(json['lastWorkout'])
        : json['lastWorkoutDate'] != null
        ? DateTime.parse(json['lastWorkoutDate'])
        : null,
    assignedDate: json['assignedDate'] != null
        ? DateTime.parse(json['assignedDate'])
        : null,
    personalRecords: json['personalRecords'],
    profile: json['profile'] != null
        ? ProfileResponse.fromJson(json['profile'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'traineeId': id,
    'firstName': firstName,
    'lastName': lastName,
    'fullName': fullName,
    'email': email,
    'image': image, // ADD THIS
    'gender': gender,
    'age': age,
    'heightCm': heightCm,
    'currentWeight': currentWeight,
    'activeWorkouts': activeWorkouts,
    'completedWorkouts': completedWorkouts,
    'totalWorkouts': totalWorkouts,
    'lastWorkout': lastWorkoutDate?.toIso8601String(),
    'assignedDate': assignedDate?.toIso8601String(),
    'personalRecords': personalRecords,
    'profile': profile?.toJson(),
  };
}

enum RequestStatus { pending, accepted, rejected, cancelled }
