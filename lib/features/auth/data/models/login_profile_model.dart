import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/helpers/constants.dart';
part 'login_profile_model.g.dart';

@HiveType(typeId: 1)
class LoginProfileModel extends Equatable {
  @HiveField(0)
  final String? firstName;

  @HiveField(1)
  final String? lastName;

  @HiveField(2)
  final int? gender;

  @HiveField(3)
  final int? role;

  @HiveField(4)
  final DateTime? dateOfBirth;

  @HiveField(5)
  final double? heightCm;

  @HiveField(6)
  final double? lastWeightKg;

  @HiveField(7)
  final double? lastMuscleMassKg;

  @HiveField(8)
  final double? lastBodyFatPercent;

  const LoginProfileModel({
    this.firstName,
    this.lastName,
    this.gender,
    this.role,
    this.dateOfBirth,
    this.heightCm,
    this.lastWeightKg,
    this.lastMuscleMassKg,
    this.lastBodyFatPercent,
  });

  factory LoginProfileModel.fromJson(Map<String, dynamic> json) {
    return LoginProfileModel(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      gender: json['gender'] as int?,
      role: json['role'] as int?,
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.tryParse(json['dateOfBirth'] as String)
          : null,
      heightCm: json['heightCm'] != null
          ? (json['heightCm'] as num).toDouble()
          : null,
      lastWeightKg: json['lastWeightKg'] != null
          ? (json['lastWeightKg'] as num).toDouble()
          : null,
      lastMuscleMassKg: json['lastMuscleMassKgdecimal'] != null
          ? (json['lastMuscleMassKgdecimal'] as num).toDouble()
          : null,
      lastBodyFatPercent: json['lastBodyFatPercent'] != null
          ? (json['lastBodyFatPercent'] as num).toDouble()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'gender': gender,
    'role': role,
    'dateOfBirth': dateOfBirth?.toIso8601String(),
    'heightCm': heightCm,
    'lastWeightKg': lastWeightKg,
    'lastMuscleMassKgdecimal': lastMuscleMassKg, // Keep API typo in output
    'lastBodyFatPercent': lastBodyFatPercent,
  };

  // 👇 Helper getters for role checking
  bool get isUser => role == Constants.userRole; // role == 1
  bool get isTrainer => role == Constants.trainerRole; // role == 2

  // 👇 Get role as string for logging/display
  String get roleString {
    switch (role) {
      case Constants.userRole: // 1
        return 'User';
      case Constants.trainerRole: // 2
        return 'Trainer';
      default:
        return 'Unknown';
    }
  }

  String get genderString {
    switch (gender) {
      case 1:
        return 'Male';
      case 2:
        return 'Female';
      default:
        return 'Male';
    }
  }

  bool get isProfileComplete {
    return firstName != null &&
        firstName!.isNotEmpty &&
        lastName != null &&
        lastName!.isNotEmpty &&
        gender != null;
  }

  bool get hasBodyMetrics {
    return lastWeightKg != null ||
        lastMuscleMassKg != null ||
        lastBodyFatPercent != null;
  }

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    gender,
    role,
    dateOfBirth,
    heightCm,
    lastWeightKg,
    lastMuscleMassKg,
    lastBodyFatPercent,
  ];

  @override
  String toString() {
    return 'LoginProfileModel(firstName: $firstName, lastName: $lastName, '
        'gender: $genderString, role: $roleString, '
        'weight: $lastWeightKg kg, muscleMass: $lastMuscleMassKg kg, '
        'bodyFat: $lastBodyFatPercent%)';
  }
}
