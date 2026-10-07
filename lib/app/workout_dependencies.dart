import '../repositories/achievement_repository.dart';
import '../repositories/daily_quest_repository.dart';
import '../repositories/muscle_progress_repository.dart';
import '../repositories/player_repository.dart';
import '../repositories/workout_repository.dart';

class WorkoutDependencies {
  final PlayerRepository playerRepository;
  final WorkoutRepository workoutRepository;
  final MuscleProgressRepository muscleRepository;
  final AchievementRepository achievementRepository;
  final DailyQuestRepository dailyQuestRepository;

  const WorkoutDependencies({
    required this.playerRepository,
    required this.workoutRepository,
    required this.muscleRepository,
    required this.achievementRepository,
    required this.dailyQuestRepository,
  });
}