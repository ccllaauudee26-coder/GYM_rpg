import '../services/achievement_service.dart';
import '../services/local_storage_service.dart';

abstract class AchievementRepository {
  Set<String> get claimed;

  Future<void> load();

  bool isClaimed(Achievement achievement);

  Future<void> claim(Achievement achievement);

  Future<void> clear();
}

class LocalAchievementRepository
    implements AchievementRepository {
  final Set<String> _claimed = {};

  @override
  Set<String> get claimed =>
      Set.unmodifiable(_claimed);

  @override
  Future<void> load() async {
    final saved =
        await LocalStorageService
            .loadAchievements();

    _claimed
      ..clear()
      ..addAll(saved);
  }

  @override
  bool isClaimed(
    Achievement achievement,
  ) {
    return _claimed.contains(
      achievement.id,
    );
  }

  @override
  Future<void> claim(
    Achievement achievement,
  ) async {
    _claimed.add(achievement.id);

    await LocalStorageService
        .saveAchievements(_claimed);
  }

  @override
  Future<void> clear() async {
    _claimed.clear();

    await LocalStorageService
        .saveAchievements(_claimed);
  }
}