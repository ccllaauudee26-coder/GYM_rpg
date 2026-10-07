import '../services/local_storage_service.dart';
import 'player_repository.dart';

class LocalPlayerRepository
    implements PlayerRepository {
  int _xp = 25;
  int _gems = 0;
  int _streak = 0;

  int _totalWorkouts = 0;
  int _totalSets = 0;
  int _totalReps = 0;

  DateTime? _lastWorkoutDate;

  @override
  int get xp => _xp;

  @override
  int get gems => _gems;

  @override
  int get streak => _streak;

  @override
  int get totalWorkouts => _totalWorkouts;

  @override
  int get totalSets => _totalSets;

  @override
  int get totalReps => _totalReps;

  @override
  DateTime? get lastWorkoutDate =>
      _lastWorkoutDate;

  @override
  Future<void> load() async {
    final data =
        await LocalStorageService.loadPlayer();

    _xp = data['xp'] as int;
    _gems = data['gems'] as int;
    _streak = data['streak'] as int;

    _totalWorkouts =
        data['totalWorkouts'] as int;

    _totalSets =
        data['totalSets'] as int;

    _totalReps =
        data['totalReps'] as int;

    _lastWorkoutDate =
        data['lastWorkoutDate'] as DateTime?;
  }

  @override
  Future<void> save({
    required int xp,
    required int gems,
    required int streak,
    required int totalWorkouts,
    required int totalSets,
    required int totalReps,
    DateTime? lastWorkoutDate,
  }) async {
    _xp = xp;
    _gems = gems;
    _streak = streak;

    _totalWorkouts = totalWorkouts;
    _totalSets = totalSets;
    _totalReps = totalReps;

    _lastWorkoutDate =
        lastWorkoutDate;

    await LocalStorageService.savePlayer(
      xp: _xp,
      gems: _gems,
      streak: _streak,
      totalWorkouts: _totalWorkouts,
      totalSets: _totalSets,
      totalReps: _totalReps,
      lastWorkoutDate:
          _lastWorkoutDate,
    );
  }

  @override
  Future<void> clear() async {
    _xp = 25;
    _gems = 0;
    _streak = 0;

    _totalWorkouts = 0;
    _totalSets = 0;
    _totalReps = 0;

    _lastWorkoutDate = null;

    await LocalStorageService.savePlayer(
      xp: _xp,
      gems: _gems,
      streak: _streak,
      totalWorkouts: _totalWorkouts,
      totalSets: _totalSets,
      totalReps: _totalReps,
      lastWorkoutDate: null,
    );
  }
}