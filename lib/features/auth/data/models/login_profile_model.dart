import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'login_profile_model.g.dart';

@HiveType(typeId: 1)
class LoginProfileModel extends Equatable {
  @HiveField(0)
  final String? firstName;

  @HiveField(1)
  final String? lastName;

  @HiveField(2)
  final int? gender;

  @HiveField(3)
  final int? role;

  const LoginProfileModel({
    this.firstName,
    this.lastName,
    this.gender,
    this.role,
  });

  factory LoginProfileModel.fromJson(Map<String, dynamic> json) {
    return LoginProfileModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'gender': gender,
    'role': role,
  };

  @override
  List<Object?> get props => [firstName, lastName, gender, role];
}
