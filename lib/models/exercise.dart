class Exercise {
  final String name;

  // Workout category:
  // Chest, Back, Arms, Legs, Core, Cardio
  final String category;

  // Actual muscles worked by this exercise.
  // Example:
  // Triceps Dips ->
  // Triceps: 0.60
  // Chest: 0.25
  // Shoulders: 0.15
  final Map<String, double> muscleWeights;

  final String difficulty;

  final bool isHome;
  final bool isGym;

  final int defaultSets;
  final int defaultReps;

  final int xp;
  final int gems;

  const Exercise({
    required this.name,
    required this.category,
    required this.muscleWeights,
    required this.difficulty,
    required this.isHome,
    required this.isGym,
    required this.defaultSets,
    required this.defaultReps,
    required this.xp,
    required this.gems,
  });
}