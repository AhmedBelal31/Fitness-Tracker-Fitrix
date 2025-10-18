class ApiEndpoints {
  static const String apiBaseUrl = "https://gymassistantapi.runasp.net/api/";

  static const String login = "Auth/login";
  static const String register = "Auth/register";
  static const String forgotPassword = "Auth/forgot-password";

  static const String completeProfile = "Users/create-profile";
  static const String currentUser = "currentUser";
  static const String logout = "logout";
  static const String refreshToken = "Auth/refresh-token";

  // Profile
  static const String getProfile = "Users/get-profile";
  static const String updateProfile = 'Users/update-profile';

  // Home/Dashboard
  static const String dashboard = '/api/dashboard';
  static const String userStats = '/api/dashboard/stats';

  // Measurements
  static const String measurements = '/api/measurements';
  static const String addMeasurement = '/api/measurements/add';
  static const String latestMeasurement = '/api/measurements/latest';

  // Workouts
  static const String workouts = '/api/workout';
  static const String recentWorkouts = '/api/workout/recent';
  static const String createWorkout = '/api/workout/create';
  static String workoutDetails(String workoutId) => '/api/workout/$workoutId';
  static String deleteWorkout(String workoutId) => '/api/workout/$workoutId';

  // Personal Records
  static const String personalRecords = '/api/personal-records';
  static const String personalRecordsSummary = '/api/personal-records/summary';
  static String addPersonalRecord = '/api/personal-records/add';

  // Trainer
  static const String trainees = '/api/trainer/trainees';
  static String traineeDashboard(String traineeId) =>
      '/api/trainer/trainees/$traineeId/dashboard';
  static String traineeDetails(String traineeId) =>
      '/api/trainer/trainees/$traineeId';
  static const String addTrainee = '/api/trainer/trainees/add';
  static String removeTrainee(String traineeId) =>
      '/api/trainer/trainees/$traineeId';

  // Exercise Endpoints
  static const String getSections = '/Exercises/get-sections';
  static const String getExercisesBySection = '/Exercises/exercises-by-section';
  static const String getExerciseById = '/Exercises/get-exercise-by-id';
  static const String createCustomExercise =
      '/Exercises/create-custom-exercise';
  static const String updateCustomExercise =
      '/Exercises/update-custom-exercise';
  static const String deleteCustomExercise =
      '/Exercises/delete-custom-exercise';
  static const String getCustomExercises = '/Exercises/get-custom-exercises';
  static const String createSectionGroup = '/Exercises/create-section';
  static const String getAllSectionGroups = '/Exercises/all-section-groups';
  static const String addExerciseToSectionGroup =
      '/Exercises/add-exercise-to-section-group';

  static const String createWorkoutSession = '/Workouts/create-session';
  static const String getWorkoutHistory = '/Workouts/get-workout-history';
  static const String getWorkoutSession = '/Workouts/get-session';
  static const String addExerciseToWorkout = '/Workouts/add-exercise-Workout';
  static const String startWorkoutSession = '/Workouts/start-Workout-session';
  static const String completeWorkoutSession =
      'Workouts/complete-workout-session';
  static const String addSetToExercise = '/Workouts/add-set-to-exercise';
  static const String updateExerciseSet = '/Workouts/update-exercise-set';
  static const String getExerciseSet = '/Workouts/exercise-set';

  static const String getCustomExercise = '/Exercises/get-custom-exercise';

  static const String measurementCards = 'Users/measurement-cards';
  static const String measurementCharts = 'Users/get-measurement-charts';
  static const String recordsStates = 'Records/states';

  static const String recordsAchievements = '/Records/achievements';
}
