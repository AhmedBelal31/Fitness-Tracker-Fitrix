class ApiEndpoints {
  static const String apiBaseUrl = "https://gymassistantapi.runasp.net/api/";

  static const String login = "Auth/login";
  static const String register = "Auth/register";
  static const String forgotPassword = "Auth/forgot-password";

  static const String getProfile = "Users/get-profile";
  static const String completeProfile = "Users/create-profile";
  static const String currentUser = "currentUser";
  static const String logout = "logout";
  static const String refreshToken = "Auth/refresh-token";

  // Profile
  static const String profile = '/api/profile';
  static const String updateProfile = '/api/profile/update';

  // Home/Dashboard
  static const String dashboard = '/api/dashboard';
  static const String userStats = '/api/dashboard/stats';

  // Measurements
  static const String measurements = '/api/measurements';
  static const String addMeasurement = '/api/measurements/add';
  static const String latestMeasurement = '/api/measurements/latest';

  // Workouts
  static const String workouts = '/api/workouts';
  static const String recentWorkouts = '/api/workouts/recent';
  static const String createWorkout = '/api/workouts/create';
  static String workoutDetails(String workoutId) => '/api/workouts/$workoutId';
  static String deleteWorkout(String workoutId) => '/api/workouts/$workoutId';

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

  // Exercises
  static const String exercises = '/api/exercises';
  static String exerciseDetails(String exerciseId) =>
      '/api/exercises/$exerciseId';
  static const String exerciseCategories = '/api/exercises/categories';
}
