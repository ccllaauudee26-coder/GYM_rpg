import '../models/exercise.dart';

class RewardResult {
  final int xp;
  final int gems;

  const RewardResult({
    required this.xp,
    required this.gems,
  });
}

class RewardCalculator {
  static RewardResult calculate({
    required Exercise exercise,
    required List<int> repsPerSet,
  }) {
    final int completedSets = repsPerSet.length;

    final int totalReps = repsPerSet.fold(
      0,
      (sum, reps) => sum + reps,
    );

    // =========================
    // SET MULTIPLIER
    // =========================

    final double setMultiplier =
        completedSets / exercise.defaultSets;

    // =========================
    // REP MULTIPLIER
    // =========================

    final int defaultTotalReps =
        exercise.defaultSets *
        exercise.defaultReps;

    final double repMultiplier =
        defaultTotalReps == 0
            ? 0
            : totalReps / defaultTotalReps;

    // =========================
    // FINAL MULTIPLIER
    // =========================

    final double multiplier =
        (setMultiplier * 0.4) +
        (repMultiplier * 0.6);

    int xp =
        (exercise.xp * multiplier).round();

    int gems =
        (exercise.gems * multiplier).round();

    // Minimum reward
    if (xp < 1) xp = 1;
    if (gems < 1) gems = 1;

    return RewardResult(
      xp: xp,
      gems: gems,
    );
  }
}