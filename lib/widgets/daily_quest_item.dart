import 'package:flutter/material.dart';

import '../models/daily_quest.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

class DailyQuestItem extends StatelessWidget {
  final DailyQuest quest;
  final int current;
  final bool completed;
  final double progress;

  const DailyQuestItem({
    super.key,
    required this.quest,
    required this.current,
    required this.completed,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final Color accent = completed
        ? AppColors.success
        : AppColors.primary;

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
        border: Border.all(
          color: completed
              ? AppColors.success.withValues(
                  alpha: 0.18,
                )
              : AppColors.surfaceLight,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius:
                      BorderRadius.circular(12),
                ),
                child: Icon(
                  completed
                      ? Icons.check_rounded
                      : Icons.flag_rounded,
                  color: accent,
                  size: 21,
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
                      quest.title,
                      maxLines: 2,
                      overflow:
                          TextOverflow.ellipsis,
                      style: AppTypography.headingSmall,
                    ),

                    const SizedBox(
                      height: AppSpacing.xs,
                    ),

                    Text(
                      completed
                          ? "Quest completed"
                          : "Daily objective",
                      style: AppTypography.bodySmall,
                    ),
                  ],
                ),
              ),

              if (completed)
                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(
                      alpha: 0.12,
                    ),
                    borderRadius:
                        BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "DONE",
                    style: TextStyle(
                      color: AppColors.success,
                      fontSize: 10,
                      fontWeight:
                          FontWeight.w800,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          Row(
            children: [
              Text(
                "$current / ${quest.target}",
                style: AppTypography.labelPrimary,
              ),

              const Spacer(),

              Text(
                "${(progress * 100).round()}%",
                style: TextStyle(
                  color: completed
                      ? AppColors.success
                      : AppColors.primaryLight,
                  fontSize: 12,
                  fontWeight:
                      FontWeight.w800,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: AppSpacing.sm,
          ),

          ClipRRect(
            borderRadius:
                BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor:
                  AppColors.surfaceLight,
              valueColor:
                  AlwaysStoppedAnimation<Color>(
                accent,
              ),
            ),
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          Row(
            children: [
              const Icon(
                Icons.star_rounded,
                size: 17,
                color: AppColors.xp,
              ),

              const SizedBox(
                width: 5,
              ),

              Text(
                "+${quest.xpReward} XP",
                style: const TextStyle(
                  color: AppColors.xp,
                  fontSize: 12,
                  fontWeight:
                      FontWeight.w700,
                ),
              ),

              const SizedBox(
                width: AppSpacing.lg,
              ),

              const Icon(
                Icons.diamond_rounded,
                size: 17,
                color: AppColors.gems,
              ),

              const SizedBox(
                width: 5,
              ),

              Text(
                "+${quest.gemsReward}",
                style: const TextStyle(
                  color: AppColors.gems,
                  fontSize: 12,
                  fontWeight:
                      FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}