import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../generated/l10n.dart';
import '../../cubits/register/register_cubit.dart';

class RegisterValidators {
  String? validateUserName(String? value, BuildContext context) {
    final serverError = _getServerError('UserName', context);
    if (serverError != null) return serverError;

    final s = S.of(context);

    if (value == null || value.isEmpty) {
      return s.usernameRequired;
    }
    if (value.length < 3) {
      return s.usernameMinLength;
    }
    return null;
  }

  String? validateEmail(String? value, BuildContext context) {
    final serverError = _getServerError('Email', context);
    if (serverError != null) return serverError;

    final s = S.of(context);

    if (value == null || value.isEmpty) {
      return s.emailRequired;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return s.invalidEmail;
    }
    return null;
  }

  String? validatePhone(String? value, BuildContext context) {
    final serverError = _getServerError('PhoneNumber', context);
    if (serverError != null) return serverError;

    final s = S.of(context);

    if (value == null || value.isEmpty) {
      return s.phoneRequired;
    }

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

  String? validatePassword(String? value, BuildContext context) {
    final serverError = _getServerError('Password', context);
    if (serverError != null) return serverError;

    final s = S.of(context);

    if (value == null || value.isEmpty) {
      return s.passwordRequired;
    }
    if (value.length < 8) {
      return s.passwordMinLength;
    }
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
      return s.passwordComplexity;
    }
    return null;
  }

  String? _getServerError(String fieldName, BuildContext context) {
    if (!context.mounted) return null;
    return context.read<RegisterCubit>().state.getFieldError(fieldName);
  }
}
