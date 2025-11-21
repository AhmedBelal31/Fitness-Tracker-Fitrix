import 'trainee_data.dart';

class TrainerDashboardData {
  final int totalTrainees;
  final int activeTrainees;
  final int totalWorkoutsCreated;
  final int pendingRequests;
  final List<TraineeData>? recentTrainees;
  final Map<String, dynamic>? statistics;

  TrainerDashboardData({
    required this.totalTrainees,
    required this.activeTrainees,
    required this.totalWorkoutsCreated,
    required this.pendingRequests,
    this.recentTrainees,
    this.statistics,
  });

  factory TrainerDashboardData.fromJson(Map<String, dynamic> json) =>
      TrainerDashboardData(
        totalTrainees: json['totalTrainees'] ?? 0,
        activeTrainees: json['activeTrainees'] ?? 0,
        totalWorkoutsCreated: json['totalWorkoutsCreated'] ?? 0,
        pendingRequests: json['pendingRequests'] ?? 0,
        recentTrainees: json['recentTrainees'] != null
            ? (json['recentTrainees'] as List)
                  .map((e) => TraineeData.fromJson(e))
                  .toList()
            : null,
        statistics: json['statistics'],
      );

  Map<String, dynamic> toJson() => {
    'totalTrainees': totalTrainees,
    'activeTrainees': activeTrainees,
    'totalWorkoutsCreated': totalWorkoutsCreated,
    'pendingRequests': pendingRequests,
    'recentTrainees': recentTrainees?.map((e) => e.toJson()).toList(),
    'statistics': statistics,
  };
}
