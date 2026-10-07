import '../models/exercise.dart';
import 'reward_calculator.dart';

class WorkoutLiveSummary {
  final int sets;
  final int reps;
  final int xp;
  final int gems;

  const WorkoutLiveSummary({
    required this.sets,
    required this.reps,
    required this.xp,
    required this.gems,
  });
}

class WorkoutLiveSummaryService {
  static WorkoutLiveSummary calculate({
    required Exercise exercise,
    required List<int> repsPerSet,
  }) {
    final int totalReps = repsPerSet.fold(
      0,
      (sum, value) => sum + value,
    );

    final reward = RewardCalculator.calculate(
      exercise: exercise,
      repsPerSet: repsPerSet,
    );

    return WorkoutLiveSummary(
      sets: repsPerSet.length,
      reps: totalReps,
      xp: reward.xp,
      gems: reward.gems,
    );
  }
}