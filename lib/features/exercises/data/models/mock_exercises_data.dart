import '../models/section_model.dart';
import '../models/exercise_model.dart';

class MockExercisesData {
  // Mock Sections
  static List<SectionModel> getMockSections() {
    return [
      SectionModel(
        id: '1',
        name: 'Chest',
        description: 'Chest exercises for upper body strength',
        iconName: 'fitness_center',
        exerciseCount: 12,
      ),
      SectionModel(
        id: '2',
        name: 'Back',
        description: 'Build a strong and wide back',
        iconName: 'accessibility_new',
        exerciseCount: 15,
      ),
      SectionModel(
        id: '3',
        name: 'Legs',
        description: 'Leg day for lower body power',
        iconName: 'directions_run',
        exerciseCount: 18,
      ),
      SectionModel(
        id: '4',
        name: 'Shoulders',
        description: 'Shoulder exercises for definition',
        iconName: 'sports_martial_arts',
        exerciseCount: 10,
      ),
      SectionModel(
        id: '5',
        name: 'Arms',
        description: 'Biceps and triceps exercises',
        iconName: 'sports_gymnastics',
        exerciseCount: 14,
      ),
      SectionModel(
        id: '6',
        name: 'Core',
        description: 'Strengthen your core and abs',
        iconName: 'self_improvement',
        exerciseCount: 16,
      ),
    ];
  }

