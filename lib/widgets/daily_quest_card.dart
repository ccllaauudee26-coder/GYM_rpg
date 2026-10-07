import 'package:flutter/material.dart';

import '../services/user_progress.dart';

import '../view_models/daily_quest_view_model.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

import 'daily_quest_item.dart';

class DailyQuestCard extends StatefulWidget {
  const DailyQuestCard({
    super.key,
  });

  @override
  State<DailyQuestCard> createState() =>
      _DailyQuestCardState();
}

class _DailyQuestCardState
    extends State<DailyQuestCard> {
  late final DailyQuestViewModel viewModel;

  @override
  void initState() {
    super.initState();

    viewModel =
        DailyQuestViewModel();

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

    viewModel.refreshUI();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: viewModel,
      builder: (context, child) {
        final quests =
            viewModel.quests;

        final int completedCount =
            quests.where(
          viewModel.isCompleted,
        ).length;

        return Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "DAILY QUEST",
                        style:
                            AppTypography.headingMedium,
                      ),

                      const SizedBox(
                        height: AppSpacing.xs,
                      ),

                      Text(
                        "$completedCount / "
                        "${quests.length} completed",
                        style:
                            AppTypography.bodySmall,
                      ),
                    ],
                  ),
                ),

                Container(
                  width: 38,
                  height: 38,
                  decoration:
                      BoxDecoration(
                    color:
                        AppColors.surface,
                    borderRadius:
                        BorderRadius.circular(
                      12,
                    ),
                  ),
                  child: const Icon(
                    Icons
                        .military_tech_rounded,
                    color:
                        AppColors.warning,
                    size: 21,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: AppSpacing.md,
            ),

            if (quests.isEmpty)
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.all(
                  AppSpacing.lg,
                ),
                decoration:
                    BoxDecoration(
                  color:
                      AppColors.surface,
                  borderRadius:
                      BorderRadius.circular(
                    AppSpacing.radiusLarge,
                  ),
                ),
                child: const Text(
                  "No daily quests available.",
                  style:
                      AppTypography.bodyMedium,
                ),
              )
            else
              ...quests.map(
                (quest) {
                  final int current =
                      viewModel.getProgress(
                    quest,
                  );

                  final bool completed =
                      viewModel.isCompleted(
                    quest,
                  );

                  final double progress =
                      viewModel
                          .getProgressRatio(
                    quest,
                  );

                  return DailyQuestItem(
                    quest: quest,
                    current: current,
                    completed: completed,
                    progress: progress,
                  );
                },
              ),
          ],
        );
      },
    );
  }
}