import '../models/exercise.dart';
import '../services/exercise_service.dart';
import '../services/user_progress.dart';

class HomeSummary {
  final int level;
  final int currentXp;
  final double xpProgress;
  final int xpToNextLevel;

  final Exercise? recentExercise;

  const HomeSummary({
    required this.level,
    required this.currentXp,
    required this.xpProgress,
    required this.xpToNextLevel,
    required this.recentExercise,
  });
}

class HomeSummaryService {
  static HomeSummary build() {
    final int xp = UserProgress.xp;

    final int level = (xp ~/ 100) + 1;
    final int currentXp = xp % 100;

    final double xpProgress =
        currentXp / 100.0;

    final int xpToNextLevel =
        100 - currentXp;

    Exercise? recentExercise;

    if (UserProgress.workoutHistory.isNotEmpty) {
      final recent =
          UserProgress.workoutHistory.first;

      for (final exercise
          in ExerciseService.exercises) {
        if (exercise.name ==
            recent.exerciseName) {
          recentExercise = exercise;
          break;
        }
      }
    }

    return HomeSummary(
      level: level,
      currentXp: currentXp,
      xpProgress: xpProgress,
      xpToNextLevel: xpToNextLevel,
      recentExercise: recentExercise,
    );
  }
}