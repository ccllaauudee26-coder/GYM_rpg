import '../services/local_storage_service.dart';

class MuscleProgressRepository {
  final Map<String, int> _points = {};

  Map<String, int> get points =>
      Map.unmodifiable(_points);

  Future<void> load() async {
    final saved =
        await LocalStorageService.loadMusclePoints();

    _points
      ..clear()
      ..addAll(saved);
  }

  Future<void> addPoints(
    Map<String, int> values,
  ) async {
    values.forEach((muscle, value) {
      _points[muscle] =
          (_points[muscle] ?? 0) + value;
    });

    await LocalStorageService.saveMusclePoints(
      _points,
    );
  }

  Future<void> clear() async {
    _points.clear();

    await LocalStorageService.saveMusclePoints(
      {},
    );
  }
}