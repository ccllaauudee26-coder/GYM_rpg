import 'app_repositories.dart';
import 'workout_dependencies.dart';

class WorkoutDependenciesProvider {
  static WorkoutDependencies create() {
    return WorkoutDependencies(
      playerRepository:
          AppRepositories.player,
      workoutRepository:
          AppRepositories.workouts,
      muscleRepository:
          AppRepositories.muscles,
      achievementRepository:
          AppRepositories.achievements,
      dailyQuestRepository:
          AppRepositories.dailyQuests,
    );
  }
}