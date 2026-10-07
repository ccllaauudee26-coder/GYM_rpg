class DailyQuest {
  final String id;
  final String exerciseName;
  final String title;
  final int target;
  final int xpReward;
  final int gemsReward;

  const DailyQuest({
    required this.id,
    required this.exerciseName,
    required this.title,
    required this.target,
    required this.xpReward,
    required this.gemsReward,
  });
}