import 'dart:io';

class CreateCustomExerciseRequest {
  final String sectionId;
  final String name;
  final String? description;
  final String? instructions;
  final String? equipment;
  final String? difficultyLevel;
  final File? imageFile;

  CreateCustomExerciseRequest({
    required this.sectionId,
    required this.name,
    this.description,
    this.instructions,
    this.equipment,
    this.difficultyLevel,
    this.imageFile,
  });
}

class UpdateCustomExerciseRequest {
  final String? name;
  final String? description;
  final String? instructions;
  final String? equipment;
  final String? difficultyLevel;
  final File? imageFile;

  UpdateCustomExerciseRequest({
    this.name,
    this.description,
    this.instructions,
    this.equipment,
    this.difficultyLevel,
    this.imageFile,
  });
}
