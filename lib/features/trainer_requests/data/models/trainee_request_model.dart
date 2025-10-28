import 'package:flutter/material.dart';

class TraineeRequest {
  final String id;
  final String traineeId;
  final String traineeName;
  final String? traineeImage;
  final String trainerId;
  final String trainerName;
  final int status;
  final String? message;
  final DateTime createdAt;
  final DateTime? respondedAt;

  TraineeRequest({
    required this.id,
    required this.traineeId,
    required this.traineeName,
    this.traineeImage,
    required this.trainerId,
    required this.trainerName,
    required this.status,
    this.message,
    required this.createdAt,
    this.respondedAt,
  });

  bool get isPending => status == 1;
  bool get isAccepted => status == 2;
  bool get isRejected => status == 3;

  factory TraineeRequest.fromJson(Map<String, dynamic> json) {
    return TraineeRequest(
      id: json['requestId'] ?? '',
      traineeId: json['traineeId'] ?? '',
      traineeName: json['traineeFullName'] ?? 'Unknown',
      traineeImage: json['traineeImage'],
      trainerId: json['trainerId'] ?? '',
      trainerName: json['trainerFullName'] ?? '',
      status: json['status'] ?? 1,
      message: json['message'],
      createdAt: DateTime.parse(json['createdAtUtc']),
      respondedAt: json['respondedAtUtc'] != null
          ? DateTime.parse(json['respondedAtUtc'])
          : null,
    );
  }
}

class Trainee {
  final String id;
  final String name;
  final String? email;
  final String? phoneNumber;
  final int gender; // 1 = Male, 2 = Female
  final bool hasRequestPending;
  final bool isInRelation;
  final String? image;

  Trainee({
    required this.id,
    required this.name,
    this.email,
    this.image,
    this.phoneNumber,
    required this.gender,
    this.hasRequestPending = false,
    this.isInRelation = false,
  });

  factory Trainee.fromJson(Map<String, dynamic> json) {
    return Trainee(
      id: json['userId'] ?? '',
      name: json['userName'] ?? 'Unknown Trainee',
      email: json['email'],
      image: json['image'],
      phoneNumber: json['phoneNumber'],
      gender: json['gender'] ?? 1,
      hasRequestPending: json['hasRequestPending'] ?? false,
      isInRelation: json['isInRelation'] ?? false,
    );
  }

  // Helper getters
  String get genderText => gender == 1 ? 'Male' : 'Female';
  IconData get genderIcon => gender == 1 ? Icons.male : Icons.female;
}
