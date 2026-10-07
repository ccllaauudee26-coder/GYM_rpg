class WorkoutRecord {
  final String exerciseName;
  final String category;
  final DateTime date;
  final int sets;
  final int reps;
  final int xp;
  final int gems;

  const WorkoutRecord({
    required this.exerciseName,
    required this.category,
    required this.date,
    required this.sets,
    required this.reps,
    required this.xp,
    required this.gems,
  });

  Map<String, dynamic> toMap() {
    return {
      "exerciseName": exerciseName,
      "category": category,
      "date": date.toIso8601String(),
      "sets": sets,
      "reps": reps,
      "xp": xp,
      "gems": gems,
    };
  }

  factory WorkoutRecord.fromMap(
    Map<String, dynamic> map,
  ) {
    return WorkoutRecord(
      exerciseName:
          map["exerciseName"] as String,
      category:
          map["category"] as String,
      date:
          DateTime.parse(map["date"] as String),
      sets:
          (map["sets"] as num).toInt(),
      reps:
          (map["reps"] as num).toInt(),
      xp:
          (map["xp"] as num).toInt(),
      gems:
          (map["gems"] as num).toInt(),
    );
  }
}