  // Mock Exercises by Section
  static List<ExerciseModel> getExercisesBySection(String sectionId) {
    switch (sectionId) {
      case '1': // Chest
        return [
          ExerciseModel(
            id: 'ex1',
            name: 'Bench Press',
            description:
                'Classic compound exercise for chest development. Lie on bench and press barbell up.',
            sectionId: '1',
            sectionName: 'Chest',
            muscleGroups: ['Chest', 'Triceps', 'Shoulders'],
            difficulty: 'Intermediate',
            equipment: 'Barbell',
          ),
          ExerciseModel(
            id: 'ex2',
            name: 'Incline Dumbbell Press',
            description:
                'Target upper chest with incline angle. Press dumbbells upward from incline bench.',
            sectionId: '1',
            sectionName: 'Chest',
            muscleGroups: ['Upper Chest', 'Shoulders'],
            difficulty: 'Intermediate',
            equipment: 'Dumbbells',
          ),
          ExerciseModel(
            id: 'ex3',
            name: 'Cable Flyes',
            description:
                'Isolation exercise for chest. Use cables to bring hands together in front.',
            sectionId: '1',
            sectionName: 'Chest',
            muscleGroups: ['Chest'],
            difficulty: 'Beginner',
            equipment: 'Cable Machine',
          ),
          ExerciseModel(
            id: 'ex4',
            name: 'Push-ups',
            description:
                'Bodyweight chest exercise. Lower body to ground and push back up.',
            sectionId: '1',
            sectionName: 'Chest',
            muscleGroups: ['Chest', 'Core', 'Triceps'],
            difficulty: 'Beginner',
            equipment: 'Bodyweight',
          ),
          ExerciseModel(
            id: 'ex5',
            name: 'Dumbbell Flyes',
            description:
                'Stretch chest muscles with dumbbell flyes on flat bench.',
            sectionId: '1',
            sectionName: 'Chest',
            muscleGroups: ['Chest'],
            difficulty: 'Intermediate',
            equipment: 'Dumbbells',
          ),
        ];

      case '2': // Back
        return [
          ExerciseModel(
            id: 'ex6',
            name: 'Deadlift',
            description:
                'King of back exercises. Lift barbell from ground to standing position.',
            sectionId: '2',
            sectionName: 'Back',
            muscleGroups: ['Lower Back', 'Glutes', 'Hamstrings'],
            difficulty: 'Advanced',
            equipment: 'Barbell',
          ),
          ExerciseModel(
            id: 'ex7',
            name: 'Pull-ups',
            description:
                'Bodyweight exercise for lat development. Pull yourself up to bar.',
            sectionId: '2',
            sectionName: 'Back',
            muscleGroups: ['Lats', 'Biceps'],
            difficulty: 'Intermediate',
            equipment: 'Pull-up Bar',
          ),
          ExerciseModel(
            id: 'ex8',
            name: 'Barbell Rows',
            description:
                'Build thick back with bent-over rows. Pull barbell to lower chest.',
            sectionId: '2',
            sectionName: 'Back',
            muscleGroups: ['Back', 'Biceps'],
            difficulty: 'Intermediate',
            equipment: 'Barbell',
          ),
          ExerciseModel(
            id: 'ex9',
            name: 'Lat Pulldown',
            description:
                'Cable exercise for lats. Pull bar down to upper chest.',
            sectionId: '2',
            sectionName: 'Back',
            muscleGroups: ['Lats', 'Biceps'],
            difficulty: 'Beginner',
            equipment: 'Cable Machine',
          ),
        ];

      case '3': // Legs
        return [
          ExerciseModel(
            id: 'ex10',
            name: 'Squats',
            description:
                'King of leg exercises. Lower body with barbell on shoulders.',
            sectionId: '3',
            sectionName: 'Legs',
            muscleGroups: ['Quads', 'Glutes', 'Hamstrings'],
            difficulty: 'Intermediate',
            equipment: 'Barbell',
          ),
          ExerciseModel(
            id: 'ex11',
            name: 'Leg Press',
            description: 'Push weight up with legs on leg press machine.',
            sectionId: '3',
            sectionName: 'Legs',
            muscleGroups: ['Quads', 'Glutes'],
            difficulty: 'Beginner',
            equipment: 'Machine',
          ),
          ExerciseModel(
            id: 'ex12',
            name: 'Romanian Deadlift',
            description: 'Target hamstrings with straight-leg deadlift motion.',
            sectionId: '3',
            sectionName: 'Legs',
            muscleGroups: ['Hamstrings', 'Glutes'],
            difficulty: 'Intermediate',
            equipment: 'Barbell',
          ),
          ExerciseModel(
            id: 'ex13',
            name: 'Leg Curls',
            description: 'Isolate hamstrings with leg curl machine.',
            sectionId: '3',
            sectionName: 'Legs',
            muscleGroups: ['Hamstrings'],
            difficulty: 'Beginner',
            equipment: 'Machine',
          ),
          ExerciseModel(
            id: 'ex14',
            name: 'Calf Raises',
            description: 'Build calf muscles by raising heels.',
            sectionId: '3',
            sectionName: 'Legs',
            muscleGroups: ['Calves'],
            difficulty: 'Beginner',
            equipment: 'Bodyweight',
          ),
        ];

      case '4': // Shoulders
        return [
          ExerciseModel(
            id: 'ex15',
            name: 'Overhead Press',
            description: 'Press barbell overhead for shoulder development.',
            sectionId: '4',
            sectionName: 'Shoulders',
            muscleGroups: ['Shoulders', 'Triceps'],
            difficulty: 'Intermediate',
            equipment: 'Barbell',
          ),
          ExerciseModel(
            id: 'ex16',
            name: 'Lateral Raises',
            description: 'Raise dumbbells to sides for shoulder width.',
            sectionId: '4',
            sectionName: 'Shoulders',
            muscleGroups: ['Side Delts'],
            difficulty: 'Beginner',
            equipment: 'Dumbbells',
          ),
          ExerciseModel(
            id: 'ex17',
            name: 'Front Raises',
            description: 'Raise dumbbells in front for front deltoid focus.',
            sectionId: '4',
            sectionName: 'Shoulders',
            muscleGroups: ['Front Delts'],
            difficulty: 'Beginner',
            equipment: 'Dumbbells',
          ),
        ];

      case '5': // Arms
        return [
          ExerciseModel(
            id: 'ex18',
            name: 'Barbell Curls',
            description: 'Classic bicep exercise with barbell.',
            sectionId: '5',
            sectionName: 'Arms',
            muscleGroups: ['Biceps'],
            difficulty: 'Beginner',
            equipment: 'Barbell',
          ),
          ExerciseModel(
            id: 'ex19',
            name: 'Tricep Dips',
            description: 'Bodyweight exercise for triceps.',
            sectionId: '5',
            sectionName: 'Arms',
            muscleGroups: ['Triceps'],
            difficulty: 'Intermediate',
            equipment: 'Bodyweight',
          ),
          ExerciseModel(
            id: 'ex20',
            name: 'Hammer Curls',
            description: 'Curl dumbbells with neutral grip for brachialis.',
            sectionId: '5',
            sectionName: 'Arms',
            muscleGroups: ['Biceps', 'Forearms'],
            difficulty: 'Beginner',
            equipment: 'Dumbbells',
          ),
          ExerciseModel(
            id: 'ex21',
            name: 'Overhead Tricep Extension',
            description: 'Extend dumbbell overhead for tricep isolation.',
            sectionId: '5',
            sectionName: 'Arms',
            muscleGroups: ['Triceps'],
            difficulty: 'Beginner',
            equipment: 'Dumbbell',
          ),
        ];

      case '6': // Core
        return [
          ExerciseModel(
            id: 'ex22',
            name: 'Planks',
            description: 'Hold body in plank position for core strength.',
            sectionId: '6',
            sectionName: 'Core',
            muscleGroups: ['Abs', 'Core'],
            difficulty: 'Beginner',
            equipment: 'Bodyweight',
          ),
          ExerciseModel(
            id: 'ex23',
            name: 'Crunches',
            description: 'Classic ab exercise. Curl upper body towards knees.',
            sectionId: '6',
            sectionName: 'Core',
            muscleGroups: ['Abs'],
            difficulty: 'Beginner',
            equipment: 'Bodyweight',
          ),
          ExerciseModel(
            id: 'ex24',
            name: 'Russian Twists',
            description: 'Rotate torso side to side for obliques.',
            sectionId: '6',
            sectionName: 'Core',
            muscleGroups: ['Obliques'],
            difficulty: 'Intermediate',
            equipment: 'Bodyweight',
          ),
          ExerciseModel(
            id: 'ex25',
            name: 'Leg Raises',
            description: 'Raise legs for lower ab development.',
            sectionId: '6',
            sectionName: 'Core',
            muscleGroups: ['Lower Abs'],
            difficulty: 'Intermediate',
            equipment: 'Bodyweight',
          ),
        ];

      default:
        return [];
    }
  }

  // Mock Custom Exercises
  static List<ExerciseModel> getMockCustomExercises() {
    return [
      ExerciseModel(
        id: 'custom1',
        name: 'My Custom Chest Press',
        description: 'Custom variation of chest press',
        sectionId: '1',
        sectionName: 'Chest',
        isCustom: true,
        createdBy: 'user123',
        muscleGroups: ['Chest'],
        difficulty: 'Intermediate',
        equipment: 'Dumbbells',
      ),
      ExerciseModel(
        id: 'custom2',
        name: 'Cable Pull Variation',
        description: 'My own cable pulling exercise',
        sectionId: '2',
        sectionName: 'Back',
        isCustom: true,
        createdBy: 'user123',
        muscleGroups: ['Back', 'Biceps'],
        difficulty: 'Advanced',
        equipment: 'Cable Machine',
      ),
    ];
  }
}
