class RankService {
  static const List<String> ranks = [
    "ROOKIE",
    "BEGINNER",
    "ATHLETE",
    "ADVANCED",
    "PRO",
    "BEAST",
    "LEGEND",
    "TITAN",
  ];

  static const List<int> goals = [
    0,
    100,
    300,
    600,
    1000,
    1500,
    2500,
    4000,
  ];

  static int _getRankIndex(int points) {
    int index = 0;

    for (int i = 0; i < goals.length; i++) {
      if (points >= goals[i]) {
        index = i;
      } else {
        break;
      }
    }

    return index;
  }

  static String getRank(int points) {
    return ranks[_getRankIndex(points)];
  }

  static double getProgress(int points) {
    final int index = _getRankIndex(points);

    if (index >= goals.length - 1) {
      return 1.0;
    }

    final int currentGoal = goals[index];
    final int nextGoal = goals[index + 1];

    return ((points - currentGoal) /
            (nextGoal - currentGoal))
        .clamp(0.0, 1.0);
  }

  static int getNextGoal(int points) {
    for (final goal in goals) {
      if (points < goal) {
        return goal;
      }
    }

    return goals.last;
  }
}