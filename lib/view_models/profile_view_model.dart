import 'package:flutter/foundation.dart';

import '../models/workout_record.dart';

import '../services/activity_service.dart';
import '../services/profile_summary_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final List<WorkoutRecord> history;
  final Map<String, int> musclePoints;

  ProfileViewModel({
    required this.history,
    required this.musclePoints,
  });

  // =========================
  // ACTIVITY
  // =========================

  List<bool> get activity {
    return ActivityService.getLast7Days(
      history,
    );
  }

  int get activeDays {
    return ActivityService.getActiveDays(
      history,
    );
  }

  int get todayWorkouts {
    return ActivityService.getTodayWorkouts(
      history,
    );
  }

  // =========================
  // MUSCLE PROGRESS
  // =========================

  List<MuscleProgressData> getMuscleProgress(
    List<String> muscles,
  ) {
    return ProfileSummaryService
        .getMuscleProgress(
      muscles,
    );
  }

  // =========================
  // REFRESH
  // =========================

  void refresh({
    required List<WorkoutRecord> history,
    required Map<String, int> musclePoints,
  }) {
    // The lists/maps passed by UserProgress
    // are the current source of truth.
    // This method exists for future migration
    // to repository-owned state.

    notifyListeners();
  }
}