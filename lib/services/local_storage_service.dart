import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String xpKey = 'provem_xp';
  static const String gemsKey = 'provem_gems';
  static const String streakKey = 'provem_streak';
  static const String totalWorkoutsKey =
      'provem_total_workouts';
  static const String totalSetsKey =
      'provem_total_sets';
  static const String totalRepsKey =
      'provem_total_reps';
  static const String lastWorkoutDateKey =
      'provem_last_workout_date';

  static const String musclePointsKey =
      'provem_muscle_points';

  static const String workoutHistoryKey =
      'provem_workout_history';

  static const String achievementsKey =
      'provem_claimed_achievements';

  static const String dailyQuestProgressKey =
      'provem_daily_quest_progress';

  static const String dailyQuestCompletedKey =
      'provem_daily_quest_completed';

  static const String dailyQuestDateKey =
      'provem_daily_quest_date';

  static final SharedPreferencesAsync _prefs =
      SharedPreferencesAsync();

  static Future<void> savePlayer({
    required int xp,
    required int gems,
    required int streak,
    required int totalWorkouts,
    required int totalSets,
    required int totalReps,
    DateTime? lastWorkoutDate,
  }) async {
    await _prefs.setInt(xpKey, xp);
    await _prefs.setInt(gemsKey, gems);
    await _prefs.setInt(streakKey, streak);

    await _prefs.setInt(
      totalWorkoutsKey,
      totalWorkouts,
    );

    await _prefs.setInt(
      totalSetsKey,
      totalSets,
    );

    await _prefs.setInt(
      totalRepsKey,
      totalReps,
    );

    if (lastWorkoutDate != null) {
      await _prefs.setString(
        lastWorkoutDateKey,
        lastWorkoutDate.toIso8601String(),
      );
    } else {
      await _prefs.remove(lastWorkoutDateKey);
    }
  }

  static Future<Map<String, dynamic>>
      loadPlayer() async {
    final int loadedXp =
        await _prefs.getInt(xpKey) ?? 25;

    final int loadedGems =
        await _prefs.getInt(gemsKey) ?? 0;

    final int loadedStreak =
        await _prefs.getInt(streakKey) ?? 0;

    final int loadedTotalWorkouts =
        await _prefs.getInt(
      totalWorkoutsKey,
    ) ?? 0;

    final int loadedTotalSets =
        await _prefs.getInt(
      totalSetsKey,
    ) ?? 0;

    final int loadedTotalReps =
        await _prefs.getInt(
      totalRepsKey,
    ) ?? 0;

    final String? rawDate =
        await _prefs.getString(
      lastWorkoutDateKey,
    );

    return {
      'xp': loadedXp,
      'gems': loadedGems,
      'streak': loadedStreak,
      'totalWorkouts': loadedTotalWorkouts,
      'totalSets': loadedTotalSets,
      'totalReps': loadedTotalReps,
      'lastWorkoutDate': rawDate == null
          ? null
          : DateTime.tryParse(rawDate),
    };
  }

  static Future<void> saveMusclePoints(
    Map<String, int> points,
  ) async {
    await _prefs.setString(
      musclePointsKey,
      jsonEncode(points),
    );
  }

  static Future<Map<String, int>>
      loadMusclePoints() async {
    final String? raw =
        await _prefs.getString(
      musclePointsKey,
    );

    if (raw == null) {
      return {};
    }

    final decoded =
        jsonDecode(raw) as Map<String, dynamic>;

    return decoded.map(
      (key, value) => MapEntry(
        key,
        (value as num).toInt(),
      ),
    );
  }

  static Future<void> saveHistory(
    List<Map<String, dynamic>> history,
  ) async {
    await _prefs.setString(
      workoutHistoryKey,
      jsonEncode(history),
    );
  }

  static Future<List<Map<String, dynamic>>>
      loadHistory() async {
    final String? raw =
        await _prefs.getString(
      workoutHistoryKey,
    );

    if (raw == null) {
      return [];
    }

    final decoded =
        jsonDecode(raw) as List<dynamic>;

    return decoded.map((item) {
      return Map<String, dynamic>.from(
        item as Map,
      );
    }).toList();
  }

  static Future<void> saveAchievements(
    Set<String> claimed,
  ) async {
    await _prefs.setStringList(
      achievementsKey,
      claimed.toList(),
    );
  }

  static Future<Set<String>>
      loadAchievements() async {
    final List<String>? values =
        await _prefs.getStringList(
      achievementsKey,
    );

    if (values == null) {
      return {};
    }

    return values.toSet();
  }

  // =========================
  // DAILY QUEST STORAGE
  // =========================

  static Future<void> saveDailyQuestState({
    required Map<String, int> progress,
    required Set<String> completed,
    required DateTime date,
  }) async {
    await _prefs.setString(
      dailyQuestProgressKey,
      jsonEncode(progress),
    );

    await _prefs.setStringList(
      dailyQuestCompletedKey,
      completed.toList(),
    );

    await _prefs.setString(
      dailyQuestDateKey,
      date.toIso8601String(),
    );
  }

  static Future<Map<String, dynamic>>
      loadDailyQuestState() async {
    final String? progressRaw =
        await _prefs.getString(
      dailyQuestProgressKey,
    );

    final List<String>? completedRaw =
        await _prefs.getStringList(
      dailyQuestCompletedKey,
    );

    final String? dateRaw =
        await _prefs.getString(
      dailyQuestDateKey,
    );

    Map<String, int> progress = {};

    if (progressRaw != null) {
      final decoded =
          jsonDecode(progressRaw)
              as Map<String, dynamic>;

      progress = decoded.map(
        (key, value) => MapEntry(
          key,
          (value as num).toInt(),
        ),
      );
    }

    return {
      'progress': progress,
      'completed':
          completedRaw?.toSet() ?? <String>{},
      'date': dateRaw == null
          ? null
          : DateTime.tryParse(dateRaw),
    };
  }
  static Future<void> clearAll() async {
  await _prefs.clear();
 }
}
