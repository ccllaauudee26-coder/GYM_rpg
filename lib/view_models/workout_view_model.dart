import 'package:flutter/foundation.dart';

import '../models/exercise.dart';

import '../services/achievement_service.dart';
import '../services/reward_calculator.dart';
import '../services/workout_service.dart';
import '../services/user_progress.dart';

import '../repositories/achievement_repository.dart';
import '../repositories/daily_quest_repository.dart';
import '../repositories/muscle_progress_repository.dart';
import '../repositories/player_repository.dart';
import '../repositories/workout_repository.dart';

class WorkoutViewModel extends ChangeNotifier {
  final Exercise exercise;

  final WorkoutService workoutService;

  bool _isSaving = false;

  String? _error;

  Achievement? _achievement;

  RewardResult? _reward;

  WorkoutViewModel({
    required this.exercise,
    required PlayerRepository playerRepository,
    required WorkoutRepository workoutRepository,
    required MuscleProgressRepository muscleRepository,
    required AchievementRepository achievementRepository,
    required DailyQuestRepository dailyQuestRepository,
  }) : workoutService = WorkoutService(
          playerRepository: playerRepository,
          workoutRepository: workoutRepository,
          muscleRepository: muscleRepository,
          achievementRepository: achievementRepository,
          dailyQuestRepository: dailyQuestRepository,
        );

  // =========================
  // GETTERS
  // =========================

  bool get isSaving => _isSaving;

  String? get error => _error;

  Achievement? get achievement => _achievement;

  RewardResult? get reward => _reward;

  // =========================
  // COMPLETE WORKOUT
  // =========================

  Future<RewardResult?> completeWorkout({
    required List<int> repsPerSet,
  }) async {
    if (_isSaving) {
      return null;
    }

    if (repsPerSet.isEmpty) {
      _error = 'At least one set is required.';
      notifyListeners();
      return null;
    }

    _isSaving = true;
    _error = null;
    _achievement = null;
    _reward = null;

    notifyListeners();

    try {
      final reward = RewardCalculator.calculate(
        exercise: exercise,
        repsPerSet: repsPerSet,
      );

      _achievement = await workoutService.completeWorkout(
        exercise: exercise,
        repsPerSet: repsPerSet,
      );

      _reward = reward;

      UserProgress.refresh();

      return reward;
    } catch (e) {
      _error = e.toString();
      return null;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  // =========================
  // CLEAR ERROR
  // =========================

  void clearError() {
    _error = null;
    notifyListeners();
  }

  // =========================
  // CLEAR RESULT
  // =========================

  void clearResult() {
    _achievement = null;
    _reward = null;
    _error = null;

    notifyListeners();
  }
}