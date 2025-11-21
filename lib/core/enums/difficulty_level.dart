enum DifficultyLevel {
  beginner,
  intermediate,
  advanced;

  String get displayName {
    switch (this) {
      case DifficultyLevel.beginner:
        return 'Beginner';
      case DifficultyLevel.intermediate:
        return 'Intermediate';
      case DifficultyLevel.advanced:
        return 'Advanced';
    }
  }

  static DifficultyLevel? fromString(String? value) {
    if (value == null) return null;
    return DifficultyLevel.values.firstWhere(
      (e) => e.displayName.toLowerCase() == value.toLowerCase(),
      orElse: () => DifficultyLevel.beginner,
    );
  }
}
