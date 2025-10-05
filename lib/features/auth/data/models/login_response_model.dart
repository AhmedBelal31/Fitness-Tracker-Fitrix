import 'package:equatable/equatable.dart';
import 'dart:developer' as dev;

class LoginResponseModel extends Equatable {
  final String accessToken;
  final String refreshToken;
  final DateTime expiresOnUtc;

  const LoginResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresOnUtc,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final expiryString = json['expiresOnUtc'] as String;

    // Parse the date - API returns UTC time without 'Z' marker
    DateTime expiryDate;
    if (expiryString.endsWith('Z')) {
      expiryDate = DateTime.parse(expiryString);
    } else {
      // Add 'Z' to indicate UTC if not present
      expiryDate = DateTime.parse('${expiryString}Z');
    }

    dev.log('📅 Token expiry parsed: $expiryDate', name: 'LoginResponseModel');

    return LoginResponseModel(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresOnUtc: expiryDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'expiresOnUtc': expiresOnUtc.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [accessToken, refreshToken, expiresOnUtc];

  @override
  String toString() {
    return 'LoginResponseModel(expiresOnUtc: $expiresOnUtc)';
  }
}
