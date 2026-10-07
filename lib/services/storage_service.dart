import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/workout_record.dart';

class StorageService {
  static final SharedPreferencesAsync _prefs =
      SharedPreferencesAsync();

  static const String _xpKey = "xp";
  static const String _gemsKey = "gems";
  static const String _streakKey = "streak";
  static const String _totalWorkoutsKey =
      "totalWorkouts";
  static const String _totalSetsKey = "totalSets";
  static const String _totalRepsKey = "totalReps";
  static const String _lastWorkoutDateKey =
      "lastWorkoutDate";

  static const String _musclePointsKey =
      "musclePoints";

  static const String _historyKey =
      "workoutHistory";

  static const String _claimedAchievementsKey =
      "claimedAchievements";

  static const String _questProgressKey =
      "questProgress";

  // =========================
  // SAVE PLAYER PROGRESS
  // =========================

  static Future<void> saveProgress({
    required int xp,
    required int gems,
    required int streak,
    required int totalWorkouts,
    required int totalSets,
    required int totalReps,
    required DateTime? lastWorkoutDate,
    required Map<String, int> musclePoints,
  }) async {
    await _prefs.setInt(_xpKey, xp);
    await _prefs.setInt(_gemsKey, gems);
    await _prefs.setInt(_streakKey, streak);
    await _prefs.setInt(
      _totalWorkoutsKey,
      totalWorkouts,
    );
    await _prefs.setInt(
      _totalSetsKey,
      totalSets,
    );
    await _prefs.setInt(
      _totalRepsKey,
      totalReps,
    );

    if (lastWorkoutDate != null) {
      await _prefs.setString(
        _lastWorkoutDateKey,
        lastWorkoutDate.toIso8601String(),
      );
    }

    await _prefs.setString(
      _musclePointsKey,
      jsonEncode(musclePoints),
    );
  }

  // =========================
  // LOAD PLAYER PROGRESS
  // =========================

  static Future<Map<String, dynamic>>
      loadProgress() async {
    final int xp =
        await _prefs.getInt(_xpKey) ?? 25;

    final int gems =
        await _prefs.getInt(_gemsKey) ?? 0;

    final int streak =
        await _prefs.getInt(_streakKey) ?? 0;

    final int totalWorkouts =
        await _prefs.getInt(
          _totalWorkoutsKey,
        ) ??
        0;

    final int totalSets =
        await _prefs.getInt(
          _totalSetsKey,
        ) ??
        0;

    final int totalReps =
        await _prefs.getInt(
          _totalRepsKey,
        ) ??
        0;

    final String? lastWorkoutString =
        await _prefs.getString(
          _lastWorkoutDateKey,
        );

    DateTime? lastWorkoutDate;

    if (lastWorkoutString != null) {
      lastWorkoutDate =
          DateTime.tryParse(
        lastWorkoutString,
      );
    }

    final String? musclePointsString =
        await _prefs.getString(
          _musclePointsKey,
        );

    Map<String, int> musclePoints = {};

    if (musclePointsString != null) {
      final decoded =
          jsonDecode(musclePointsString);

      if (decoded is Map) {
        musclePoints = decoded.map(
          (key, value) {
            return MapEntry(
              key.toString(),
              (value as num).toInt(),
            );
          },
        );
      }
    }

    return {
      "xp": xp,
      "gems": gems,
      "streak": streak,
      "totalWorkouts": totalWorkouts,
      "totalSets": totalSets,
      "totalReps": totalReps,
      "lastWorkoutDate": lastWorkoutDate,
      "musclePoints": musclePoints,
    };
  }

  // =========================
  // SAVE HISTORY
  // =========================

  static Future<void> saveHistory(
    List<WorkoutRecord> history,
  ) async {
    final encoded = history.map(
      (record) {
        return jsonEncode({
          "exerciseName":
              record.exerciseName,
          "category":
              record.category,
          "date":
              record.date.toIso8601String(),
          "sets": record.sets,
          "reps": record.reps,
          "xp": record.xp,
          "gems": record.gems,
        });
      },
    ).toList();

    await _prefs.setStringList(
      _historyKey,
      encoded,
    );
  }

  // =========================
  // LOAD HISTORY
  // =========================

  static Future<List<WorkoutRecord>>
      loadHistory() async {
    final List<String>? encoded =
        await _prefs.getStringList(
      _historyKey,
    );

    if (encoded == null) {
      return [];
    }

    final List<WorkoutRecord> result = [];

    for (final item in encoded) {
      try {
        final decoded =
            jsonDecode(item);

        result.add(
          WorkoutRecord(
            exerciseName:
                decoded["exerciseName"],
            category:
                decoded["category"],
            date: DateTime.parse(
              decoded["date"],
            ),
            sets:
                (decoded["sets"] as num).toInt(),
            reps:
                (decoded["reps"] as num).toInt(),
            xp:
                (decoded["xp"] as num).toInt(),
            gems:
                (decoded["gems"] as num).toInt(),
          ),
        );
      } catch (_) {
        // Ignore invalid history records.
      }
    }

    return result;
  }

  // =========================
  // ACHIEVEMENTS
  // =========================

  static Future<void> saveClaimedAchievements(
    Set<String> claimed,
  ) async {
    await _prefs.setStringList(
      _claimedAchievementsKey,
      claimed.toList(),
    );
  }

  static Future<Set<String>>
      loadClaimedAchievements() async {
    final values =
        await _prefs.getStringList(
      _claimedAchievementsKey,
    );

    return values?.toSet() ?? {};
  }

  // =========================
  // DAILY QUESTS
  // =========================

  static Future<void> saveQuestData({
    required Map<String, int> progress,
    required Set<String> completed,
    required DateTime currentDay,
  }) async {
    await _prefs.setString(
      _questProgressKey,
      jsonEncode({
        "progress": progress,
        "completed": completed.toList(),
        "day":
            currentDay.toIso8601String(),
      }),
    );
  }

  static Future<Map<String, dynamic>?>
      loadQuestData() async {
    final String? value =
        await _prefs.getString(
      _questProgressKey,
    );

    if (value == null) {
      return null;
    }

    try {
      final decoded = jsonDecode(value);

      return decoded;
    } catch (_) {
      return null;
    }
  }
}