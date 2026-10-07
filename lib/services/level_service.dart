class LevelService {
  const LevelService._();

  static const int xpPerLevel = 100;

  static int getLevel(int totalXp) {
    if (totalXp < 0) {
      return 1;
    }

    return (totalXp ~/ xpPerLevel) + 1;
  }

  static int getCurrentLevelXp(int totalXp) {
    if (totalXp < 0) {
      return 0;
    }

    return totalXp % xpPerLevel;
  }

  static double getProgress(int totalXp) {
    if (totalXp <= 0) {
      return 0;
    }

    return getCurrentLevelXp(totalXp) / xpPerLevel;
  }

  static int getXpToNextLevel(int totalXp) {
    final currentXp = getCurrentLevelXp(totalXp);

    return xpPerLevel - currentXp;
  }
}