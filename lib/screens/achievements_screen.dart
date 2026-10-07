import 'package:flutter/material.dart';

import '../services/user_progress.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

import '../view_models/achievements_view_model.dart';

import '../widgets/achievement_card.dart';
import '../widgets/app_card.dart';
import '../widgets/app_page.dart';
import '../widgets/app_section_title.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() =>
      _AchievementsScreenState();
}

class _AchievementsScreenState
    extends State<AchievementsScreen> {
  late final AchievementsViewModel viewModel;

  @override
  void initState() {
    super.initState();

    viewModel = AchievementsViewModel();

    UserProgress.version.addListener(
      _onProgressChanged,
    );
  }

  @override
  void dispose() {
    UserProgress.version.removeListener(
      _onProgressChanged,
    );

    viewModel.dispose();

    super.dispose();
  }

  void _onProgressChanged() {
    if (!mounted) {
      return;
    }

    viewModel.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: viewModel,
      builder: (context, _) {
        final achievements =
            viewModel.achievements;

        final unlockedCount =
            achievements
                .where(
                  viewModel.isUnlocked,
                )
                .length;

        final claimedCount =
            achievements
                .where(
                  viewModel.isClaimed,
                )
                .length;

        return AppPage(
          title: 'ACHIEVEMENTS',
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.page,
            AppSpacing.sm,
            AppSpacing.page,
            30,
          ),
          body: ListView(
            children: [
              const Text(
                'PROVE YOUR PROGRESS',
                style: AppTypography.headingLarge,
              ),

              const SizedBox(
                height: AppSpacing.xs,
              ),

              const Text(
                'Complete workouts and unlock milestones.',
                style: AppTypography.bodyMedium,
              ),

              const SizedBox(
                height: AppSpacing.xxl,
              ),

              Row(
                children: [
                  Expanded(
                    child: _SummaryCard(
                      icon:
                          Icons.emoji_events_rounded,
                      label: 'UNLOCKED',
                      value:
                          '$unlockedCount',
                      color:
                          AppColors.warning,
                    ),
                  ),
                  const SizedBox(
                    width: AppSpacing.md,
                  ),
                  Expanded(
                    child: _SummaryCard(
                      icon:
                          Icons.check_circle_rounded,
                      label: 'CLAIMED',
                      value:
                          '$claimedCount',
                      color:
                          AppColors.success,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: AppSpacing.xxl,
              ),

              AppCard(
                padding: const EdgeInsets.all(
                  AppSpacing.lg,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration:
                          BoxDecoration(
                        color:
                            AppColors.primary
                                .withValues(
                          alpha: 0.12,
                        ),
                        borderRadius:
                            BorderRadius.circular(
                          AppSpacing.radiusMedium,
                        ),
                      ),
                      child: const Icon(
                        Icons
                            .fitness_center_rounded,
                        color:
                            AppColors.primaryLight,
                        size: 23,
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
                          const Text(
                            'YOUR WORKOUTS',
                            style:
                                AppTypography.label,
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            '${viewModel.totalWorkouts} total workouts',
                            style:
                                AppTypography.headingSmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: AppSpacing.xxl,
              ),

              const AppSectionTitle(
                title: 'ALL ACHIEVEMENTS',
              ),

              const SizedBox(
                height: AppSpacing.md,
              ),

              ...achievements.map(
                (achievement) {
                  final unlocked =
                      viewModel.isUnlocked(
                    achievement,
                  );

                  final claimed =
                      viewModel.isClaimed(
                    achievement,
                  );

                  final progress =
                      viewModel.getProgress(
                    achievement,
                  );

                  return AchievementCard(
                    achievement:
                        achievement,
                    unlocked:
                        unlocked,
                    claimed:
                        claimed,
                    totalWorkouts:
                        viewModel.totalWorkouts,
                    progress:
                        progress,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _SummaryCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(
        AppSpacing.lg,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(
                alpha: 0.12,
              ),
              borderRadius:
                  BorderRadius.circular(
                AppSpacing.radiusSmall,
              ),
            ),
            child: Icon(
              icon,
              color: color,
              size: 21,
            ),
          ),

          const SizedBox(
            height: AppSpacing.md,
          ),

          Text(
            label,
            style: AppTypography.label,
          ),

          const SizedBox(
            height: 2,
          ),

          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}