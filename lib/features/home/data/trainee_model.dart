// Trainee Model
class TraineeModel {
  final String traineeId;
  final String fullName;
  final String? email;
  final String? phoneNumber;
  final double? currentWeight;
  final String? lastWorkout;
  final int totalWorkouts;
  final String? profileImage;

  TraineeModel({
    required this.traineeId,
    required this.fullName,
    this.email,
    this.phoneNumber,
    this.currentWeight,
    this.lastWorkout,
    required this.totalWorkouts,
    this.profileImage,
  });

  factory TraineeModel.fromJson(Map<String, dynamic> json) {
    return TraineeModel(
      traineeId: json['traineeId'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      currentWeight: json['currentWeight'] != null
          ? (json['currentWeight'] as num).toDouble()
          : null,
      lastWorkout: json['lastWorkout'],
      totalWorkouts: json['totalWorkouts'] ?? 0,
      profileImage: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'traineeId': traineeId,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'currentWeight': currentWeight,
      'lastWorkout': lastWorkout,
      'totalWorkouts': totalWorkouts,
      'profileImage': profileImage,
    };
  }
}
