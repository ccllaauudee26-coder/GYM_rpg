import '../models/workout_record.dart';

class ActivityService {
  static List<bool> getLast7Days(
    List<WorkoutRecord> history,
  ) {
    final now = DateTime.now();

    final today = DateTime(
      now.year,
      now.month,
      now.day,
    );

    return List.generate(7, (index) {
      final targetDate = today.subtract(
        Duration(days: 6 - index),
      );

      return history.any((workout) {
        final workoutDate = DateTime(
          workout.date.year,
          workout.date.month,
          workout.date.day,
        );

        return workoutDate == targetDate;
      });
    });
  }

  static int getActiveDays(
    List<WorkoutRecord> history,
  ) {
    final days = <String>{};

    for (final workout in history) {
      final date = workout.date;

      days.add(
        "${date.year}-${date.month}-${date.day}",
      );
    }

    return days.length;
  }

  static int getTodayWorkouts(
    List<WorkoutRecord> history,
  ) {
    final now = DateTime.now();

    return history.where((workout) {
      return workout.date.year == now.year &&
          workout.date.month == now.month &&
          workout.date.day == now.day;
    }).length;
  }
}