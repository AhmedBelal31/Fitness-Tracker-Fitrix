import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/register/register_cubit.dart';

class RegisterValidators {
  String? validateUserName(String? value, BuildContext context) {
    final serverError = _getServerError('UserName', context);
    if (serverError != null) return serverError;

    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    if (value.length < 3) {
      return 'Username must be at least 3 characters';
    }
    return null;
  }

  String? validateEmail(String? value, BuildContext context) {
    final serverError = _getServerError('Email', context);
    if (serverError != null) return serverError;

    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePhone(String? value, BuildContext context) {
    final serverError = _getServerError('PhoneNumber', context);
    if (serverError != null) return serverError;

    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    // Remove all spaces, dashes, and parentheses for validation
    final cleanedValue = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    // Egyptian mobile number validation
    // Format: 01[0125]XXXXXXXX (11 digits starting with 01)
    // Carriers: 010 (Vodafone), 011 (Etisalat), 012 (Orange), 015 (We)
    final egyptianMobileRegex = RegExp(r'^(0|\+?20)?1[0125]\d{8}$');

    if (!egyptianMobileRegex.hasMatch(cleanedValue)) {
      return 'Please enter a valid Egyptian phone number (e.g., 01012345678)';
    }

    // Ensure the phone number is exactly 11 digits (without country code)
    // or 13 digits (with +20 country code)
    final digitsOnly = cleanedValue.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length != 11 && digitsOnly.length != 13) {
      return 'Phone number must be 11 digits';
    }

    return null;
  }

  String? validatePassword(String? value, BuildContext context) {
    final serverError = _getServerError('Password', context);
    if (serverError != null) return serverError;

    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
      return 'Password must contain uppercase, lowercase and number';
    }
    return null;
  }

  String? _getServerError(String fieldName, BuildContext context) {
    if (!context.mounted) return null;
    return context.read<RegisterCubit>().state.getFieldError(fieldName);
  }
}
