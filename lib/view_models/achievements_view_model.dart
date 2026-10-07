import 'package:flutter/foundation.dart';

import '../app/app_repositories.dart';

import '../services/achievement_service.dart';

class AchievementsViewModel
    extends ChangeNotifier {
  // =========================
  // ACHIEVEMENTS
  // =========================

  List<Achievement> get achievements =>
      AchievementService.achievements;

  // =========================
  // PLAYER PROGRESS
  // =========================

  int get totalWorkouts =>
      AppRepositories.player.totalWorkouts;

  // =========================
  // STATES
  // =========================

  bool isUnlocked(
    Achievement achievement,
  ) {
    return totalWorkouts >=
        achievement.target;
  }

  bool isClaimed(
    Achievement achievement,
  ) {
    return AppRepositories.achievements
        .isClaimed(achievement);
  }

  double getProgress(
    Achievement achievement,
  ) {
    if (achievement.target <= 0) {
      return 1.0;
    }

    return (totalWorkouts /
            achievement.target)
        .clamp(0.0, 1.0);
  }

  // =========================
  // REFRESH
  // =========================

  void refresh() {
    notifyListeners();
  }
}