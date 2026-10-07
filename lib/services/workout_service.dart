import '../models/exercise.dart';
import '../models/workout_record.dart';

import '../services/achievement_service.dart';
import '../services/daily_quest_service.dart';
import '../services/muscle_points_calculator.dart';
import '../services/reward_calculator.dart';

import '../repositories/achievement_repository.dart';
import '../repositories/daily_quest_repository.dart';
import '../repositories/muscle_progress_repository.dart';
import '../repositories/player_repository.dart';
import '../repositories/workout_repository.dart';

class WorkoutService {
  final PlayerRepository playerRepository;
  final WorkoutRepository workoutRepository;
  final MuscleProgressRepository muscleRepository;
  final AchievementRepository achievementRepository;
  final DailyQuestRepository dailyQuestRepository;

  const WorkoutService({
    required this.playerRepository,
    required this.workoutRepository,
    required this.muscleRepository,
    required this.achievementRepository,
    required this.dailyQuestRepository,
  });

  Future<Achievement?> completeWorkout({
    required Exercise exercise,
    required List<int> repsPerSet,
  }) async {
    // =========================
    // VALIDATION
    // =========================

    if (repsPerSet.isEmpty) {
      throw ArgumentError(
        'Workout must contain at least one set.',
      );
    }

    if (repsPerSet.any((reps) => reps < 0)) {
      throw ArgumentError(
        'Repetitions cannot be negative.',
      );
    }

    // =========================
    // REWARD
    // =========================

    final reward = RewardCalculator.calculate(
      exercise: exercise,
      repsPerSet: repsPerSet,
    );

    final workoutSets = repsPerSet.length;

    final workoutReps = repsPerSet.fold<int>(
      0,
      (sum, value) => sum + value,
    );

    // =========================
    // CURRENT PLAYER STATE
    // =========================

    int xp = playerRepository.xp;
    int gems = playerRepository.gems;

    int streak = playerRepository.streak;

    int totalWorkouts =
        playerRepository.totalWorkouts;

    int totalSets =
        playerRepository.totalSets;

    int totalReps =
        playerRepository.totalReps;

    DateTime? lastWorkoutDate =
        playerRepository.lastWorkoutDate;

    // =========================
    // BASE REWARDS + TOTALS
    // =========================

    xp += reward.xp;
    gems += reward.gems;

    totalWorkouts++;
    totalSets += workoutSets;
    totalReps += workoutReps;

    // =========================
    // MUSCLE PROGRESS
    // =========================

    final muscleResult =
        MusclePointsCalculator.calculate(
      exercise: exercise,
      totalReps: workoutReps,
      sets: workoutSets,
    );

    await muscleRepository.addPoints(
      muscleResult,
    );

    // =========================
    // WORKOUT HISTORY
    // =========================

    final record = WorkoutRecord(
      exerciseName: exercise.name,
      category: exercise.category,
      date: DateTime.now(),
      sets: workoutSets,
      reps: workoutReps,
      xp: reward.xp,
      gems: reward.gems,
    );

    await workoutRepository.addWorkout(
      record,
    );

    // =========================
    // DAILY QUEST
    // =========================

    await dailyQuestRepository.resetIfNewDay();

    final quest = DailyQuestService.findForExercise(
      exercise.name,
    );

    if (quest != null) {
      final questCompleted =
          await dailyQuestRepository.addProgress(
        quest: quest,
        amount: workoutReps,
      );

      if (questCompleted) {
        xp += quest.xpReward;
        gems += quest.gemsReward;
      }
    }

    // =========================
    // STREAK
    // =========================

    final now = DateTime.now();

    final today = DateTime(
      now.year,
      now.month,
      now.day,
    );

    if (lastWorkoutDate == null) {
      streak = 1;
      lastWorkoutDate = today;
    } else {
      final lastDate = DateTime(
        lastWorkoutDate.year,
        lastWorkoutDate.month,
        lastWorkoutDate.day,
      );

      final difference =
          today.difference(lastDate).inDays;

      if (difference == 0) {
        // Same day.
      } else if (difference == 1) {
        streak++;
        lastWorkoutDate = today;
      } else {
        streak = 1;
        lastWorkoutDate = today;
      }
    }

    // =========================
    // ACHIEVEMENTS
    // =========================

    Achievement? unlockedAchievement;

    for (final achievement
        in AchievementService.achievements) {
      final reachedTarget =
          totalWorkouts >= achievement.target;

      final alreadyClaimed =
          achievementRepository.isClaimed(
        achievement,
      );

      if (reachedTarget && !alreadyClaimed) {
        await achievementRepository.claim(
          achievement,
        );

        xp += achievement.xpReward;
        gems += achievement.gemsReward;

        unlockedAchievement = achievement;

        break;
      }
    }

    // =========================
    // SAVE PLAYER
    // =========================

    await playerRepository.save(
      xp: xp,
      gems: gems,
      streak: streak,
      totalWorkouts: totalWorkouts,
      totalSets: totalSets,
      totalReps: totalReps,
      lastWorkoutDate: lastWorkoutDate,
    );

    return unlockedAchievement;
  }
}