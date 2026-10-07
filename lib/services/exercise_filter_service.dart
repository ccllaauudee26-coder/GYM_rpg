import '../models/exercise.dart';

class ExerciseFilterService {
  static List<Exercise> filter({
    required List<Exercise> exercises,
    required String category,
    required String location,
    required String searchQuery,
    required String difficulty,
  }) {
    final query = searchQuery.trim().toLowerCase();

    return exercises.where((exercise) {
      // =========================
      // CATEGORY
      // =========================

      final bool matchesCategory =
          exercise.category == category;

      if (!matchesCategory) {
        return false;
      }

      // =========================
      // LOCATION
      // =========================

      bool matchesLocation;

      switch (location) {
        case "HOME":
          matchesLocation = exercise.isHome;
          break;

        case "GYM":
          matchesLocation = exercise.isGym;
          break;

        case "BOTH":
          matchesLocation =
              exercise.isHome && exercise.isGym;
          break;

        default:
          matchesLocation = true;
      }

      if (!matchesLocation) {
        return false;
      }

      // =========================
      // SEARCH
      // =========================

      if (query.isNotEmpty &&
          !exercise.name
              .toLowerCase()
              .contains(query)) {
        return false;
      }

      // =========================
      // DIFFICULTY
      // =========================

      if (difficulty != "ALL" &&
          exercise.difficulty != difficulty) {
        return false;
      }

      return true;
    }).toList();
  }
}