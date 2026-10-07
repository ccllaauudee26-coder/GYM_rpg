import '../app/app_repositories.dart';
import 'achievement_service.dart';

class AchievementProgress {
  // =========================
  // CLAIMED ACHIEVEMENTS
  // =========================

  static Set<String> get claimed =>
      AppRepositories.achievements.claimed;

  // =========================
  // UNLOCK CHECK
  // =========================

  static bool isUnlocked(
    Achievement achievement,
    int totalWorkouts,
  ) {
    return totalWorkouts >=
        achievement.target;
  }

  // =========================
  // CLAIM CHECK
  // =========================

  static bool isClaimed(
    Achievement achievement,
  ) {
    return AppRepositories.achievements
        .isClaimed(achievement);
  }

  // =========================
  // LOAD
  // =========================

  static Future<void> load() async {
    await AppRepositories.achievements.load();
  }

  // =========================
  // SAVE
  // =========================

  static Future<void> save() async {
    // Persistence is handled by
    // AchievementRepository.
  }

  // =========================
  // CHECK NEW ACHIEVEMENT
  // =========================

  static Achievement? checkNewAchievement(
    int totalWorkouts,
  ) {
    for (final achievement
        in AchievementService.achievements) {
      if (totalWorkouts >=
              achievement.target &&
          !isClaimed(achievement)) {
        AppRepositories.achievements.claim(
          achievement,
        );

        return achievement;
      }
    }

    return null;
  }
}