class ExerciseInfo {
  final String equipment;
  final String description;
  final String tip;

  const ExerciseInfo({
    required this.equipment,
    required this.description,
    required this.tip,
  });
}

class ExerciseInfoService {
  static const Map<String, ExerciseInfo> info = {
    "Push-Up": ExerciseInfo(
      equipment: "None",
      description:
          "A bodyweight pushing exercise that primarily trains the chest, triceps and shoulders.",
      tip:
          "Keep your body straight and control both the lowering and pushing phases.",
    ),

    "Wide Push-Up": ExerciseInfo(
      equipment: "None",
      description:
          "A push-up variation that places more emphasis on the chest.",
      tip:
          "Keep your hands wider than a normal push-up and avoid letting your hips drop.",
    ),

    "Diamond Push-Up": ExerciseInfo(
      equipment: "None",
      description:
          "A challenging push-up variation with greater emphasis on the triceps.",
      tip:
          "Keep your elbows controlled and maintain a straight body position.",
    ),

    "Incline Push-Up": ExerciseInfo(
      equipment: "Bench / Elevated Surface",
      description:
          "An easier push-up variation performed with your hands on an elevated surface.",
      tip:
          "Keep your body aligned and lower your chest toward the surface.",
    ),

    "Decline Push-Up": ExerciseInfo(
      equipment: "Bench / Elevated Surface",
      description:
          "A harder push-up variation with your feet elevated.",
      tip:
          "Keep your core tight and lower yourself under control.",
    ),

    "Pull-Up": ExerciseInfo(
      equipment: "Pull-Up Bar",
      description:
          "A bodyweight pulling exercise targeting the back and biceps.",
      tip:
          "Start from a controlled hang and pull your chest toward the bar.",
    ),

    "Chin-Up": ExerciseInfo(
      equipment: "Pull-Up Bar",
      description:
          "A vertical pulling exercise with a strong contribution from the biceps.",
      tip:
          "Avoid swinging and keep the movement controlled.",
    ),

    "Australian Pull-Up": ExerciseInfo(
      equipment: "Low Bar",
      description:
          "A horizontal pulling exercise suitable for developing pulling strength.",
      tip:
          "Keep your body straight throughout the movement.",
    ),

    "Dead Hang": ExerciseInfo(
      equipment: "Pull-Up Bar",
      description:
          "A hanging exercise focused on grip and upper-body support.",
      tip:
          "Keep your shoulders controlled and avoid unnecessary swinging.",
    ),

    "Biceps Curl": ExerciseInfo(
      equipment: "Dumbbells / Barbell",
      description:
          "An isolation exercise focused primarily on the biceps.",
      tip:
          "Keep your elbows close to your body and avoid using momentum.",
    ),

    "Hammer Curl": ExerciseInfo(
      equipment: "Dumbbells",
      description:
          "A curl variation that works the biceps and forearm muscles.",
      tip:
          "Keep your wrists neutral and move smoothly.",
    ),

    "Triceps Dips": ExerciseInfo(
      equipment: "Parallel Bars / Bench",
      description:
          "A pushing movement that primarily trains the triceps with assistance from the chest and shoulders.",
      tip:
          "Keep the movement controlled and avoid dropping too quickly.",
    ),

    "Bodyweight Squat": ExerciseInfo(
      equipment: "None",
      description:
          "A fundamental lower-body movement targeting the quadriceps and glutes.",
      tip:
          "Keep your knees tracking naturally and maintain control throughout the movement.",
    ),

    "Lunge": ExerciseInfo(
      equipment: "None",
      description:
          "A unilateral lower-body movement targeting the legs and glutes.",
      tip:
          "Keep your torso controlled and push through the working leg.",
    ),

    "Calf Raise": ExerciseInfo(
      equipment: "None / Machine",
      description:
          "An exercise focused primarily on the calf muscles.",
      tip:
          "Use a controlled range of motion instead of bouncing.",
    ),

    "Plank": ExerciseInfo(
      equipment: "None",
      description:
          "An isometric exercise focused primarily on the core.",
      tip:
          "Keep your body in a straight line and avoid letting your hips sag.",
    ),

    "Crunch": ExerciseInfo(
      equipment: "None",
      description:
          "A core exercise focused on controlled trunk flexion.",
      tip:
          "Use your abdominal muscles rather than pulling on your neck.",
    ),

    "Leg Raise": ExerciseInfo(
      equipment: "None",
      description:
          "A core exercise involving controlled raising of the legs.",
      tip:
          "Keep the movement slow and controlled.",
    ),

    "Running": ExerciseInfo(
      equipment: "None / Treadmill",
      description:
          "A cardiovascular exercise involving continuous running.",
      tip:
          "Maintain a comfortable pace and controlled posture.",
    ),

    "Jumping Jacks": ExerciseInfo(
      equipment: "None",
      description:
          "A full-body cardio movement that raises heart rate.",
      tip:
          "Land softly and keep the movement controlled.",
    ),
  };

  static ExerciseInfo getInfo(String exerciseName) {
    return info[exerciseName] ??
        const ExerciseInfo(
          equipment: "Unknown",
          description: "Exercise information is not available yet.",
          tip: "Follow controlled technique.",
        );
  }
}