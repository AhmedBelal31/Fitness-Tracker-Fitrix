class ApiEndpoints {
  static const String apiBaseUrl = "https://gymassistantapi.runasp.net/api/";

  static const String login = "Auth/login";
  static const String register = "Auth/register";
  static const String forgotPassword = "Auth/forgot-password";
  static const String changePassword = '/Auth/change-password';

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

  // Workouts
  static const String workouts = '/api/workout';
  static const String recentWorkouts = '/api/workout/recent';
  static const String createWorkout = '/api/workout/create';
  static String workoutDetails(String workoutId) => '/api/workout/$workoutId';
  static String deleteWorkout(String workoutId) => '/api/workout/$workoutId';

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
  static String exerciseProgressCharts(String exerciseId) =>
      '/Progress/charts/exercise/$exerciseId';
  static const String recordsAchievements = '/Records/achievements';

  // ✅ User Requests Endpoints (Complete)
  static const String sendUserRequest = '/UserRequest/send';
  static const String sentUserRequests = '/UserRequest/sent';
  static const String receivedUserRequests = '/UserRequest/received';
  static const String allTrainers = '/UserRequest/all-trainers';

  static String cancelUserRequest(String requestId) =>
      '/UserRequest/cancel/$requestId';
  static String acceptUserRequest(String requestId) =>
      'UserRequest/accept/$requestId';
  static String rejectUserRequest(String requestId) =>
      '/UserRequest/reject/$requestId';
  static String getUserRequestById(String requestId) =>
      '/UserRequest/$requestId';

  // Trainer Request endpoints
  static const String receivedTrainerRequests = '/TrainerRequest/received';
  static String acceptTrainerRequest(String id) => '/TrainerRequest/accept/$id';
  static String rejectTrainerRequest(String id) => '/TrainerRequest/reject/$id';
  static const String allUsers = '/TrainerRequest/all-users';

  static const String sendTrainerRequest = '/TrainerRequest/send';

  ///Works
  ///Works
  ///Works
  ///
  ///
  // Trainer Request endpoints
  static const String trainerRequestReceived = '/api/TrainerRequest/received';
  static const String trainerRequestSent = '/api/TrainerRequest/sent';
  static const String trainerRequestAllUsers = '/api/TrainerRequest/all-users';

  static String acceptRequest(String requestId) =>
      '/api/TrainerRequest/accept/$requestId';
  static String rejectRequest(String requestId) =>
      '/api/TrainerRequest/reject/$requestId';
  static String cancelRequest(String requestId) =>
      '/api/TrainerRequest/cancel/$requestId';

  static const String createWorkoutForTrainee = '/Trainer/trainees';
  static const String chatConversations = '/ChatV2/conversations';
  static const String chatUnreadCount = '/ChatV2/unread-count';
}
