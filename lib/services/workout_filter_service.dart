import '../models/exercise.dart';

class WorkoutFilterService {
  static List<Exercise> filterByLocation({
    required List<Exercise> exercises,
    required String location,
  }) {
    switch (location) {
      case "HOME":
        return exercises
            .where((exercise) => exercise.isHome)
            .toList();

      case "GYM":
        return exercises
            .where((exercise) => exercise.isGym)
            .toList();

      case "BOTH":
        return exercises
            .where(
              (exercise) =>
                  exercise.isHome &&
                  exercise.isGym,
            )
            .toList();

      default:
        return exercises;
    }
  }
}