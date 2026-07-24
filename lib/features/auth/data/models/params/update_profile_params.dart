import 'package:dio/dio.dart';

class UpdateProfileParams {
  final String firstName;
  final String lastName;
  final int gender;
  final String? phoneNumber;
  final DateTime? birthDate;
  final int? heightCm;
  final double? weightKg;
  final double? bodyFatPercent;
  final double? muscleMassKg;
  final double? weightGoal;
  final double? bodyFatGoal;
  final double? muscleMassGoal;

  UpdateProfileParams({
    required this.firstName,
    required this.lastName,
    required this.gender,
    this.phoneNumber,
    this.birthDate,
    this.heightCm,
    this.weightKg,
    this.bodyFatPercent,
    this.muscleMassKg,
    this.weightGoal,
    this.bodyFatGoal,
    this.muscleMassGoal,
  });

  FormData toFormData() {
    return FormData.fromMap({
      'FirstName': firstName,
      'LastName': lastName,
      'Gender': gender.toString(),
      if (phoneNumber != null && phoneNumber!.isNotEmpty)
        'PhoneNumber': phoneNumber,
      // ✅ Add BirthDate in RFC 3339 format
      if (birthDate != null) 'BirthDate': birthDate!.toIso8601String(),
      if (heightCm != null) 'HeightCm': heightCm,
      if (weightKg != null) 'WeightKg': weightKg,
      if (bodyFatPercent != null) 'BodyFatPercent': bodyFatPercent,
      if (muscleMassKg != null) 'MuscleMassKg': muscleMassKg,
      if (weightGoal != null) 'WeightGoal': weightGoal,
      if (bodyFatGoal != null) 'BodyFatGoal': bodyFatGoal,
      if (muscleMassGoal != null) 'MuscleMassGoal': muscleMassGoal,
    });
  }

  Map<String, dynamic> toMap() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Gender': gender.toString(),
      if (phoneNumber != null && phoneNumber!.isNotEmpty)
        'PhoneNumber': phoneNumber,
      // ✅ Add BirthDate in RFC 3339 format
      if (birthDate != null) 'BirthDate': birthDate!.toIso8601String(),
      if (heightCm != null) 'HeightCm': heightCm,
      if (weightKg != null) 'WeightKg': weightKg,
      if (bodyFatPercent != null) 'BodyFatPercent': bodyFatPercent,
      if (muscleMassKg != null) 'MuscleMassKg': muscleMassKg,
      if (weightGoal != null) 'WeightGoal': weightGoal,
      if (bodyFatGoal != null) 'BodyFatGoal': bodyFatGoal,
      if (muscleMassGoal != null) 'MuscleMassGoal': muscleMassGoal,
    };
  }
}
