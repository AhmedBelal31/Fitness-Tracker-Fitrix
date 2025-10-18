class GoalData {
  final String title;
  final double currentValue;
  final double goalValue;
  final double startValue;
  final String unit;
  final GoalType type;
  final String icon;

  GoalData({
    required this.title,
    required this.currentValue,
    required this.goalValue,
    required this.startValue,
    required this.unit,
    required this.type,
    required this.icon,
  });

  // Calculate progress percentage (0-100)
  double get progressPercentage {
    if (type == GoalType.decrease) {
      // For weight loss / body fat reduction
      final totalToLose = startValue - goalValue;
      final alreadyLost = startValue - currentValue;
      if (totalToLose <= 0) return 100;
      return ((alreadyLost / totalToLose) * 100).clamp(0, 100);
    } else {
      // For muscle gain
      final totalToGain = goalValue - startValue;
      final alreadyGained = currentValue - startValue;
      if (totalToGain <= 0) return 100;
      return ((alreadyGained / totalToGain) * 100).clamp(0, 100);
    }
  }

  // Remaining value to reach goal
  double get remaining {
    if (type == GoalType.decrease) {
      return (currentValue - goalValue).clamp(0, double.infinity);
    } else {
      return (goalValue - currentValue).clamp(0, double.infinity);
    }
  }

  // Check if goal is achieved
  bool get isAchieved {
    if (type == GoalType.decrease) {
      return currentValue <= goalValue;
    } else {
      return currentValue >= goalValue;
    }
  }

  // Get progress text
  String get progressText {
    if (isAchieved) {
      return 'Goal Achieved! 🎉';
    }
    return type == GoalType.decrease
        ? '${remaining.toStringAsFixed(1)}$unit to lose'
        : '${remaining.toStringAsFixed(1)}$unit to gain';
  }
}

enum GoalType {
  decrease, // Weight loss, body fat reduction
  increase, // Muscle gain
}
