import 'package:flutter/material.dart';

class Trainer {
  final String id;
  final String name;
  final String? email;
  final String? phoneNumber;
  final int gender; // 1 = Male, 2 = Female
  final bool hasRequestPending;
  final bool isInRelation; // Add this field
  final String? image; // Changed from trainerImage/traineeImage to single image

  Trainer({
    required this.id,
    required this.name,
    this.email,
    this.image,
    this.phoneNumber,
    required this.gender,
    this.hasRequestPending = false,
    this.isInRelation = false, // Add this
  });

  factory Trainer.fromJson(Map<String, dynamic> json) {
    return Trainer(
      id: json['userId'] ?? '',
      name: json['userName'] ?? 'Unknown Trainer',
      email: json['email'],
      image: json['image'], // Changed to match API
      phoneNumber: json['phoneNumber'],
      gender: json['gender'] ?? 1,
      hasRequestPending: json['hasRequestPending'] ?? false,
      isInRelation: json['isInRelation'] ?? false, // Add this
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': id,
      'userName': name,
      'email': email,
      'image': image,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'hasRequestPending': hasRequestPending,
      'isInRelation': isInRelation, // Add this
    };
  }

  Trainer copyWith({
    String? id,
    String? name,
    String? email,
    String? image,
    String? phoneNumber,
    int? gender,
    bool? hasRequestPending,
    bool? isInRelation, // Add this
  }) {
    return Trainer(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      image: image ?? this.image,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      hasRequestPending: hasRequestPending ?? this.hasRequestPending,
      isInRelation: isInRelation ?? this.isInRelation, // Add this
    );
  }

  // Helper getter for gender display
  String get genderText => gender == 1 ? 'Male' : 'Female';

  // Helper getter for gender icon
  IconData get genderIcon => gender == 1 ? Icons.male : Icons.female;
}
