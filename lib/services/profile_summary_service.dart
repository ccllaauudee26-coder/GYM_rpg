import 'rank_service.dart';
import 'user_progress.dart';

class MuscleProgressData {
  final String muscle;
  final int points;
  final String rank;
  final double progress;
  final int nextGoal;

  const MuscleProgressData({
    required this.muscle,
    required this.points,
    required this.rank,
    required this.progress,
    required this.nextGoal,
  });
}

class ProfileSummaryService {
  static List<MuscleProgressData> getMuscleProgress(
    List<String> muscles,
  ) {
    return muscles.map((muscle) {
      final int points =
          UserProgress.musclePoints[muscle] ?? 0;

      return MuscleProgressData(
        muscle: muscle,
        points: points,
        rank: RankService.getRank(points),
        progress: RankService.getProgress(points),
        nextGoal: RankService.getNextGoal(points),
      );
    }).toList();
  }
}