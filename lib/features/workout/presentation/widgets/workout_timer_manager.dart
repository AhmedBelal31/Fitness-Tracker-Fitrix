import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkoutTimerManager extends ChangeNotifier {
  final String workoutId;

  DateTime? _workoutStartTime;
  Timer? _timer;
  String _elapsedTimeStr = "00:00";

  WorkoutTimerManager({required this.workoutId});

  String get elapsedTime => _elapsedTimeStr;

  DateTime? get startTime => _workoutStartTime;

  bool get isRunning => _workoutStartTime != null;

  Future<void> initialize() async {
    await _loadStartTime();
  }

  Future<void> _loadStartTime() async {
    final prefs = await SharedPreferences.getInstance();
    final storedTimeMillis = prefs.getInt('workout_start_time_$workoutId');

    if (storedTimeMillis != null) {
      _workoutStartTime = DateTime.fromMillisecondsSinceEpoch(storedTimeMillis);
      _startTimer();
      notifyListeners();
    }
  }

  Future<void> startWorkout() async {
    final now = DateTime.now();
    _workoutStartTime = now;
    _elapsedTimeStr = "00:00";

    await _saveStartTime(now);
    _startTimer();
    notifyListeners();
  }

  Future<void> stopWorkout() async {
    _timer?.cancel();
    await _clearStartTime();
    _workoutStartTime = null;
    _elapsedTimeStr = "00:00";
    notifyListeners();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_workoutStartTime != null) {
        final elapsed = DateTime.now().difference(_workoutStartTime!);
        final minutes = elapsed.inMinutes
            .remainder(60)
            .toString()
            .padLeft(2, '0');
        final seconds = elapsed.inSeconds
            .remainder(60)
            .toString()
            .padLeft(2, '0');
        _elapsedTimeStr = '$minutes:$seconds';
        notifyListeners();
      }
    });
  }

  Future<void> _saveStartTime(DateTime time) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
      'workout_start_time_$workoutId',
      time.millisecondsSinceEpoch,
    );
  }

  Future<void> _clearStartTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('workout_start_time_$workoutId');
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
