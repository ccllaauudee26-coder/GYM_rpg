import '../models/workout_record.dart';

abstract class WorkoutRepository {
  List<WorkoutRecord> get history;

  Future<void> addWorkout(
    WorkoutRecord record,
  );

  Future<void> load();

  Future<void> clear();
}