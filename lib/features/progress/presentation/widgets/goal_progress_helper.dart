class GoalProgressHelper {
  /// Calculate progress percentage from start to goal
  /// Returns value between 0-100, handles edge cases
  static double calculateProgress({
    required double startValue,
    required double currentValue,
    required double goalValue,
    required bool isPositiveGood,
  }) {
    if (isPositiveGood) {
      // Muscle gain: progress increases with value
      final totalDistance = goalValue - startValue;
      final progressMade = currentValue - startValue;

      // Edge case: goal is lower than start (bad data)
      if (totalDistance <= 0) return 0;

      final percentage = (progressMade / totalDistance) * 100;

      // Return 0 if going in wrong direction (losing muscle instead of gaining)
      if (percentage < 0) return 0;

      return percentage.clamp(0, 100);
    } else {
      // Weight/Fat loss: progress increases as value decreases
      final totalDistance = startValue - goalValue;
      final progressMade = startValue - currentValue;

      // Edge case: goal is higher than start (bad data)
      if (totalDistance <= 0) return 0;

      final percentage = (progressMade / totalDistance) * 100;

      // Return 0 if going in wrong direction (gaining weight/fat instead of losing)
      if (percentage < 0) return 0;

      return percentage.clamp(0, 100);
    }
  }

  /// Check if user should be celebrated (10% milestone or more)
  /// ✅ Lowered threshold from 50% to 10% to show more celebrations
  static bool shouldCelebrate(double progressPercent, {double threshold = 10}) {
    return progressPercent >= threshold && progressPercent < 100;
  }

  /// Check if goal is reached
  static bool isGoalReached(double progressPercent) {
    return progressPercent >= 100;
  }

  /// Get milestone message based on actual progress
  static String getMilestoneMessage(double progressPercent) {
    if (progressPercent >= 100) {
      return '🎉 Goal Achieved! Amazing work!';
    } else if (progressPercent >= 75) {
      return '🔥 Almost there! Keep pushing!';
    } else if (progressPercent >= 50) {
      return '💪 Halfway there! You\'re doing great!';
    } else if (progressPercent >= 25) {
      return '⭐ Great progress! Keep it up!';
    } else if (progressPercent >= 10) {
      return '✨ Nice start! You\'re on the right track!';
    } else if (progressPercent >= 5) {
      return '🌟 Every step counts! Keep going!';
    }
    return '';
  }
}
