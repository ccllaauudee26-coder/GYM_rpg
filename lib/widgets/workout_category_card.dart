import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

import 'app_badge.dart';

class WorkoutCategoryCard extends StatelessWidget {
  final String title;
  final String emoji;
  final int exerciseCount;
  final VoidCallback onTap;

  const WorkoutCategoryCard({
    super.key,
    required this.title,
    required this.emoji,
    required this.exerciseCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(
            AppSpacing.radiusLarge,
          ),
          border: Border.all(
            color: AppColors.surfaceLight,
            width: 0.7,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(
            AppSpacing.radiusLarge,
          ),
          child: Padding(
            padding: const EdgeInsets.all(
              AppSpacing.lg,
            ),
            child: Row(
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(
                      AppSpacing.radiusMedium,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      emoji,
                      style: const TextStyle(
                        fontSize: 28,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  width: AppSpacing.md,
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            AppTypography.headingSmall,
                      ),

                      const SizedBox(
                        height: AppSpacing.xs,
                      ),

                      AppBadge(
                        text: '$exerciseCount exercises',
                        color: AppColors.textSecondary,
                        backgroundColor:
                            AppColors.surfaceLight,
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  width: AppSpacing.sm,
                ),

                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(
                      AppSpacing.radiusSmall,
                    ),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 13,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}