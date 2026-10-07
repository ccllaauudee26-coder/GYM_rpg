import 'package:flutter/material.dart';

import '../services/user_progress.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

import '../widgets/app_page.dart';
import '../widgets/app_section_title.dart';
import '../widgets/workout_history_card.dart';
import '../widgets/workout_history_summary.dart';

class WorkoutHistoryScreen extends StatelessWidget {
  const WorkoutHistoryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: UserProgress.version,
      builder: (context, _, child) {
        final history = UserProgress.workoutHistory;

        final int totalWorkouts = history.length;

        final int totalSets = history.fold(
          0,
          (sum, record) => sum + record.sets,
        );

        final int totalReps = history.fold(
          0,
          (sum, record) => sum + record.reps,
        );

        if (history.isEmpty) {
          return AppPage(
            title: "WORKOUT HISTORY",
            body: const _EmptyHistory(),
          );
        }

        return AppPage(
          title: "WORKOUT HISTORY",

          body: ListView(
            padding: EdgeInsets.zero,
            children: [
              WorkoutHistorySummary(
                totalWorkouts: totalWorkouts,
                totalSets: totalSets,
                totalReps: totalReps,
              ),

              const SizedBox(
                height: AppSpacing.xxxl,
              ),

              const AppSectionTitle(
                title: "RECENT WORKOUTS",
                subtitle: "Your completed sessions",
              ),

              const SizedBox(
                height: AppSpacing.md,
              ),

              ...history.map(
                (record) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppSpacing.md,
                    ),
                    child: WorkoutHistoryCard(
                      record: record,
                    ),
                  );
                },
              ),

              const SizedBox(
                height: AppSpacing.sm,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _EmptyHistory extends StatelessWidget {
  const _EmptyHistory();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(
          AppSpacing.xxl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(
                  AppSpacing.radiusXLarge,
                ),
              ),
              child: const Icon(
                Icons.history_rounded,
                size: 34,
                color: AppColors.textMuted,
              ),
            ),

            const SizedBox(
              height: AppSpacing.lg,
            ),

            const Text(
              "No workouts yet",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(
              height: AppSpacing.sm,
            ),

            const Text(
              "Complete your first workout "
              "and it will appear here.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}