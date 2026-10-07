import 'package:flutter/foundation.dart';

import '../app/app_repositories.dart';
import '../models/daily_quest.dart';
import '../services/daily_quest_service.dart';

class DailyQuestViewModel extends ChangeNotifier {
  // =========================
  // INITIAL STATE
  // =========================

  DailyQuestViewModel();

  List<DailyQuest> get quests =>
      DailyQuestService.quests;

  // =========================
  // QUEST PROGRESS
  // =========================

  int getProgress(DailyQuest quest) {
    return AppRepositories.dailyQuests
        .getProgress(quest);
  }

  bool isCompleted(DailyQuest quest) {
    return AppRepositories.dailyQuests
        .isCompleted(quest);
  }

  double getProgressRatio(
    DailyQuest quest,
  ) {
    if (quest.target <= 0) {
      return 0.0;
    }

    final int current =
        getProgress(quest);

    return (current / quest.target)
        .clamp(0.0, 1.0);
  }

    // =========================
  // REFRESH
  // =========================

  Future<void> refresh() async {
    await AppRepositories.dailyQuests.load();
    await AppRepositories.dailyQuests.resetIfNewDay();

    notifyListeners();
  }

  void refreshUI() {
    notifyListeners();
  }
}