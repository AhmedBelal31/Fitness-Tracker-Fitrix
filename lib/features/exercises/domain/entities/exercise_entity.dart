// class ExerciseEntity {
//   final String id;
//   final String sectionId;
//   final String name;
//   final String? description;
//   final String? instructions;
//   final String? equipment;
//   final String? imageUrl;
//   final String? difficultyLevel;
//   final int? defaultSets;
//   final int? defaultReps;
//   final String? createdAtUtc;
//   final bool isCustomExercise;
//
//   ExerciseEntity({
//     required this.id,
//     required this.sectionId,
//     required this.name,
//     this.description,
//     this.instructions,
//     this.equipment,
//     this.imageUrl,
//     this.difficultyLevel,
//     this.defaultSets,
//     this.defaultReps,
//     this.createdAtUtc,
//     required this.isCustomExercise,
//   });
// }
class ExerciseEntity {
  final String id;
  final String sectionId;
  final String name;
  final String sectionName;
  final String? description;
  final String? instructions;
  final String? equipment;
  final String? imageUrl;
  final String? difficultyLevel;
  final int? defaultSets;
  final int? defaultReps;
  final String? createdAtUtc;
  final bool isCustomExercise;

  ExerciseEntity({
    required this.id,
    required this.sectionId,
    required this.name,
    required this.sectionName,
    this.description,
    this.instructions,
    this.equipment,
    this.imageUrl,
    this.difficultyLevel,
    this.defaultSets,
    this.defaultReps,
    this.createdAtUtc,
    required this.isCustomExercise,
  });
}
