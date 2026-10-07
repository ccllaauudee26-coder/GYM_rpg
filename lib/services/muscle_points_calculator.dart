import '../models/exercise.dart';

class MusclePointsCalculator {
  static Map<String, int> calculate({
    required Exercise exercise,
    required int totalReps,
    required int sets,
  }) {
    final Map<String, int> result = {};

    // totalReps already contains reps from ALL sets.
    final int basePoints = totalReps;

    exercise.muscleWeights.forEach((muscle, weight) {
      final int points = (basePoints * weight).round();

      if (points > 0) {
        result[muscle] = points;
      }
    });

    return result;
  }
}