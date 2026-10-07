import 'package:flutter/material.dart';

import '../services/user_progress.dart';
import '../services/workout_statistics_service.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

import '../widgets/app_page.dart';
import '../widgets/app_section_title.dart';
import '../widgets/statistics_card.dart';
import '../widgets/weekly_activity_chart.dart';

class WorkoutStatisticsScreen
    extends StatelessWidget {
  const WorkoutStatisticsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: UserProgress.version,

      builder: (context, _, child) {
        final stats =
            WorkoutStatisticsService.calculate(
          UserProgress.workoutHistory,
        );

        return AppPage(
          title: "STATISTICS",

          body: ListView(
            padding: EdgeInsets.zero,
            children: [
              // =========================
              // WEEKLY ACTIVITY
              // =========================

              WeeklyActivityChart(
                values: stats.weeklyWorkouts,
              ),

              const SizedBox(
                height: AppSpacing.xxxl,
              ),

              // =========================
              // YOUR NUMBERS
              // =========================

              const AppSectionTitle(
                title: "YOUR NUMBERS",
                subtitle:
                    "Your lifetime training stats",
              ),

              const SizedBox(
                height: AppSpacing.md,
              ),

              StatisticsCard(
                title: "Total Workouts",
                value:
                    "${stats.totalWorkouts}",
                icon:
                    Icons.fitness_center_rounded,
              ),

              const SizedBox(
                height: AppSpacing.md,
              ),

              StatisticsCard(
                title: "Total Sets",
                value:
                    "${stats.totalSets}",
                icon:
                    Icons.layers_outlined,
              ),

              const SizedBox(
                height: AppSpacing.md,
              ),

              StatisticsCard(
                title: "Total Reps",
                value:
                    "${stats.totalReps}",
                icon:
                    Icons.repeat_rounded,
              ),

              const SizedBox(
                height: AppSpacing.md,
              ),

              StatisticsCard(
                title: "XP Earned",
                value:
                    "${stats.totalXp}",
                icon:
                    Icons.star_rounded,
              ),

              const SizedBox(
                height: AppSpacing.md,
              ),

              StatisticsCard(
                title: "GEMS Earned",
                value:
                    "${stats.totalGems}",
                icon:
                    Icons.diamond_rounded,
              ),

              const SizedBox(
                height: AppSpacing.xxxl,
              ),

              // =========================
              // MOST TRAINED
              // =========================

              const AppSectionTitle(
                title: "MOST TRAINED",
                subtitle:
                    "Your most frequent activity",
              ),

              const SizedBox(
                height: AppSpacing.md,
              ),

              Container(
                padding:
                    const EdgeInsets.all(
                  AppSpacing.xl,
                ),

                decoration:
                    BoxDecoration(
                  color:
                      AppColors.surface,
                  borderRadius:
                      BorderRadius.circular(
                    AppSpacing.radiusXLarge,
                  ),
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "EXERCISE",
                      style: TextStyle(
                        color:
                            AppColors.textMuted,
                        fontSize: 11,
                        fontWeight:
                            FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
                    ),

                    const SizedBox(
                      height: 6,
                    ),

                    Text(
                      stats.mostTrainedExercise ??
                          "No workouts yet",
                      style:
                          const TextStyle(
                        color:
                            AppColors.textPrimary,
                        fontSize: 22,
                        fontWeight:
                            FontWeight.w800,
                      ),
                    ),

                    const SizedBox(
                      height: AppSpacing.xxl,
                    ),

                    const Divider(
                      color:
                          AppColors.surfaceLight,
                      height: 1,
                    ),

                    const SizedBox(
                      height: AppSpacing.xxl,
                    ),

                    const Text(
                      "CATEGORY",
                      style: TextStyle(
                        color:
                            AppColors.textMuted,
                        fontSize: 11,
                        fontWeight:
                            FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
                    ),

                    const SizedBox(
                      height: 6,
                    ),

                    Text(
                      stats.mostTrainedCategory ??
                          "No category yet",
                      style:
                          const TextStyle(
                        color:
                            AppColors.textPrimary,
                        fontSize: 22,
                        fontWeight:
                            FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: AppSpacing.xxl,
              ),
            ],
          ),
        );
      },
    );
  }
}