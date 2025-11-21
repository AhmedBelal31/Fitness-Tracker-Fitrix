import '../../domain/entities/section_group_entity.dart';

class SectionGroupModel extends SectionGroupEntity {
  SectionGroupModel({
    required super.id,
    required super.sectionId,
    required super.name,
    super.description,
    super.exercises,
    super.customExercises,
    super.createdAtUtc,
  });

  factory SectionGroupModel.fromJson(Map<String, dynamic> json) {
    return SectionGroupModel(
      id: json['id'] ?? '',
      sectionId: json['sectionId'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      exercises: json['exercise'],
      customExercises: json['customExercise'],
      createdAtUtc: json['createdAtUtc'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sectionId': sectionId,
      'name': name,
      'description': description,
      'exercise': exercises,
      'customExercise': customExercises,
      'createdAtUtc': createdAtUtc,
    };
  }
}
