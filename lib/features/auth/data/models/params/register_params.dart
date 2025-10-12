import 'package:equatable/equatable.dart';

class RegisterParams extends Equatable {
  final String userName;
  final String email;
  final String password;
  final String phoneNumber;
  final int role;

  const RegisterParams({
    required this.userName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.role,
  });

  // To JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'role': role,
    };
  }

  // CopyWith method
  RegisterParams copyWith({
    String? userName,
    String? email,
    String? password,
    String? phoneNumber,
    int? role,
  }) {
    return RegisterParams(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
    );
  }

  @override
  List<Object?> get props => [userName, email, password, phoneNumber, role];

  @override
  String toString() {
    return 'RegisterParams(userName: $userName, email: $email, phoneNumber: $phoneNumber, role: $role)';
  }
}
