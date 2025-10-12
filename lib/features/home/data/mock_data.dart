import 'package:fitrix/features/home/data/trainee_model.dart';
import 'package:fitrix/features/home/data/workout_stats_model.dart';

import 'body_progress_model.dart';
import 'dashboard_model.dart';

class MockData {
  // Mock User Dashboard
  static DashboardModel getMockUserDashboard() {
    return DashboardModel(
      userId: 'user123',
      fullName: 'Abdo Shady',
      role: 'User',
      bodyProgress: BodyProgressModel(
        currentWeight: 75.5,
        startWeight: 80.0,
        weightChange: -4.5,
        currentBodyFat: 18.5,
        startBodyFat: 22.0,
        bodyFatChange: -3.5,
        muscleMassChange: 2.0,
      ),
      workoutStats: WorkoutStatsModel(
        totalWorkouts: 48,
        thisMonth: 12,
        lastMonth: 10,
        averageDuration: 45,
        completionRate: 85,
        mostFrequentExercises: ['Bench Press', 'Squats', 'Deadlift'],
      ),
      personalRecords: [
        PersonalRecordModel(
          id: '1',
          exerciseName: 'Bench Press',
          recordType: 'Max Weight',
          value: 100.0,
          achievedDate: '2025-09-15',
        ),
        PersonalRecordModel(
          id: '2',
          exerciseName: 'Squat',
          recordType: 'Max Weight',
          value: 140.0,
          achievedDate: '2025-09-20',
        ),
        PersonalRecordModel(
          id: '3',
          exerciseName: 'Deadlift',
          recordType: 'Max Weight',
          value: 160.0,
          achievedDate: '2025-09-25',
        ),
      ],
      recentWorkouts: [
        RecentWorkoutModel(
          id: '1',
          date: '2025-10-07',
          duration: 50,
          exercises: ['Bench Press', 'Incline Press', 'Cable Flyes'],
          totalSets: 12,
          isCompleted: true,
        ),
        RecentWorkoutModel(
          id: '2',
          date: '2025-10-05',
          duration: 45,
          exercises: ['Squats', 'Leg Press', 'Leg Curls', 'Calf Raises'],
          totalSets: 15,
          isCompleted: true,
        ),
        RecentWorkoutModel(
          id: '3',
          date: '2025-10-03',
          duration: 40,
          exercises: ['Deadlift', 'Rows', 'Pull-ups'],
          totalSets: 10,
          isCompleted: false,
        ),
      ],
    );
  }

  // Mock Trainees List
  static List<TraineeModel> getMockTrainees() {
    return [
      TraineeModel(
        traineeId: 'trainee1',
        fullName: 'Kakashiii',
        email: 'Kakashiii@example.com',
        phoneNumber: '+201234567890',
        currentWeight: 82.5,
        lastWorkout: '2025-10-06',
        totalWorkouts: 24,
        profileImage: null,
      ),
      TraineeModel(
        traineeId: 'trainee2',
        fullName: 'Sara Ahmed',
        email: 'sara@example.com',
        phoneNumber: '+201234567891',
        currentWeight: 65.0,
        lastWorkout: '2025-10-07',
        totalWorkouts: 18,
        profileImage: null,
      ),
      TraineeModel(
        traineeId: 'trainee3',
        fullName: 'Khaled Ibrahim',
        email: 'khaled@example.com',
        phoneNumber: '+201234567892',
        currentWeight: 90.0,
        lastWorkout: '2025-10-05',
        totalWorkouts: 32,
        profileImage: null,
      ),
      TraineeModel(
        traineeId: 'trainee4',
        fullName: 'Fatima Hassan',
        email: 'fatima@example.com',
        phoneNumber: '+201234567893',
        currentWeight: 58.5,
        lastWorkout: '2025-10-08',
        totalWorkouts: 15,
        profileImage: null,
      ),
    ];
  }

  // Mock Trainer Dashboard
  static DashboardModel getMockTrainerDashboard() {
    return DashboardModel(
      userId: 'trainer123',
      fullName: 'Coach Ahmed',
      role: 'Trainer',
      bodyProgress: null,
      workoutStats: null,
      personalRecords: null,
      recentWorkouts: null,
    );
  }
}
