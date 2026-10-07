import 'package:flutter/material.dart';

import '../screens/exercise_list_screen.dart';

class WorkoutCard extends StatelessWidget {
  final String title;
  final String emoji;
  final int exerciseCount;
  final String location;

  const WorkoutCard({
    super.key,
    required this.title,
    required this.emoji,
    required this.exerciseCount,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),

      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ExerciseListScreen(
              category: title,
              location: location,
            ),
          ),
        );
      },

      child: Container(
        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(18),
        ),

        child: Row(
          children: [
            Text(
              emoji,
              style: const TextStyle(
                fontSize: 30,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "$exerciseCount exercises available",
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white54,
            ),
          ],
        ),
      ),
    );
  }
}