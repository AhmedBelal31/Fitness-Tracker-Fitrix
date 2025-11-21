import 'package:flutter/material.dart';
import '../../../../../generated/l10n.dart';

class CompleteProfileValidators {
  String? validateRequired(
    String? value,
    String fieldName,
    BuildContext context,
  ) {
    final s = S.of(context);

    if (value == null || value.trim().isEmpty) {
      // Map field names to localized messages
      if (fieldName == s.firstName) {
        return s.firstNameRequired;
      } else if (fieldName == s.lastName) {
        return s.lastNameRequired;
      }
      return '$fieldName is required';
    }
    return null;
  }

  String? validateGender(String? gender, BuildContext context) {
    final s = S.of(context);

    if (gender == null) return s.genderRequired;
    if (gender != "Male" && gender != "Female") {
      return s.selectMaleOrFemale;
    }
    return null;
  }

  // 👇 UPDATED: Weight is now required
  String? validateWeight(String? value, BuildContext context) {
    final s = S.of(context);

    // Check if empty - REQUIRED
    if (value == null || value.trim().isEmpty) {
      return s.weightRequired;
    }

    // Check if valid number
    final num? weight = num.tryParse(value);
    if (weight == null || weight <= 0) {
      return s.enterValidWeight;
    }

    // Check reasonable range
    if (weight > 700) {
      return s.checkWeightEntered;
    }

    return null;
  }

  String? validateBodyFat(String? value, BuildContext context) {
    final s = S.of(context);

    // Optional field
    if (value == null || value.trim().isEmpty) return null;

    final num? fat = num.tryParse(value);
    if (fat == null) return s.enterNumber;
    if (fat < 1 || fat > 70) return s.enterRealisticBodyFat;
    return null;
  }

  String? validateMuscleMass(String? value, BuildContext context) {
    final s = S.of(context);

    // Optional field
    if (value == null || value.trim().isEmpty) return null;

    final num? mass = num.tryParse(value);
    if (mass == null || mass <= 0) return s.enterValidMuscleMass;
    if (mass > 250) return s.checkMuscleMassEntered;
    return null;
  }
}
