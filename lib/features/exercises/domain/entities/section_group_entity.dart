class SectionGroupEntity {
  final String id;
  final String sectionId;
  final String name;
  final String? description;
  final List<dynamic>? exercises;
  final List<dynamic>? customExercises;
  final String? createdAtUtc;

  SectionGroupEntity({
    required this.id,
    required this.sectionId,
    required this.name,
    this.description,
    this.exercises,
    this.customExercises,
    this.createdAtUtc,
  });
}
