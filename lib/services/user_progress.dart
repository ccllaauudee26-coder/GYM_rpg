import 'package:flutter/foundation.dart';

import '../app/app_repositories.dart';

class UserProgress {
  // =========================
  // PLAYER STATE
  // =========================

  static int xp = 25;
  static int gems = 0;

  static int streak = 0;

  static int totalWorkouts = 0;
  static int totalSets = 0;
  static int totalReps = 0;

  
  // =========================
  // UI NOTIFIER
  // =========================

  static final ValueNotifier<int> version =
      ValueNotifier<int>(0);

  // =========================
  // DATA FROM REPOSITORIES
  // =========================

  static Map<String, int> get musclePoints =>
      AppRepositories.muscles.points;

  static get workoutHistory =>
      AppRepositories.workouts.history;

  // =========================
  // INITIALIZATION
  // =========================

  static bool _initialized = false;

static Future<void> initialize() async {
  if (_initialized) {
    return;
  }

  await AppRepositories.initialize();

  _syncFromRepositories();

  _initialized = true;

  version.value++;
}

  // =========================
  // SYNC UI STATE
  // =========================

  static void _syncFromRepositories() {
    xp = AppRepositories.player.xp;
    gems = AppRepositories.player.gems;

    streak = AppRepositories.player.streak;

    totalWorkouts =
        AppRepositories.player.totalWorkouts;

    totalSets =
        AppRepositories.player.totalSets;

    totalReps =
        AppRepositories.player.totalReps;

    
  }

  // =========================
  // REFRESH AFTER DATA CHANGE
  // =========================

  static void refresh() {
    _syncFromRepositories();

    version.value++;
  }

  // =========================
  // RESET ALL PROGRESS
  // =========================

  static Future<void> resetProgress() async {
    if (!_initialized) {
      await initialize();
    }

    await AppRepositories.player.clear();

    await AppRepositories.workouts.clear();

    await AppRepositories.muscles.clear();

    await AppRepositories.achievements.clear();

    await AppRepositories.dailyQuests.clear();

    _syncFromRepositories();

    version.value++;
  }
}