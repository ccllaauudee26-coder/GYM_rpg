import '../models/workout_record.dart';
import '../services/local_storage_service.dart';
import 'workout_repository.dart';

class LocalWorkoutRepository
    implements WorkoutRepository {
  final List<WorkoutRecord> _history = [];

  @override
  List<WorkoutRecord> get history =>
      List.unmodifiable(_history);

  @override
  Future<void> load() async {
    final saved =
        await LocalStorageService.loadHistory();

    _history
      ..clear()
      ..addAll(
        saved.map(
          WorkoutRecord.fromMap,
        ),
      );
  }

  @override
  Future<void> addWorkout(
    WorkoutRecord record,
  ) async {
    _history.insert(0, record);

    await LocalStorageService.saveHistory(
      _history
          .map(
            (record) => record.toMap(),
          )
          .toList(),
    );
  }

  @override
  Future<void> clear() async {
    _history.clear();

    await LocalStorageService.saveHistory(
      [],
    );
  }
}