import 'package:equatable/equatable.dart';
import 'dart:developer' as dev;
import 'login_profile_model.dart';

class LoginResponseModel extends Equatable {
  final TokenModel token;
  final LoginProfileModel profile;

  const LoginResponseModel({required this.token, required this.profile});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: TokenModel.fromJson(json['token']),
      profile: LoginProfileModel.fromJson(json['profile']),
    );
  }

  Map<String, dynamic> toJson() => {
    'token': token.toJson(),
    'profile': profile.toJson(),
  };

  @override
  List<Object?> get props => [token, profile];
}

class TokenModel extends Equatable {
  final String accessToken;
  final String refreshToken;
  final DateTime expiresOnUtc;
  final UserLoginModel user;

  const TokenModel({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresOnUtc,
    required this.user,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    final expiryString = json['expiresOnUtc'] as String;
    DateTime expiryDate;

    if (expiryString.endsWith('Z')) {
      expiryDate = DateTime.parse(expiryString);
    } else {
      expiryDate = DateTime.parse('${expiryString}Z');
    }

    dev.log('📅 Token expiry parsed: $expiryDate', name: 'TokenModel');

    return TokenModel(
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      expiresOnUtc: expiryDate,
      user: UserLoginModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() => {
    'accessToken': accessToken,
    'refreshToken': refreshToken,
    'expiresOnUtc': expiresOnUtc.toIso8601String(),
    'user': user.toJson(),
  };

  @override
  List<Object?> get props => [accessToken, refreshToken, expiresOnUtc, user];
}

class UserLoginModel extends Equatable {
  final String userId;
  final String email;
  final List<String> roles;

  const UserLoginModel({
    required this.userId,
    required this.email,
    required this.roles,
  });

  factory UserLoginModel.fromJson(Map<String, dynamic> json) {
    return UserLoginModel(
      userId: json['userId'] ?? '',
      email: json['email'] ?? '',
      roles: List<String>.from(json['roles'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'email': email,
    'roles': roles,
  };

  @override
  List<Object?> get props => [userId, email, roles];
}
