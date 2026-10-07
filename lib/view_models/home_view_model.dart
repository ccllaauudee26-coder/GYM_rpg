import 'package:flutter/foundation.dart';

import '../models/exercise.dart';

import '../services/exercise_service.dart';
import '../services/user_progress.dart';

class HomeViewModel extends ChangeNotifier {
  // =========================
  // PLAYER STATE
  // =========================

  int get xp => UserProgress.xp;

  int get gems => UserProgress.gems;

  int get streak => UserProgress.streak;

  int get totalWorkouts =>
      UserProgress.totalWorkouts;

  int get totalSets =>
      UserProgress.totalSets;

  int get totalReps =>
      UserProgress.totalReps;

  // =========================
  // LEVEL
  // =========================

  int get level {
    return (xp ~/ 100) + 1;
  }

  int get currentXp {
    return xp % 100;
  }

  double get xpProgress {
    return currentXp / 100.0;
  }

  // =========================
  // RECENT EXERCISE
  // =========================

  Exercise? get recentExercise {
    if (UserProgress.workoutHistory.isEmpty) {
      return null;
    }

    final recentRecord =
        UserProgress.workoutHistory.first;

    for (final exercise
        in ExerciseService.exercises) {
      if (exercise.name ==
          recentRecord.exerciseName) {
        return exercise;
      }
    }

    return null;
  }

  // =========================
  // REFRESH
  // =========================

  void refresh() {
    notifyListeners();
  }
}