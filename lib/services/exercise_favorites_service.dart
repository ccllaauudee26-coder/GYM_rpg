import 'package:shared_preferences/shared_preferences.dart';

class ExerciseFavoritesService {
  static const String _key =
      'provem_favorite_exercises';

  static final SharedPreferencesAsync _prefs =
      SharedPreferencesAsync();

  static final Set<String> favorites = {};

  static bool _loaded = false;

  static Future<void> load() async {
    if (_loaded) {
      return;
    }

    final saved = await _prefs.getStringList(_key);

    favorites
      ..clear()
      ..addAll(saved ?? []);

    _loaded = true;
  }

  static bool isFavorite(String exerciseName) {
    return favorites.contains(exerciseName);
  }

  static Future<void> toggle(
    String exerciseName,
  ) async {
    await load();

    if (favorites.contains(exerciseName)) {
      favorites.remove(exerciseName);
    } else {
      favorites.add(exerciseName);
    }

    await _prefs.setStringList(
      _key,
      favorites.toList(),
    );
  }
}