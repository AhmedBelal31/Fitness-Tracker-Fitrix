// lib/features/trainer/domain/models/trainer_request.dart

import 'user_dto.dart';

class TrainerRequestResponse {
  final String id;
  final String traineeId;
  final String trainerId;
  final String? message;
  final RequestStatus status;
  final DateTime createdAt;
  final UserDto? trainee;
  final UserDto? trainer;

  TrainerRequestResponse({
    required this.id,
    required this.traineeId,
    required this.trainerId,
    this.message,
    required this.status,
    required this.createdAt,
    this.trainee,
    this.trainer,
  });

  factory TrainerRequestResponse.fromJson(
    Map<String, dynamic> json,
  ) => TrainerRequestResponse(
    id: json['id'] ?? '',
    traineeId: json['traineeId'] ?? '',
    trainerId: json['trainerId'] ?? '',
    message: json['message'],
    status: RequestStatus.values[json['status'] ?? 0],
    createdAt: json['createdAt'] != null
        ? DateTime.parse(json['createdAt'])
        : DateTime.now(),
    trainee: json['trainee'] != null ? UserDto.fromJson(json['trainee']) : null,
    trainer: json['trainer'] != null ? UserDto.fromJson(json['trainer']) : null,
  );
}

enum RequestStatus { pending, accepted, rejected, cancelled }
