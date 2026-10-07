import 'package:flutter/material.dart';

import '../models/exercise.dart';

import '../services/exercise_service.dart';
import '../services/level_service.dart';
import '../services/user_progress.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

import '../widgets/app_card.dart';
import '../widgets/app_section_title.dart';
import '../widgets/app_stat_card.dart';
import '../widgets/daily_quest_card.dart';
import '../widgets/home_header.dart';
import '../widgets/quick_start_card.dart';
import '../widgets/xp_progress_card.dart';

import 'exercise_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    UserProgress.version.addListener(
      _onProgressChanged,
    );
  }

  @override
  void dispose() {
    UserProgress.version.removeListener(
      _onProgressChanged,
    );

    super.dispose();
  }

  void _onProgressChanged() {
    if (!mounted) {
      return;
    }

    setState(() {});
  }

  Exercise _getQuickStartExercise() {
    if (UserProgress.workoutHistory.isNotEmpty) {
      final recentRecord =
          UserProgress.workoutHistory.last;

      for (final exercise
          in ExerciseService.exercises) {
        if (exercise.name ==
            recentRecord.exerciseName) {
          return exercise;
        }
      }
    }

    return ExerciseService.exercises.first;
  }

  @override
  Widget build(BuildContext context) {
    final int xp = UserProgress.xp;

    final int level =
        LevelService.getLevel(xp);

    final int currentLevelXp =
        LevelService.getCurrentLevelXp(xp);

    final double progress =
        LevelService.getProgress(xp);

    final Exercise quickStartExercise =
        _getQuickStartExercise();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            UserProgress.refresh();
          },
          child: SingleChildScrollView(
            physics:
                const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.page,
              AppSpacing.lg,
              AppSpacing.page,
              32,
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                HomeHeader(
                  name: 'Alex',
                  streak: UserProgress.streak,
                ),

                const SizedBox(
                  height: AppSpacing.xxl,
                ),

                XpProgressCard(
                  level: level,
                  currentXp: currentLevelXp,
                  progress: progress,
                ),

                const SizedBox(
                  height: AppSpacing.lg,
                ),

                Row(
                  children: [
                    Expanded(
                      child: AppStatCard(
                        label: 'GEMS',
                        value:
                            '${UserProgress.gems}',
                        icon:
                            Icons.diamond_rounded,
                        iconColor:
                            AppColors.gems,
                      ),
                    ),
                    const SizedBox(
                      width: AppSpacing.md,
                    ),
                    Expanded(
                      child: AppStatCard(
                        label: 'STREAK',
                        value:
                            '${UserProgress.streak}',
                        icon:
                            Icons
                                .local_fire_department_rounded,
                        iconColor:
                            AppColors.warning,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: AppSpacing.md,
                ),

                Row(
                  children: [
                    Expanded(
                      child: AppStatCard(
                        label: 'WORKOUTS',
                        value:
                            '${UserProgress.totalWorkouts}',
                        icon:
                            Icons
                                .fitness_center_rounded,
                        iconColor:
                            AppColors.primaryLight,
                      ),
                    ),
                    const SizedBox(
                      width: AppSpacing.md,
                    ),
                    Expanded(
                      child: AppStatCard(
                        label: 'REPS',
                        value:
                            '${UserProgress.totalReps}',
                        icon:
                            Icons.repeat_rounded,
                        iconColor:
                            AppColors.info,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: AppSpacing.xxl,
                ),

                const AppSectionTitle(
                  title: 'DAILY QUEST',
                ),

                const SizedBox(
                  height: AppSpacing.md,
                ),

                const DailyQuestCard(),

                const SizedBox(
                  height: AppSpacing.xxl,
                ),

                const AppSectionTitle(
                  title: 'QUICK START',
                ),

                const SizedBox(
                  height: AppSpacing.md,
                ),

                QuickStartCard(
                  exercise:
                      quickStartExercise,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ExerciseDetailsScreen(
                          exercise:
                              quickStartExercise,
                        ),
                      ),
                    );
                  },
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
                        width: 46,
                        height: 46,
                        decoration:
                            BoxDecoration(
                          color: AppColors.primary
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
                              .auto_graph_rounded,
                          color:
                              AppColors.primaryLight,
                          size: 24,
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
                              'KEEP PROVING IT',
                              style:
                                  AppTypography.headingSmall,
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              UserProgress.streak == 0
                                  ? 'Complete your first workout today.'
                                  : 'Stay consistent and build your streak.',
                              style:
                                  AppTypography.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
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