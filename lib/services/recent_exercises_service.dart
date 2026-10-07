import 'package:shared_preferences/shared_preferences.dart';

class RecentExercisesService {
  static const String _key =
      'provem_recent_exercises';

  static const int maxItems = 10;

  static final SharedPreferencesAsync _prefs =
      SharedPreferencesAsync();

  static final List<String> recent = [];

  static bool _loaded = false;

  static Future<void> load() async {
    if (_loaded) {
      return;
    }

    final saved = await _prefs.getStringList(_key);

    recent
      ..clear()
      ..addAll(saved ?? []);

    _loaded = true;
  }

  static Future<void> add(
    String exerciseName,
  ) async {
    await load();

    recent.remove(exerciseName);
    recent.insert(0, exerciseName);

    if (recent.length > maxItems) {
      recent.removeRange(
        maxItems,
        recent.length,
      );
    }

    await _prefs.setStringList(
      _key,
      recent,
    );
  }
}