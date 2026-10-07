class Player {
  String name;
  int level;
  int xp;
  int xpToNextLevel;
  int gems;
  int streak;

  Player({
    required this.name,
    required this.level,
    required this.xp,
    required this.xpToNextLevel,
    required this.gems,
    required this.streak,
  });
}