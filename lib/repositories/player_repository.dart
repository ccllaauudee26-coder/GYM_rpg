abstract class PlayerRepository {
  int get xp;
  int get gems;
  int get streak;

  int get totalWorkouts;
  int get totalSets;
  int get totalReps;

  DateTime? get lastWorkoutDate;

  Future<void> load();

  Future<void> save({
    required int xp,
    required int gems,
    required int streak,
    required int totalWorkouts,
    required int totalSets,
    required int totalReps,
    DateTime? lastWorkoutDate,
  });

  Future<void> clear();
}