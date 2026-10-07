import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

class WorkoutSetCard extends StatelessWidget {
  final int setNumber;
  final int reps;
  final bool disabled;

  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  const WorkoutSetCard({
    super.key,
    required this.setNumber,
    required this.reps,
    required this.disabled,
    required this.onDecrease,
    required this.onIncrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: AppSpacing.md,
      ),
      padding: const EdgeInsets.all(
        AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusLarge,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(
                AppSpacing.radiusMedium,
              ),
            ),
            child: Center(
              child: Text(
                "$setNumber",
                style: const TextStyle(
                  color: AppColors.primaryLight,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),

          const SizedBox(
            width: AppSpacing.md,
          ),

          const Expanded(
            child: Text(
              "REPS",
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
          ),

          IconButton(
            onPressed:
                disabled ? null : onDecrease,
            icon: const Icon(
              Icons.remove_rounded,
            ),
            color: AppColors.textSecondary,
          ),

          SizedBox(
            width: 42,
            child: Center(
              child: Text(
                "$reps",
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),

          IconButton(
            onPressed:
                disabled ? null : onIncrease,
            icon: const Icon(
              Icons.add_rounded,
            ),
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }
}