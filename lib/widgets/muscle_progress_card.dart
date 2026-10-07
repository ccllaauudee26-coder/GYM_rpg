import 'package:flutter/material.dart';

class MuscleProgressCard extends StatelessWidget {
  final String muscle;
  final int points;
  final String rank;
  final double progress;
  final int nextGoal;

  const MuscleProgressCard({
    super.key,
    required this.muscle,
    required this.points,
    required this.rank,
    required this.progress,
    required this.nextGoal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 15,
      ),
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(18),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  muscle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),

              Text(
                rank,
                style: const TextStyle(
                  color: Colors.white70,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          ClipRRect(
            borderRadius:
                BorderRadius.circular(10),

            child: LinearProgressIndicator(
              value: progress,
              minHeight: 9,
              backgroundColor:
                  Colors.grey.shade800,
              valueColor:
                  const AlwaysStoppedAnimation(
                Color(0xFF7B61FF),
              ),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "$points points / $nextGoal points",
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}