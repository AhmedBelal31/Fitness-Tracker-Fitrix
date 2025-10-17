// import 'package:hive/hive.dart';
// import 'package:equatable/equatable.dart';
// import '../../../../core/helpers/constants.dart';
// part 'login_profile_model.g.dart';
//
// @HiveType(typeId: 1)
// class LoginProfileModel extends Equatable {
//   @HiveField(0)
//   final String? firstName;
//
//   @HiveField(1)
//   final String? lastName;
//
//   @HiveField(2)
//   final int? gender;
//
//   @HiveField(3)
//   final int? role;
//
//   @HiveField(4)
//   final DateTime? dateOfBirth;
//
//   @HiveField(5)
//   final double? heightCm;
//
//   @HiveField(6)
//   final double? lastWeightKg;
//
//   @HiveField(7)
//   final double? lastMuscleMassKg;
//
//   @HiveField(8)
//   final double? lastBodyFatPercent;
//
//   @HiveField(9)
//   final String? phoneNumber;
//
//   const LoginProfileModel({
//     this.firstName,
//     this.lastName,
//     this.gender,
//     this.role,
//     this.dateOfBirth,
//     this.heightCm,
//     this.lastWeightKg,
//     this.lastMuscleMassKg,
//     this.lastBodyFatPercent,
//     this.phoneNumber,
//   });
//
//   factory LoginProfileModel.fromJson(Map<String, dynamic> json) {
//     return LoginProfileModel(
//       firstName: json['firstName'] as String?,
//       lastName: json['lastName'] as String?,
//       gender: json['gender'] as int?,
//       role: json['role'] as int?,
//       dateOfBirth: json['dateOfBirth'] != null
//           ? DateTime.tryParse(json['dateOfBirth'] as String)
//           : null,
//       heightCm: json['heightCm'] != null
//           ? (json['heightCm'] as num).toDouble()
//           : null,
//       lastWeightKg: json['lastWeightKg'] != null
//           ? (json['lastWeightKg'] as num).toDouble()
//           : null,
//       lastMuscleMassKg: json['lastMuscleMassKgdecimal'] != null
//           ? (json['lastMuscleMassKgdecimal'] as num).toDouble()
//           : null,
//       lastBodyFatPercent: json['lastBodyFatPercent'] != null
//           ? (json['lastBodyFatPercent'] as num).toDouble()
//           : null,
//       phoneNumber: json['phoneNumber'] as String?,
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     'firstName': firstName,
//     'lastName': lastName,
//     'gender': gender,
//     'role': role,
//     'dateOfBirth': dateOfBirth?.toIso8601String(),
//     'heightCm': heightCm,
//     'lastWeightKg': lastWeightKg,
//     'lastMuscleMassKgdecimal': lastMuscleMassKg,
//     'lastBodyFatPercent': lastBodyFatPercent,
//     'phoneNumber': phoneNumber,
//   };
//
//   bool get isUser => role == Constants.userRole;
//   bool get isTrainer => role == Constants.trainerRole;
//
//   String get roleString {
//     switch (role) {
//       case Constants.userRole:
//         return 'User';
//       case Constants.trainerRole:
//         return 'Trainer';
//       default:
//         return 'Unknown';
//     }
//   }
//
//   String get genderString {
//     switch (gender) {
//       case 1:
//         return 'Male';
//       case 2:
//         return 'Female';
//       default:
//         return 'Male';
//     }
//   }
//
//   bool get isProfileComplete {
//     return firstName != null &&
//         firstName!.isNotEmpty &&
//         lastName != null &&
//         lastName!.isNotEmpty &&
//         gender != null;
//   }
//
//   bool get hasBodyMetrics {
//     return lastWeightKg != null ||
//         lastMuscleMassKg != null ||
//         lastBodyFatPercent != null;
//   }
//
//   @override
//   List<Object?> get props => [
//     firstName,
//     lastName,
//     gender,
//     role,
//     dateOfBirth,
//     heightCm,
//     lastWeightKg,
//     lastMuscleMassKg,
//     lastBodyFatPercent,
//     phoneNumber,
//   ];
//
//   @override
//   String toString() {
//     return 'LoginProfileModel(firstName: $firstName, lastName: $lastName, '
//         'gender: $genderString, role: $roleString, '
//         'weight: $lastWeightKg kg, muscleMass: $lastMuscleMassKg kg, '
//         'bodyFat: $lastBodyFatPercent%, phone: $phoneNumber)';
//   }
//
//   LoginProfileModel copyWith({
//     String? firstName,
//     String? lastName,
//     int? gender,
//     int? role,
//     DateTime? dateOfBirth,
//     double? heightCm,
//     double? lastWeightKg,
//     double? lastMuscleMassKg,
//     double? lastBodyFatPercent,
//     String? phoneNumber,
//   }) {
//     return LoginProfileModel(
//       firstName: firstName ?? this.firstName,
//       lastName: lastName ?? this.lastName,
//       gender: gender ?? this.gender,
//       role: role ?? this.role,
//       dateOfBirth: dateOfBirth ?? this.dateOfBirth,
//       heightCm: heightCm ?? this.heightCm,
//       lastWeightKg: lastWeightKg ?? this.lastWeightKg,
//       lastMuscleMassKg: lastMuscleMassKg ?? this.lastMuscleMassKg,
//       lastBodyFatPercent: lastBodyFatPercent ?? this.lastBodyFatPercent,
//       phoneNumber: phoneNumber ?? this.phoneNumber,
//     );
//   }
// }
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

  @HiveField(9)
  final String? phoneNumber;

  // ✅ Add goal fields
  @HiveField(10)
  final double? weightGoal;

  @HiveField(11)
  final double? bodyFatGoal;

  @HiveField(12)
  final double? muscleMassGoal;

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
    this.phoneNumber,
    this.weightGoal,
    this.bodyFatGoal,
    this.muscleMassGoal,
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
          : json['lastMuscleMassKg'] != null
          ? (json['lastMuscleMassKg'] as num).toDouble()
          : null,
      lastBodyFatPercent: json['lastBodyFatPercent'] != null
          ? (json['lastBodyFatPercent'] as num).toDouble()
          : null,
      phoneNumber: json['phoneNumber'] as String?,
      // ✅ Parse goal fields with correct API field names
      weightGoal: json['lastWeightGoal'] != null
          ? (json['lastWeightGoal'] as num).toDouble()
          : null,
      bodyFatGoal: json['lastBodyFatGoal'] != null
          ? (json['lastBodyFatGoal'] as num).toDouble()
          : null,
      muscleMassGoal: json['lastMuscleMassGoal'] != null
          ? (json['lastMuscleMassGoal'] as num).toDouble()
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
    'lastMuscleMassKgdecimal': lastMuscleMassKg,
    'lastBodyFatPercent': lastBodyFatPercent,
    'phoneNumber': phoneNumber,
    'weightGoal': weightGoal,
    'bodyFatGoal': bodyFatGoal,
    'muscleMassGoal': muscleMassGoal,
  };

  bool get isUser => role == Constants.userRole;
  bool get isTrainer => role == Constants.trainerRole;

  String get roleString {
    switch (role) {
      case Constants.userRole:
        return 'User';
      case Constants.trainerRole:
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

  bool get hasGoals {
    return weightGoal != null || bodyFatGoal != null || muscleMassGoal != null;
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
    phoneNumber,
    weightGoal,
    bodyFatGoal,
    muscleMassGoal,
  ];

  @override
  String toString() {
    return 'LoginProfileModel(firstName: $firstName, lastName: $lastName, '
        'gender: $genderString, role: $roleString, '
        'weight: $lastWeightKg kg, muscleMass: $lastMuscleMassKg kg, '
        'bodyFat: $lastBodyFatPercent%, phone: $phoneNumber, '
        'goals: weight=$weightGoal, bodyFat=$bodyFatGoal, muscleMass=$muscleMassGoal)';
  }

  LoginProfileModel copyWith({
    String? firstName,
    String? lastName,
    int? gender,
    int? role,
    DateTime? dateOfBirth,
    double? heightCm,
    double? lastWeightKg,
    double? lastMuscleMassKg,
    double? lastBodyFatPercent,
    String? phoneNumber,
    double? weightGoal,
    double? bodyFatGoal,
    double? muscleMassGoal,
  }) {
    return LoginProfileModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      role: role ?? this.role,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      heightCm: heightCm ?? this.heightCm,
      lastWeightKg: lastWeightKg ?? this.lastWeightKg,
      lastMuscleMassKg: lastMuscleMassKg ?? this.lastMuscleMassKg,
      lastBodyFatPercent: lastBodyFatPercent ?? this.lastBodyFatPercent,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      weightGoal: weightGoal ?? this.weightGoal,
      bodyFatGoal: bodyFatGoal ?? this.bodyFatGoal,
      muscleMassGoal: muscleMassGoal ?? this.muscleMassGoal,
    );
  }
}
