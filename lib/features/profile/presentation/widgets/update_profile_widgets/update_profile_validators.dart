import 'package:flutter/material.dart';
import '../../../../../generated/l10n.dart';

// class UpdateProfileValidators {
//   String? validateRequired(
//     String? value,
//     String fieldName,
//     BuildContext context,
//   ) {
//     final s = S.of(context);
//
//     if (value == null || value.trim().isEmpty) {
//       if (fieldName == s.firstName) {
//         return s.firstNameRequired;
//       } else if (fieldName == s.lastName) {
//         return s.lastNameRequired;
//       }
//       return '$fieldName is required';
//     }
//     return null;
//   }
//
//   String? validateGender(String? gender, BuildContext context) {
//     final s = S.of(context);
//
//     if (gender == null) return s.genderRequired;
//     if (gender != "Male" && gender != "Female") {
//       return s.selectMaleOrFemale;
//     }
//     return null;
//   }
//
//   String? validatePhone(String? value, BuildContext context) {
//     final s = S.of(context);
//
//     if (value == null || value.isEmpty) return null; // Optional
//
//     final cleanedValue = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');
//     final egyptianMobileRegex = RegExp(r'^(0|\+?20)?1[0125]\d{8}$');
//
//     if (!egyptianMobileRegex.hasMatch(cleanedValue)) {
//       return s.invalidEgyptianPhone;
//     }
//
//     final digitsOnly = cleanedValue.replaceAll(RegExp(r'\D'), '');
//     if (digitsOnly.length != 11 && digitsOnly.length != 13) {
//       return s.phoneExactLength;
//     }
//
//     return null;
//   }
//
//   String? validateWeight(String? value, BuildContext context) {
//     final s = S.of(context);
//
//     if (value == null || value.trim().isEmpty) {
//       return s.weightRequired;
//     }
//
//     final num? weight = num.tryParse(value);
//     if (weight == null || weight <= 0) {
//       return s.enterValidWeight;
//     }
//
//     if (weight > 700) {
//       return s.checkWeightEntered;
//     }
//
//     return null;
//   }
//
//   String? validateHeight(String? value, BuildContext context) {
//     final s = S.of(context);
//
//     if (value == null || value.trim().isEmpty) return null; // Optional
//
//     final num? height = num.tryParse(value);
//     if (height == null || height <= 0) {
//       return s.enterValidHeight;
//     }
//
//     if (height > 300) {
//       return s.checkHeightEntered;
//     }
//
//     return null;
//   }
//
//   String? validateBodyFat(String? value, BuildContext context) {
//     final s = S.of(context);
//
//     if (value == null || value.trim().isEmpty) return null; // Optional
//
//     final num? fat = num.tryParse(value);
//     if (fat == null) return s.enterNumber;
//     if (fat < 1 || fat > 70) return s.enterRealisticBodyFat;
//     return null;
//   }
//
//   String? validateMuscleMass(String? value, BuildContext context) {
//     final s = S.of(context);
//
//     if (value == null || value.trim().isEmpty) return null; // Optional
//
//     final num? mass = num.tryParse(value);
//     if (mass == null || mass <= 0) return s.enterValidMuscleMass;
//     if (mass > 250) return s.checkMuscleMassEntered;
//     return null;
//   }
// }
class UpdateProfileValidators {
  String? validateRequired(
    String? value,
    String fieldName,
    BuildContext context,
  ) {
    final s = S.of(context);

    if (value == null || value.trim().isEmpty) {
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

  String? validatePhone(String? value, BuildContext context) {
    final s = S.of(context);

    if (value == null || value.isEmpty) return null; // Optional

    final cleanedValue = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    final egyptianMobileRegex = RegExp(r'^(0|\+?20)?1[0125]\d{8}$');

    if (!egyptianMobileRegex.hasMatch(cleanedValue)) {
      return s.invalidEgyptianPhone;
    }

    final digitsOnly = cleanedValue.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length != 11 && digitsOnly.length != 13) {
      return s.phoneExactLength;
    }

    return null;
  }

  // ✅ Add isRequired parameter
  String? validateWeight(
    String? value,
    BuildContext context, {
    bool isRequired = true,
  }) {
    final s = S.of(context);

    if (value == null || value.trim().isEmpty) {
      return isRequired ? s.weightRequired : null;
    }

    final num? weight = num.tryParse(value);
    if (weight == null || weight <= 0) {
      return s.enterValidWeight;
    }

    if (weight > 700) {
      return s.checkWeightEntered;
    }

    return null;
  }

  // ✅ Add isRequired parameter
  String? validateHeight(
    String? value,
    BuildContext context, {
    bool isRequired = false,
  }) {
    final s = S.of(context);

    if (value == null || value.trim().isEmpty) {
      return isRequired ? s.heightRequired : null;
    }

    final num? height = num.tryParse(value);
    if (height == null || height <= 0) {
      return s.enterValidHeight;
    }

    if (height > 300) {
      return s.checkHeightEntered;
    }

    return null;
  }

  // ✅ Add isRequired parameter
  String? validateBodyFat(
    String? value,
    BuildContext context, {
    bool isRequired = false,
  }) {
    final s = S.of(context);

    if (value == null || value.trim().isEmpty) {
      return isRequired ? s.bodyFatRequired : null;
    }

    final num? fat = num.tryParse(value);
    if (fat == null) return s.enterNumber;
    if (fat < 1 || fat > 70) return s.enterRealisticBodyFat;
    return null;
  }

  // ✅ Add isRequired parameter
  String? validateMuscleMass(
    String? value,
    BuildContext context, {
    bool isRequired = false,
  }) {
    final s = S.of(context);

    if (value == null || value.trim().isEmpty) {
      return isRequired ? s.muscleMassRequired : null;
    }

    final num? mass = num.tryParse(value);
    if (mass == null || mass <= 0) return s.enterValidMuscleMass;
    if (mass > 250) return s.checkMuscleMassEntered;
    return null;
  }
}
