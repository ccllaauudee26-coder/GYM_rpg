import '../models/daily_quest.dart';

abstract class DailyQuestRepository {
  Future<void> load();

  int getProgress(
    DailyQuest quest,
  );

  bool isCompleted(
    DailyQuest quest,
  );

  Future<bool> addProgress({
    required DailyQuest quest,
    required int amount,
  });

  Future<void> resetIfNewDay();

  Future<void> clear();
}