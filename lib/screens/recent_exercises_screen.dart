import 'package:flutter/material.dart';

import '../models/exercise.dart';

import '../services/exercise_service.dart';
import '../services/recent_exercises_service.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

import '../widgets/app_page.dart';
import '../widgets/app_section_title.dart';

import 'exercise_details_screen.dart';

class RecentExercisesScreen
    extends StatefulWidget {
  const RecentExercisesScreen({
    super.key,
  });

  @override
  State<RecentExercisesScreen> createState() =>
      _RecentExercisesScreenState();
}

class _RecentExercisesScreenState
    extends State<RecentExercisesScreen> {
  @override
  void initState() {
    super.initState();

    _loadRecent();
  }

  Future<void> _loadRecent() async {
    await RecentExercisesService.load();

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  List<Exercise> _getRecentExercises() {
    final List<Exercise> result = [];

    for (final name
        in RecentExercisesService.recent) {
      for (final exercise
          in ExerciseService.exercises) {
        if (exercise.name == name) {
          result.add(exercise);
          break;
        }
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final recentExercises =
        _getRecentExercises();

    return AppPage(
      title: "RECENT",

      body: recentExercises.isEmpty
          ? const _EmptyRecent()
          : ListView(
              padding: EdgeInsets.zero,

              children: [
                AppSectionTitle(
                  title:
                      "RECENTLY USED",
                  subtitle:
                      "Your latest exercises",
                ),

                const SizedBox(
                  height: AppSpacing.md,
                ),

                ...recentExercises.map(
                  (exercise) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(
                        bottom:
                            AppSpacing.md,
                      ),

                      child:
                          _RecentExerciseCard(
                        exercise:
                            exercise,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ExerciseDetailsScreen(
                                exercise:
                                    exercise,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
    );
  }
}

class _RecentExerciseCard
    extends StatelessWidget {
  final Exercise exercise;
  final VoidCallback onTap;

  const _RecentExerciseCard({
    required this.exercise,
    required this.onTap,
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
    return Material(
      color: Colors.transparent,

      child: InkWell(
        onTap: onTap,

        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusLarge,
        ),

        child: Ink(
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

          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,

                decoration:
                    BoxDecoration(
                  color:
                      AppColors.surfaceLight,
                  borderRadius:
                      BorderRadius.circular(
                    AppSpacing.radiusMedium,
                  ),
                ),

                child: const Icon(
                  Icons
                      .history_rounded,
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
                    Text(
                      exercise.name,
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,

                      style:
                          const TextStyle(
                        color:
                            AppColors.textPrimary,
                        fontSize: 15,
                        fontWeight:
                            FontWeight.w700,
                      ),
                    ),

                    const SizedBox(
                      height: 5,
                    ),

                    Text(
                      exercise.category,
                      style:
                          const TextStyle(
                        color:
                            AppColors.textMuted,
                        fontSize: 12,
                      ),
                    ),

                    const SizedBox(
                      height: 5,
                    ),

                    Text(
                      exercise.difficulty,
                      style: TextStyle(
                        color:
                            _difficultyColor(),
                        fontSize: 11,
                        fontWeight:
                            FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons
                    .arrow_forward_ios_rounded,
                size: 14,
                color:
                    AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyRecent
    extends StatelessWidget {
  const _EmptyRecent();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.all(
          AppSpacing.xxl,
        ),

        child: Column(
          mainAxisSize:
              MainAxisSize.min,

          children: [
            Container(
              width: 74,
              height: 74,

              decoration:
                  BoxDecoration(
                color:
                    AppColors.surface,
                borderRadius:
                    BorderRadius.circular(
                  AppSpacing.radiusXLarge,
                ),
              ),

              child: const Icon(
                Icons.history_rounded,
                size: 35,
                color:
                    AppColors.textMuted,
              ),
            ),

            const SizedBox(
              height: AppSpacing.lg,
            ),

            const Text(
              "No recent exercises",
              textAlign:
                  TextAlign.center,

              style: TextStyle(
                color:
                    AppColors.textPrimary,
                fontSize: 19,
                fontWeight:
                    FontWeight.w700,
              ),
            ),

            const SizedBox(
              height: AppSpacing.sm,
            ),

            const Text(
              "Exercises you start will appear here.",
              textAlign:
                  TextAlign.center,

              style: TextStyle(
                color:
                    AppColors.textMuted,
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