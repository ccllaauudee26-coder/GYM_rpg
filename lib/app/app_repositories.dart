import '../repositories/achievement_repository.dart';
import '../repositories/local_daily_quest_repository.dart';
import '../repositories/local_player_repository.dart';
import '../repositories/local_workout_repository.dart';
import '../repositories/muscle_progress_repository.dart';

class AppRepositories {
  static final LocalPlayerRepository player =
      LocalPlayerRepository();

  static final LocalWorkoutRepository workouts =
      LocalWorkoutRepository();

  static final MuscleProgressRepository muscles =
      MuscleProgressRepository();

  static final LocalAchievementRepository achievements =
      LocalAchievementRepository();

  static final LocalDailyQuestRepository dailyQuests =
      LocalDailyQuestRepository();

  static bool _initialized = false;

  static Future<void> initialize() async {
    if (_initialized) {
      return;
    }

    await Future.wait([
      player.load(),
      workouts.load(),
      muscles.load(),
      achievements.load(),
      dailyQuests.load(),
    ]);

    await dailyQuests.resetIfNewDay();

    _initialized = true;
  }
}  