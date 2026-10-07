import 'package:flutter/material.dart';

import '../services/workout_live_summary_service.dart';

class WorkoutLiveSummaryCard extends StatelessWidget {
  final WorkoutLiveSummary summary;

  const WorkoutLiveSummaryCard({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          const Text(
            "LIVE REWARD",
            style: TextStyle(
              color: Colors.white54,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _Stat(
                  title: "SETS",
                  value: "${summary.sets}",
                ),
              ),

              Expanded(
                child: _Stat(
                  title: "REPS",
                  value: "${summary.reps}",
                ),
              ),

              Expanded(
                child: _Stat(
                  title: "XP",
                  value: "+${summary.xp}",
                ),
              ),

              Expanded(
                child: _Stat(
                  title: "GEMS",
                  value: "+${summary.gems}",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String title;
  final String value;

  const _Stat({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 10,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}