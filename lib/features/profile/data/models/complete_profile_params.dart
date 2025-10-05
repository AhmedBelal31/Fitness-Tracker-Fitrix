import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class CompleteProfileParams extends Equatable {
  final String firstName;
  final String lastName;
  final String gender;
  final double? weightKg;
  final double? bodyFatPercent;
  final double? muscleMassKg;

  const CompleteProfileParams({
    required this.firstName,
    required this.lastName,
    required this.gender,
    this.weightKg,
    this.bodyFatPercent,
    this.muscleMassKg,
  });

  FormData toFormData() {
    final map = <String, dynamic>{
      'FirstName': firstName,
      'LastName': lastName,
      'Gender': gender == "Male" ? 1 : 2,
    };
    if (weightKg != null) map['WeightKg'] = weightKg;
    if (bodyFatPercent != null) map['BodyFatPercent'] = bodyFatPercent;
    if (muscleMassKg != null) map['MuscleMassKg'] = muscleMassKg;
    return FormData.fromMap(map);
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
