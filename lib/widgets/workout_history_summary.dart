import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

class WorkoutHistorySummary extends StatelessWidget {
  final int totalWorkouts;
  final int totalSets;
  final int totalReps;

  const WorkoutHistorySummary({
    super.key,
    required this.totalWorkouts,
    required this.totalSets,
    required this.totalReps,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        AppSpacing.xl,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusXLarge,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _SummaryItem(
              value: "$totalWorkouts",
              label: "WORKOUTS",
            ),
          ),
          _VerticalDivider(),
          Expanded(
            child: _SummaryItem(
              value: "$totalSets",
              label: "SETS",
            ),
          ),
          _VerticalDivider(),
          Expanded(
            child: _SummaryItem(
              value: "$totalReps",
              label: "REPS",
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String value;
  final String label;

  const _SummaryItem({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textMuted,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.7,
          ),
        ),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 38,
      color: AppColors.surfaceLight,
    );
  }
}