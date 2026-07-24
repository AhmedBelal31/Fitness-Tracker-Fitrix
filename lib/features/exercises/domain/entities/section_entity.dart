class SectionEntity {
  final String id;
  final String name;
  final String? description;
  final dynamic sectionGroup;
  final String? createdAtUtc;
  final int exerciseNumber;
  final int customExerciseNumber;
  final int allExerciseNumber;

  SectionEntity({
    required this.id,
    required this.name,
    this.description,
    this.sectionGroup,
    this.createdAtUtc,
    required this.exerciseNumber,
    required this.customExerciseNumber,
    required this.allExerciseNumber,
  });
}
