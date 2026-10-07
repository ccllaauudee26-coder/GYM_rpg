import '../services/exercise_favorites_service.dart';
import '../services/recent_exercises_service.dart';
import '../services/user_progress.dart';

class AppInitializer {
  const AppInitializer();

  Future<void> initialize() async {
    await UserProgress.initialize();

    await Future.wait([
      ExerciseFavoritesService.load(),
      RecentExercisesService.load(),
    ]);
  }
}