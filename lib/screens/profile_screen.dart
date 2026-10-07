class DailyQuest {
  final String id;
  final String title;
  final String description;
  final String exerciseName;

  final int target;
  final int xpReward;
  final int gemsReward;

  const DailyQuest({
    required this.id,
    required this.title,
    required this.description,
    required this.exerciseName,
    required this.target,
    required this.xpReward,
    required this.gemsReward,
  });
}