import '../models/workout_record.dart';

class WorkoutStatistics {
  final int totalWorkouts;
  final int totalSets;
  final int totalReps;
  final int totalXp;
  final int totalGems;

  final String? mostTrainedExercise;
  final String? mostTrainedCategory;

  final List<int> weeklyWorkouts;

  const WorkoutStatistics({
    required this.totalWorkouts,
    required this.totalSets,
    required this.totalReps,
    required this.totalXp,
    required this.totalGems,
    required this.mostTrainedExercise,
    required this.mostTrainedCategory,
    required this.weeklyWorkouts,
  });
}

class WorkoutStatisticsService {
  static WorkoutStatistics calculate(
    List<WorkoutRecord> history,
  ) {
    int totalSets = 0;
    int totalReps = 0;
    int totalXp = 0;
    int totalGems = 0;

    final Map<String, int> exerciseCounts = {};
    final Map<String, int> categoryCounts = {};

    final List<int> weeklyWorkouts =
        List.filled(7, 0);

    final now = DateTime.now();

    final today = DateTime(
      now.year,
      now.month,
      now.day,
    );

    final startOfWeek =
        today.subtract(
      Duration(
        days: today.weekday - 1,
      ),
    );

    for (final workout in history) {
      totalSets += workout.sets;
      totalReps += workout.reps;
      totalXp += workout.xp;
      totalGems += workout.gems;

      exerciseCounts[workout.exerciseName] =
          (exerciseCounts[workout.exerciseName] ?? 0) + 1;

      categoryCounts[workout.category] =
          (categoryCounts[workout.category] ?? 0) + 1;

      final workoutDay = DateTime(
        workout.date.year,
        workout.date.month,
        workout.date.day,
      );

      final int dayIndex =
          workoutDay.difference(startOfWeek).inDays;

      if (dayIndex >= 0 && dayIndex < 7) {
        weeklyWorkouts[dayIndex]++;
      }
    }

    String? mostTrainedExercise;
    int highestExerciseCount = 0;

    exerciseCounts.forEach((name, count) {
      if (count > highestExerciseCount) {
        highestExerciseCount = count;
        mostTrainedExercise = name;
      }
    });

    String? mostTrainedCategory;
    int highestCategoryCount = 0;

    categoryCounts.forEach((category, count) {
      if (count > highestCategoryCount) {
        highestCategoryCount = count;
        mostTrainedCategory = category;
      }
    });

    return WorkoutStatistics(
      totalWorkouts: history.length,
      totalSets: totalSets,
      totalReps: totalReps,
      totalXp: totalXp,
      totalGems: totalGems,
      mostTrainedExercise: mostTrainedExercise,
      mostTrainedCategory: mostTrainedCategory,
      weeklyWorkouts: weeklyWorkouts,
    );
  }
}