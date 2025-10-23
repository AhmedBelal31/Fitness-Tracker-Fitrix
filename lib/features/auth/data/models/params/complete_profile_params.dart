import 'package:equatable/equatable.dart';

class CompleteProfileParams extends Equatable {
  final String firstName;
  final String lastName;
  final String gender;
  final double? weightKg;
  // final double? weightGoal;
  final double? bodyFatPercent;
  final double? muscleMassKg;

  const CompleteProfileParams({
    required this.firstName,
    required this.lastName,
    required this.gender,
    this.weightKg,
    // this.weightGoal,
    this.bodyFatPercent,
    this.muscleMassKg,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'FirstName': firstName,
      'LastName': lastName,
      'Gender': gender == "Male" ? 1 : 2,
    };
    if (weightKg != null) map['WeightKg'] = weightKg;
    // if (weightKg != null) map['WeightGoal'] = weightKg;
    if (bodyFatPercent != null) map['BodyFatPercent'] = bodyFatPercent;
    if (muscleMassKg != null) map['MuscleMassKg'] = muscleMassKg;
    return map;
  }

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    gender,
    weightKg,
    bodyFatPercent,
    muscleMassKg,
  ];

  @override
  String toString() {
    return 'CompleteProfileParams(firstName: $firstName, lastName: $lastName, gender: $gender)';
  }
}
