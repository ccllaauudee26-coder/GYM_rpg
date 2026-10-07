import '../models/daily_quest.dart';

class DailyQuestService {
  static const List<DailyQuest> quests = [
    DailyQuest(
      id: "pushups",
      exerciseName: "Push-Up",
      title: "20 Push-Ups",
      target: 20,
      xpReward: 30,
      gemsReward: 5,
    ),

    DailyQuest(
      id: "squats",
      exerciseName: "Bodyweight Squat",
      title: "30 Squats",
      target: 30,
      xpReward: 30,
      gemsReward: 5,
    ),

    DailyQuest(
      id: "plank",
      exerciseName: "Plank",
      title: "1 Minute Plank",
      target: 60,
      xpReward: 40,
      gemsReward: 7,
    ),
  ];

  static DailyQuest? findForExercise(
    String exerciseName,
  ) {
    for (final quest in quests) {
      if (quest.exerciseName == exerciseName) {
        return quest;
      }
    }

    return null;
  }
}