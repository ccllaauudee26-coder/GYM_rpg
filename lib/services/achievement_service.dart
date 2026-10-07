class Achievement {
  final String id;
  final String title;
  final String description;
  final int target;
  final int xpReward;
  final int gemsReward;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.target,
    required this.xpReward,
    required this.gemsReward,
  });
}

class AchievementService {
  static const List<Achievement> achievements = [
    Achievement(
      id: "first_workout",
      title: "FIRST STEP",
      description: "Complete your first workout.",
      target: 1,
      xpReward: 50,
      gemsReward: 10,
    ),

    Achievement(
      id: "five_workouts",
      title: "GETTING STARTED",
      description: "Complete 5 workouts.",
      target: 5,
      xpReward: 75,
      gemsReward: 15,
    ),

    Achievement(
      id: "ten_workouts",
      title: "GETTING SERIOUS",
      description: "Complete 10 workouts.",
      target: 10,
      xpReward: 100,
      gemsReward: 20,
    ),

    Achievement(
      id: "twenty_five_workouts",
      title: "DEDICATED",
      description: "Complete 25 workouts.",
      target: 25,
      xpReward: 150,
      gemsReward: 30,
    ),

    Achievement(
      id: "fifty_workouts",
      title: "GYM VETERAN",
      description: "Complete 50 workouts.",
      target: 50,
      xpReward: 250,
      gemsReward: 50,
    ),

    Achievement(
      id: "hundred_workouts",
      title: "ELITE",
      description: "Complete 100 workouts.",
      target: 100,
      xpReward: 500,
      gemsReward: 100,
    ),
  ];
}