class ProfileResponse {
  final String? userId;
  final double? weight;
  final double? height;
  final int? age;
  final String? gender;
  final String? fitnessGoal;
  final String? experienceLevel;
  final int? personalRecordsCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProfileResponse({
    this.userId,
    this.weight,
    this.height,
    this.age,
    this.gender,
    this.fitnessGoal,
    this.experienceLevel,
    this.personalRecordsCount,
    this.createdAt,
    this.updatedAt,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
        userId: json['userId'],
        weight: json['weight']?.toDouble(),
        height: json['height']?.toDouble(),
        age: json['age'],
        gender: json['gender'],
        fitnessGoal: json['fitnessGoal'],
        experienceLevel: json['experienceLevel'],
        personalRecordsCount: json['personalRecordsCount'],
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : null,
      );

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'weight': weight,
    'height': height,
    'age': age,
    'gender': gender,
    'fitnessGoal': fitnessGoal,
    'experienceLevel': experienceLevel,
    'personalRecordsCount': personalRecordsCount,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };
}
