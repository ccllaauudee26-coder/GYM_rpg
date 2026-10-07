import 'package:flutter/material.dart';

import '../services/achievement_service.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

class AchievementCard extends StatelessWidget {
  final Achievement achievement;

  final bool unlocked;
  final bool claimed;

  final int totalWorkouts;
  final double progress;

  const AchievementCard({
    super.key,
    required this.achievement,
    required this.unlocked,
    required this.claimed,
    required this.totalWorkouts,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final Color accent =
        claimed
            ? AppColors.success
            : unlocked
                ? AppColors.warning
                : AppColors.textMuted;

    final IconData icon =
        claimed
            ? Icons.check_rounded
            : unlocked
                ? Icons.emoji_events_rounded
                : Icons.lock_outline_rounded;

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
          color: unlocked
              ? accent.withValues(alpha: 0.25)
              : AppColors.surfaceLight,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius:
                      BorderRadius.circular(
                    AppSpacing.radiusMedium,
                  ),
                ),
                child: Icon(
                  icon,
                  color: accent,
                  size: 25,
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
                      achievement.title,
                      maxLines: 2,
                      overflow:
                          TextOverflow.ellipsis,
                      style: const TextStyle(
                        color:
                            AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight:
                            FontWeight.w800,
                      ),
                    ),

                    const SizedBox(
                      height: 5,
                    ),

                    Text(
                      achievement.description,
                      maxLines: 2,
                      overflow:
                          TextOverflow.ellipsis,
                      style: const TextStyle(
                        color:
                            AppColors.textSecondary,
                        fontSize: 12,
                        height: 1.3,
                      ),
                    ),
                  ],
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
                "$totalWorkouts / "
                "${achievement.target}",
                style: const TextStyle(
                  color:
                      AppColors.textSecondary,
                  fontSize: 12,
                  fontWeight:
                      FontWeight.w700,
                ),
              ),

              const Spacer(),

              if (claimed)
                const Text(
                  "CLAIMED",
                  style: TextStyle(
                    color:
                        AppColors.success,
                    fontSize: 11,
                    fontWeight:
                        FontWeight.w800,
                    letterSpacing: 0.6,
                  ),
                )
              else if (unlocked)
                const Text(
                  "UNLOCKED",
                  style: TextStyle(
                    color:
                        AppColors.warning,
                    fontSize: 11,
                    fontWeight:
                        FontWeight.w800,
                    letterSpacing: 0.6,
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
            child:
                LinearProgressIndicator(
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
              _Reward(
                icon: Icons.star_rounded,
                value:
                    "+${achievement.xpReward} XP",
                color: AppColors.xp,
              ),

              const SizedBox(
                width: AppSpacing.lg,
              ),

              _Reward(
                icon: Icons.diamond_rounded,
                value:
                    "+${achievement.gemsReward}",
                color: AppColors.gems,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Reward extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color color;

  const _Reward({
    required this.icon,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 17,
          color: color,
        ),

        const SizedBox(
          width: 5,
        ),

        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight:
                FontWeight.w700,
          ),
        ),
      ],
    );
  }
}