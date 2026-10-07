import '../models/daily_quest.dart';

import '../app/app_repositories.dart';

class DailyQuestProgress {
  // =========================
  // LOAD
  // =========================

  static Future<void> load() async {
    await AppRepositories.dailyQuests
        .load();
  }

  // =========================
  // NEW DAY
  // =========================

  static Future<void> resetIfNewDay() async {
    await AppRepositories.dailyQuests
        .resetIfNewDay();
  }

  // =========================
  // GET PROGRESS
  // =========================

  static int getProgress(
    DailyQuest quest,
  ) {
    return AppRepositories.dailyQuests
        .getProgress(quest);
  }

  // =========================
  // COMPLETED
  // =========================

  static bool isCompleted(
    DailyQuest quest,
  ) {
    return AppRepositories.dailyQuests
        .isCompleted(quest);
  }

  // =========================
  // ADD PROGRESS
  // =========================

  static Future<bool> addProgress({
    required DailyQuest quest,
    required int amount,
  }) async {
    return AppRepositories.dailyQuests
        .addProgress(
      quest: quest,
      amount: amount,
    );
  }
}