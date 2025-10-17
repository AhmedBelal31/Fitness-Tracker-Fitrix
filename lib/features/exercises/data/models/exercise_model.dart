import '../../../../core/helpers/image_url_helper.dart';
import '../../domain/entities/exercise_entity.dart';
import '../../domain/entities/exercise_entity.dart';

// class ExerciseModel extends ExerciseEntity {
//   ExerciseModel({
//     required super.id,
//     required super.sectionId,
//     required super.name,
//     super.description,
//     super.instructions,
//     super.equipment,
//     super.imageUrl,
//     super.difficultyLevel,
//     super.defaultSets,
//     super.defaultReps,
//     super.createdAtUtc,
//     required super.isCustomExercise,
//   });
//
//   factory ExerciseModel.fromJson(Map<String, dynamic> json) {
//     return ExerciseModel(
//       id: json['id'] ?? '',
//       sectionId: json['sectionId'] ?? '',
//       name: json['name'] ?? '',
//       description: json['description'],
//       instructions: json['instructions'],
//       equipment: json['equipment'],
//       // ✅ Use helper to get full image URL
//       imageUrl: ImageUrlHelper.getFullImageUrl(json['imageUrl']),
//       difficultyLevel: _convertDifficultyLevel(json['difficultyLevel']),
//       defaultSets: json['defaultSets'],
//       defaultReps: json['defaultReps'],
//       createdAtUtc: json['createdAtUtc'],
//       isCustomExercise: json['isCustomExercise'] ?? false,
//     );
//   }
//
//   static String? _convertDifficultyLevel(dynamic difficultyLevel) {
//     if (difficultyLevel == null) return null;
//
//     if (difficultyLevel is String) {
//       return difficultyLevel;
//     }
//
//     if (difficultyLevel is int) {
//       switch (difficultyLevel) {
//         case 1:
//           return 'Beginner';
//         case 2:
//           return 'Intermediate';
//         case 3:
//           return 'Advanced';
//         default:
//           return null;
//       }
//     }
//
//     return null;
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'sectionId': sectionId,
//       'name': name,
//       'description': description,
//       'instructions': instructions,
//       'equipment': equipment,
//       'imageUrl': imageUrl,
//       'difficultyLevel': difficultyLevel,
//       'defaultSets': defaultSets,
//       'defaultReps': defaultReps,
//       'createdAtUtc': createdAtUtc,
//       'isCustomExercise': isCustomExercise,
//     };
//   }
// }
class ExerciseModel extends ExerciseEntity {
  ExerciseModel({
    required super.id,
    required super.sectionId,
    required super.name,
    super.description,
    super.instructions,
    super.equipment,
    super.imageUrl,
    super.difficultyLevel,
    super.defaultSets,
    super.defaultReps,
    super.createdAtUtc,
    required super.isCustomExercise,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      id: json['id'] ?? '',
      sectionId: json['sectionId'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      instructions: json['instructions'],
      equipment: json['equipment'],
      imageUrl: ImageUrlHelper.getFullImageUrl(json['imageUrl']),
      difficultyLevel: _convertDifficultyLevel(json['difficultyLevel']),
      defaultSets: json['defaultSets'],
      defaultReps: json['defaultReps'],
      createdAtUtc: json['createdAtUtc'],
      isCustomExercise: json['isCustomExercise'] ?? false,
    );
  }

  static String? _convertDifficultyLevel(dynamic difficultyLevel) {
    if (difficultyLevel == null) return null;
    if (difficultyLevel is String) return difficultyLevel;
    if (difficultyLevel is int) {
      return switch (difficultyLevel) {
        1 => 'Beginner',
        2 => 'Intermediate',
        3 => 'Advanced',
        _ => null,
      };
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sectionId': sectionId,
      'name': name,
      'description': description,
      'instructions': instructions,
      'equipment': equipment,
      'imageUrl': imageUrl,
      'difficultyLevel': difficultyLevel,
      'defaultSets': defaultSets,
      'defaultReps': defaultReps,
      'createdAtUtc': createdAtUtc,
      'isCustomExercise': isCustomExercise,
    };
  }
}
