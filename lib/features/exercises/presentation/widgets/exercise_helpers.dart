import '../../../../../generated/l10n.dart';
import '../../data/models/exercise_model.dart';

class ExerciseHelpers {
  static String getSectionDescription(S s, String sectionName) {
    switch (sectionName.toLowerCase()) {
      case 'chest':
        return s.chest_description;
      case 'back':
        return s.back_description;
      case 'legs':
        return s.legs_description;
      case 'shoulders':
        return s.shoulders_description;
      case 'arms':
        return s.arms_description;
      case 'core':
        return s.core_description;
      default:
        return '';
    }
  }

  static Map<String, List<ExerciseModel>> separateExercises(
    List<ExerciseModel> exercises,
    String sortBy,
  ) {
    final customExercises = <ExerciseModel>[];
    final publicExercises = <ExerciseModel>[];

    for (var exercise in exercises) {
      if (exercise.isCustomExercise) {
        customExercises.add(exercise);
      } else {
        publicExercises.add(exercise);
      }
    }

    return {
      'custom': _sortExercisesList(customExercises, sortBy),
      'public': _sortExercisesList(publicExercises, sortBy),
    };
  }

  static List<ExerciseModel> _sortExercisesList(
    List<ExerciseModel> exercises,
    String sortBy,
  ) {
    final sortedList = List<ExerciseModel>.from(exercises);

    switch (sortBy) {
      case 'name':
        sortedList.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'difficulty':
        sortedList.sort((a, b) {
          final difficultyOrder = {
            'Beginner': 1,
            'Intermediate': 2,
            'Advanced': 3,
          };
          return (difficultyOrder[a.difficultyLevel] ?? 0).compareTo(
            difficultyOrder[b.difficultyLevel] ?? 0,
          );
        });
        break;
    }

    return sortedList;
  }
}
