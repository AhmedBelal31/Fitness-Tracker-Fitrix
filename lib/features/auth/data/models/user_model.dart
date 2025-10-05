import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? id;
  final String userName;
  final String email;
  final String phoneNumber;
  final String role;
  final String? token;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserModel({
    this.id,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.role,
    this.token,
    this.createdAt,
    this.updatedAt,
  });

  // From JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      userName:
          json['userName'] as String? ?? json['username'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phoneNumber:
          json['phoneNumber'] as String? ?? json['phone'] as String? ?? '',
      role: json['role'] as String? ?? 'user',
      token: json['token'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'] as String)
          : null,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
      'phoneNumber': phoneNumber,
      'role': role,
      'token': token,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  // CopyWith method
  UserModel copyWith({
    String? id,
    String? userName,
    String? email,
    String? phoneNumber,
    String? role,
    String? token,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      token: token ?? this.token,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    userName,
    email,
    phoneNumber,
    role,
    token,
    createdAt,
    updatedAt,
  ];

  @override
  String toString() {
    return 'UserModel(id: $id, userName: $userName, email: $email, phoneNumber: $phoneNumber, role: $role)';
  }
}
