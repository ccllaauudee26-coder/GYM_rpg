class MuscleLevelService {
  static String getLevel(int sets) {
    if (sets >= 500) {
      return "TITAN";
    }

    if (sets >= 300) {
      return "DIAMOND";
    }

    if (sets >= 180) {
      return "MASTER";
    }

    if (sets >= 100) {
      return "PLATINUM";
    }

    if (sets >= 50) {
      return "SILVER";
    }

    return "BRONZE";
  }

  static double getProgress(int sets) {
    if (sets >= 500) {
      return 1.0;
    }

    if (sets >= 300) {
      return (sets - 300) / 200;
    }

    if (sets >= 180) {
      return (sets - 180) / 120;
    }

    if (sets >= 100) {
      return (sets - 100) / 80;
    }

    if (sets >= 50) {
      return (sets - 50) / 50;
    }

    return sets / 50;
  }

  static int getNextGoal(int sets) {
    if (sets < 50) {
      return 50;
    }

    if (sets < 100) {
      return 100;
    }

    if (sets < 180) {
      return 180;
    }

    if (sets < 300) {
      return 300;
    }

    if (sets < 500) {
      return 500;
    }

    return 500;
  }
}