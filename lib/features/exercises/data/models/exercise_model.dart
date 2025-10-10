class ExerciseModel {
  final String id;
  final String name;
  final String description;
  final String sectionId;
  final String sectionName;
  final String? imageUrl;
  final String? videoUrl;
  final bool isCustom;
  final String? createdBy;
  final List<String> muscleGroups;
  final String difficulty;
  final String equipment;

  ExerciseModel({
    required this.id,
    required this.name,
    required this.description,
    required this.sectionId,
    required this.sectionName,
    this.imageUrl,
    this.videoUrl,
    this.isCustom = false,
    this.createdBy,
    this.muscleGroups = const [],
    this.difficulty = 'Intermediate',
    this.equipment = 'Dumbbells',
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      sectionId: json['sectionId'] ?? '',
      sectionName: json['sectionName'] ?? '',
      imageUrl: json['imageUrl'],
      videoUrl: json['videoUrl'],
      isCustom: json['isCustom'] ?? false,
      createdBy: json['createdBy'],
      muscleGroups: json['muscleGroups'] != null
          ? List<String>.from(json['muscleGroups'])
          : [],
      difficulty: json['difficulty'] ?? 'Intermediate',
      equipment: json['equipment'] ?? 'Dumbbells',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'sectionId': sectionId,
      'sectionName': sectionName,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'isCustom': isCustom,
      'createdBy': createdBy,
      'muscleGroups': muscleGroups,
      'difficulty': difficulty,
      'equipment': equipment,
    };
  }
}
