import 'package:equatable/equatable.dart';
import 'package:equatable/equatable.dart';

enum NotificationType {
  general, // 0
  workout, // 1
  progress, // 2
  achievement, // 3
  trainer, // 4
  reminder, // 5
  update, // 6
  system, // 7
  social, // 8
  custom; // 9 - This is what the API is sending

  String get displayName {
    switch (this) {
      case NotificationType.general:
        return 'General';
      case NotificationType.workout:
        return 'Workout';
      case NotificationType.progress:
        return 'Progress';
      case NotificationType.achievement:
        return 'Achievement';
      case NotificationType.trainer:
        return 'Trainer';
      case NotificationType.reminder:
        return 'Reminder';
      case NotificationType.update:
        return 'Update';
      case NotificationType.system:
        return 'System';
      case NotificationType.social:
        return 'Social';
      case NotificationType.custom:
        return 'Custom';
    }
  }
}

class NotificationModel extends Equatable {
  final String id;
  final String title;
  final String body;
  final NotificationType type;
  final bool isRead;
  final DateTime createdAtUtc;
  final DateTime? readAtUtc;
  final Map<String, String>? data;
  final String? image;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.isRead,
    required this.createdAtUtc,
    this.readAtUtc,
    this.data,
    this.image,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    // Safely parse type with bounds checking
    final typeIndex = json['type'] as int;
    final type = typeIndex >= 0 && typeIndex < NotificationType.values.length
        ? NotificationType.values[typeIndex]
        : NotificationType.custom; // Default to custom if out of range

    return NotificationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      type: type,
      isRead: json['isRead'] as bool,
      createdAtUtc: DateTime.parse(json['createdAtUtc'] as String),
      readAtUtc: json['readAtUtc'] != null
          ? DateTime.parse(json['readAtUtc'] as String)
          : null,
      data: json['data'] != null
          ? Map<String, String>.from(json['data'] as Map)
          : null,
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'type': type.index,
      'isRead': isRead,
      'createdAtUtc': createdAtUtc.toIso8601String(),
      'readAtUtc': readAtUtc?.toIso8601String(),
      'data': data,
      'image': image,
    };
  }

  NotificationModel copyWith({
    String? id,
    String? title,
    String? body,
    NotificationType? type,
    bool? isRead,
    DateTime? createdAtUtc,
    DateTime? readAtUtc,
    Map<String, String>? data,
    String? image,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      createdAtUtc: createdAtUtc ?? this.createdAtUtc,
      readAtUtc: readAtUtc ?? this.readAtUtc,
      data: data ?? this.data,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    body,
    type,
    isRead,
    createdAtUtc,
    readAtUtc,
    data,
    image,
  ];
}
