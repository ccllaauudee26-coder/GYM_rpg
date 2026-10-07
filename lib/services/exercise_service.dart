import '../models/exercise.dart';

class ExerciseService {
  static final List<Exercise> exercises = [

    // ================= CHEST =================

    Exercise(
      name: "Push-Up",
      category: "Chest",
      muscleWeights: {
        "Chest": 0.55,
        "Triceps": 0.30,
        "Shoulders": 0.15,
      },
      difficulty: "Beginner",
      isHome: true,
      isGym: true,
      defaultSets: 3,
      defaultReps: 12,
      xp: 10,
      gems: 2,
    ),

    Exercise(
      name: "Wide Push-Up",
      category: "Chest",
      muscleWeights: {
        "Chest": 0.65,
        "Shoulders": 0.20,
        "Triceps": 0.15,
      },
      difficulty: "Beginner",
      isHome: true,
      isGym: true,
      defaultSets: 3,
      defaultReps: 10,
      xp: 10,
      gems: 2,
    ),

    Exercise(
      name: "Diamond Push-Up",
      category: "Chest",
      muscleWeights: {
        "Chest": 0.50,
        "Triceps": 0.35,
        "Shoulders": 0.15,
      },
      difficulty: "Intermediate",
      isHome: true,
      isGym: true,
      defaultSets: 3,
      defaultReps: 10,
      xp: 15,
      gems: 5,
    ),

    Exercise(
      name: "Incline Push-Up",
      category: "Chest",
      muscleWeights: {
        "Chest": 0.55,
        "Triceps": 0.30,
        "Shoulders": 0.15,
      },
      difficulty: "Beginner",
      isHome: true,
      isGym: true,
      defaultSets: 3,
      defaultReps: 12,
      xp: 10,
      gems: 2,
    ),

    Exercise(
      name: "Decline Push-Up",
      category: "Chest",
      muscleWeights: {
        "Chest": 0.50,
        "Shoulders": 0.30,
        "Triceps": 0.20,
      },
      difficulty: "Intermediate",
      isHome: true,
      isGym: true,
      defaultSets: 3,
      defaultReps: 10,
      xp: 15,
      gems: 4,
    ),

    // ================= BACK =================

    Exercise(
      name: "Pull-Up",
      category: "Back",
      muscleWeights: {
        "Back": 0.70,
        "Biceps": 0.30,
      },
      difficulty: "Intermediate",
      isHome: true,
      isGym: true,
      defaultSets: 3,
      defaultReps: 8,
      xp: 15,
      gems: 4,
    ),

    Exercise(
      name: "Chin-Up",
      category: "Back",
      muscleWeights: {
        "Back": 0.55,
        "Biceps": 0.45,
      },
      difficulty: "Intermediate",
      isHome: true,
      isGym: true,
      defaultSets: 3,
      defaultReps: 8,
      xp: 15,
      gems: 4,
    ),

    Exercise(
      name: "Australian Pull-Up",
      category: "Back",
      muscleWeights: {
        "Back": 0.65,
        "Biceps": 0.25,
        "Shoulders": 0.10,
      },
      difficulty: "Beginner",
      isHome: true,
      isGym: true,
      defaultSets: 3,
      defaultReps: 10,
      xp: 12,
      gems: 3,
    ),

    Exercise(
      name: "Dead Hang",
      category: "Back",
      muscleWeights: {
        "Back": 0.45,
        "Shoulders": 0.35,
        "Biceps": 0.20,
      },
      difficulty: "Beginner",
      isHome: true,
      isGym: true,
      defaultSets: 3,
      defaultReps: 30,
      xp: 10,
      gems: 2,
    ),

    // ================= ARMS =================

    Exercise(
      name: "Biceps Curl",
      category: "Arms",
      muscleWeights: {
        "Biceps": 1.0,
      },
      difficulty: "Beginner",
      isHome: true,
      isGym: true,
      defaultSets: 3,
      defaultReps: 12,
      xp: 10,
      gems: 2,
    ),

    Exercise(
      name: "Hammer Curl",
      category: "Arms",
      muscleWeights: {
        "Biceps": 0.85,
        "Forearms": 0.15,
      },
      difficulty: "Beginner",
      isHome: true,
      isGym: true,
      defaultSets: 3,
      defaultReps: 12,
      xp: 10,
      gems: 2,
    ),

    Exercise(
      name: "Triceps Dips",
      category: "Arms",
      muscleWeights: {
        "Triceps": 0.60,
        "Chest": 0.25,
        "Shoulders": 0.15,
      },
      difficulty: "Intermediate",
      isHome: true,
      isGym: true,
      defaultSets: 3,
      defaultReps: 10,
      xp: 15,
      gems: 4,
    ),

    // ================= LEGS =================

    Exercise(
      name: "Bodyweight Squat",
      category: "Legs",
      muscleWeights: {
        "Quadriceps": 0.60,
        "Glutes": 0.40,
      },
      difficulty: "Beginner",
      isHome: true,
      isGym: true,
      defaultSets: 3,
      defaultReps: 15,
      xp: 10,
      gems: 2,
    ),

    Exercise(
      name: "Lunge",
      category: "Legs",
      muscleWeights: {
        "Quadriceps": 0.45,
        "Glutes": 0.40,
        "Hamstrings": 0.15,
      },
      difficulty: "Beginner",
      isHome: true,
      isGym: true,
      defaultSets: 3,
      defaultReps: 10,
      xp: 12,
      gems: 3,
    ),

    Exercise(
      name: "Calf Raise",
      category: "Legs",
      muscleWeights: {
        "Calves": 1.0,
      },
      difficulty: "Beginner",
      isHome: true,
      isGym: true,
      defaultSets: 3,
      defaultReps: 15,
      xp: 10,
      gems: 2,
    ),

    // ================= CORE =================

    Exercise(
      name: "Plank",
      category: "Core",
      muscleWeights: {
        "Core": 0.80,
        "Shoulders": 0.20,
      },
      difficulty: "Beginner",
      isHome: true,
      isGym: true,
      defaultSets: 3,
      defaultReps: 30,
      xp: 10,
      gems: 2,
    ),

    Exercise(
      name: "Crunch",
      category: "Core",
      muscleWeights: {
        "Core": 1.0,
      },
      difficulty: "Beginner",
      isHome: true,
      isGym: true,
      defaultSets: 3,
      defaultReps: 15,
      xp: 10,
      gems: 2,
    ),

    Exercise(
      name: "Leg Raise",
      category: "Core",
      muscleWeights: {
        "Core": 1.0,
      },
      difficulty: "Intermediate",
      isHome: true,
      isGym: true,
      defaultSets: 3,
      defaultReps: 10,
      xp: 12,
      gems: 3,
    ),

    // ================= CARDIO =================

    Exercise(
      name: "Running",
      category: "Cardio",
      muscleWeights: {
        "Quadriceps": 0.30,
        "Hamstrings": 0.20,
        "Glutes": 0.25,
        "Calves": 0.15,
        "Core": 0.10,
      },
      difficulty: "Beginner",
      isHome: true,
      isGym: true,
      defaultSets: 1,
      defaultReps: 10,
      xp: 15,
      gems: 3,
    ),

    Exercise(
      name: "Jumping Jacks",
      category: "Cardio",
      muscleWeights: {
        "Quadriceps": 0.30,
        "Calves": 0.25,
        "Shoulders": 0.20,
        "Core": 0.25,
      },
      difficulty: "Beginner",
      isHome: true,
      isGym: true,
      defaultSets: 3,
      defaultReps: 20,
      xp: 10,
      gems: 2,
    ),
  ];
}