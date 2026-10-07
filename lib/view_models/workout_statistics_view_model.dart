import 'package:flutter/foundation.dart';

import '../models/workout_record.dart';
import '../services/workout_statistics_service.dart';

class WorkoutStatisticsViewModel
    extends ChangeNotifier {
  final List<WorkoutRecord> history;

  WorkoutStatisticsViewModel({
    required this.history,
  });

  dynamic get stats {
    return WorkoutStatisticsService.calculate(
      history,
    );
  }

  int get totalWorkouts =>
      stats.totalWorkouts;

  int get totalSets =>
      stats.totalSets;

  int get totalReps =>
      stats.totalReps;

  int get totalXp =>
      stats.totalXp;

  int get totalGems =>
      stats.totalGems;

  String? get mostTrainedExercise =>
      stats.mostTrainedExercise;

  String? get mostTrainedCategory =>
      stats.mostTrainedCategory;

  List<int> get weeklyWorkouts =>
      stats.weeklyWorkouts;

  void refresh() {
    notifyListeners();
  }
}