import 'package:flutter/material.dart';

import '../models/exercise.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

class WorkoutSessionHeader
    extends StatelessWidget {
  final Exercise exercise;

  const WorkoutSessionHeader({
    super.key,
    required this.exercise,
  });

  Color _difficultyColor() {
    switch (exercise.difficulty) {
      case "Beginner":
        return AppColors.success;

      case "Intermediate":
        return AppColors.warning;

      case "Advanced":
        return AppColors.error;

      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          exercise.name,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 30,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.8,
          ),
        ),

        const SizedBox(
          height: AppSpacing.sm,
        ),

        Row(
          children: [
            _Tag(
              text: exercise.category,
              color: AppColors.primaryLight,
            ),

            const SizedBox(
              width: AppSpacing.sm,
            ),

            _Tag(
              text: exercise.difficulty,
              color: _difficultyColor(),
            ),
          ],
        ),
      ],
    );
  }
}

class _Tag extends StatelessWidget {
  final String text;
  final Color color;

  const _Tag({
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}