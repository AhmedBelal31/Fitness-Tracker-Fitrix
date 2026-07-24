// class UserRequest {
//   final String id;
//   final String trainerId;
//   final String trainerName;
//   final String? trainerImage;
//   final String traineeId;
//   final String traineeName;
//   final int status; // 1 = Pending, 2 = Accepted, 3 = Rejected
//   final String? message;
//   final DateTime createdAt;
//   final DateTime? respondedAt;
//
//   UserRequest({
//     required this.id,
//     required this.trainerId,
//     required this.trainerName,
//     this.trainerImage,
//     required this.traineeId,
//     required this.traineeName,
//     required this.status,
//     this.message,
//     required this.createdAt,
//     this.respondedAt,
//   });
//
//   factory UserRequest.fromJson(Map<String, dynamic> json) {
//     return UserRequest(
//       id: json['requestId'] ?? '',
//       trainerId: json['trainerId'] ?? '',
//       trainerName: json['trainerFullName'] ?? 'Unknown Trainer',
//       trainerImage: json['trainerImage'],
//       traineeId: json['traineeId'] ?? '',
//       traineeName: json['traineeFullName'] ?? 'Unknown User',
//       status: json['status'] ?? 0,
//       message: json['message'],
//       createdAt: DateTime.parse(json['createdAtUtc']),
//       respondedAt: json['respondedAtUtc'] != null
//           ? DateTime.parse(json['respondedAtUtc'])
//           : null,
//     );
//   }
//
//   // Helper getter for display
//   String? get image => trainerImage;
//
//   bool get isPending => status == 1;
//   bool get isAccepted => status == 2;
//   bool get isRejected => status == 3;
// }
class UserRequestResponse {
  final int totalCount;
  final int pendingCount;
  final List<UserRequest> requests;

  UserRequestResponse({
    required this.totalCount,
    required this.pendingCount,
    required this.requests,
  });

  factory UserRequestResponse.fromJson(Map<String, dynamic> json) {
    return UserRequestResponse(
      totalCount: json['totalCount'] ?? 0,
      pendingCount: json['pendingCount'] ?? 0,
      requests:
          (json['requests'] as List?)
              ?.map((e) => UserRequest.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class UserRequest {
  final String id;
  final String traineeId;
  final String traineeName;
  final String? traineeProfilePicture;
  final String trainerId;
  final String trainerName;
  final String? trainerProfilePicture;
  final int status; // 1=Pending, 2=Accepted, 3=Rejected
  final String? message;
  final DateTime createdAt;
  final DateTime? respondedAt;

  UserRequest({
    required this.id,
    required this.traineeId,
    required this.traineeName,
    this.traineeProfilePicture,
    required this.trainerId,
    required this.trainerName,
    this.trainerProfilePicture,
    required this.status,
    this.message,
    required this.createdAt,
    this.respondedAt,
  });

  factory UserRequest.fromJson(Map<String, dynamic> json) {
    return UserRequest(
      id: json['requestId'] ?? '',
      traineeId: json['traineeId'] ?? '',
      traineeName: json['traineeFullName'] ?? 'Unknown',
      traineeProfilePicture: json['traineeImage'],
      trainerId: json['trainerId'] ?? '',
      trainerName: json['trainerFullName'] ?? 'Unknown',
      trainerProfilePicture: json['trainerImage'],
      status: json['status'] ?? 1,
      message: json['message'],
      createdAt: json['createdAtUtc'] != null
          ? DateTime.parse(json['createdAtUtc'])
          : DateTime.now(),
      respondedAt: json['respondedAtUtc'] != null
          ? DateTime.parse(json['respondedAtUtc'])
          : null,
    );
  }
}
