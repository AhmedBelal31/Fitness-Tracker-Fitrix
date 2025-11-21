// class SectionModel {
//   final String id;
//   final String name;
//   final String description;
//   final String iconName;
//   final int exerciseCount;
//
//   SectionModel({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.iconName,
//     required this.exerciseCount,
//   });
//
//   factory SectionModel.fromJson(Map<String, dynamic> json) {
//     return SectionModel(
//       id: json['id'] ?? '',
//       name: json['name'] ?? '',
//       description: json['description'] ?? '',
//       iconName: json['iconName'] ?? '',
//       exerciseCount: json['exerciseCount'] ?? 0,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'description': description,
//       'iconName': iconName,
//       'exerciseCount': exerciseCount,
//     };
//   }
// }
import '../../domain/entities/section_entity.dart';

class SectionModel extends SectionEntity {
  SectionModel({
    required super.id,
    required super.name,
    super.description,
    super.sectionGroup,
    super.createdAtUtc,
    required super.exerciseNumber,
    required super.customExerciseNumber,
    required super.allExerciseNumber,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      sectionGroup: json['sectionGroup'],
      createdAtUtc: json['createdAtUtc'],
      exerciseNumber: json['exerciseNumber'] ?? 0,
      customExerciseNumber: json['customExerciseNumber'] ?? 0,
      allExerciseNumber: json['allExerciseNumber'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'sectionGroup': sectionGroup,
      'createdAtUtc': createdAtUtc,
      'exerciseNumber': exerciseNumber,
      'customExerciseNumber': customExerciseNumber,
      'allExerciseNumber': allExerciseNumber,
    };
  }
}
