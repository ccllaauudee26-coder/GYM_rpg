import '../models/daily_quest.dart';

import '../services/local_storage_service.dart';

import 'daily_quest_repository.dart';

class LocalDailyQuestRepository
    implements DailyQuestRepository {
  final Map<String, int> _progress = {};

  final Set<String> _completed = {};

  DateTime _currentDay =
      _dateOnly(DateTime.now());

  bool _loaded = false;

  // =========================
  // GETTERS
  // =========================

  Map<String, int> get progress =>
      Map.unmodifiable(_progress);

  Set<String> get completed =>
      Set.unmodifiable(_completed);

  // =========================
  // LOAD
  // =========================

  @override
  Future<void> load() async {
    if (_loaded) {
      return;
    }

    final saved =
        await LocalStorageService
            .loadDailyQuestState();

    final DateTime today =
        _dateOnly(DateTime.now());

    final DateTime? savedDate =
        saved['date'] as DateTime?;

    _progress.clear();
    _completed.clear();

    if (savedDate == null ||
        _dateOnly(savedDate) != today) {
      _currentDay = today;

      await _save();
    } else {
      _currentDay =
          _dateOnly(savedDate);

      final savedProgress =
          saved['progress'];

      if (savedProgress is Map<String, int>) {
        _progress.addAll(
          savedProgress,
        );
      }

      final savedCompleted =
          saved['completed'];

      if (savedCompleted
          is Set<String>) {
        _completed.addAll(
          savedCompleted,
        );
      }
    }

    _loaded = true;
  }

  // =========================
  // GET PROGRESS
  // =========================

  @override
  int getProgress(
    DailyQuest quest,
  ) {
    return _progress[quest.id] ?? 0;
  }

  // =========================
  // COMPLETED
  // =========================

  @override
  bool isCompleted(
    DailyQuest quest,
  ) {
    return _completed.contains(
      quest.id,
    );
  }

  // =========================
  // ADD PROGRESS
  // =========================

  @override
  Future<bool> addProgress({
    required DailyQuest quest,
    required int amount,
  }) async {
    if (!_loaded) {
      await load();
    }

    await resetIfNewDay();

    if (_completed.contains(quest.id)) {
      return false;
    }

    final int current =
        _progress[quest.id] ?? 0;

    final int newProgress =
        current + amount;

    final int clampedProgress =
        newProgress
            .clamp(
              0,
              quest.target,
            )
            .toInt();

    _progress[quest.id] =
        clampedProgress;

    bool justCompleted = false;

    if (clampedProgress >=
            quest.target &&
        !_completed.contains(quest.id)) {
      _completed.add(quest.id);
      justCompleted = true;
    }

    await _save();

    return justCompleted;
  }

  // =========================
  // NEW DAY
  // =========================

  @override
  Future<void> resetIfNewDay() async {
    final DateTime today =
        _dateOnly(DateTime.now());

    if (today == _currentDay) {
      return;
    }

    _currentDay = today;

    _progress.clear();
    _completed.clear();

    await _save();
  }

  // =========================
  // CLEAR
  // =========================

  @override
  Future<void> clear() async {
    _progress.clear();
    _completed.clear();

    _currentDay =
        _dateOnly(DateTime.now());

    _loaded = true;

    await _save();
  }

  // =========================
  // SAVE
  // =========================

  Future<void> _save() async {
    await LocalStorageService
        .saveDailyQuestState(
      progress: _progress,
      completed: _completed,
      date: _currentDay,
    );
  }

  // =========================
  // DATE ONLY
  // =========================

  static DateTime _dateOnly(
    DateTime date,
  ) {
    return DateTime(
      date.year,
      date.month,
      date.day,
    );
  }
}