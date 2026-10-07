import 'package:flutter/material.dart';

import '../models/exercise.dart';

import '../services/exercise_filter_service.dart';
import '../services/exercise_service.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

import '../widgets/app_card.dart';
import '../widgets/app_section_title.dart';
import '../widgets/difficulty_selector.dart';

import 'exercise_details_screen.dart';

class ExerciseListScreen
    extends StatefulWidget {
  final String category;
  final String location;

  const ExerciseListScreen({
    super.key,
    required this.category,
    required this.location,
  });

  @override
  State<ExerciseListScreen> createState() =>
      _ExerciseListScreenState();
}

class _ExerciseListScreenState
    extends State<ExerciseListScreen> {
  final TextEditingController
      searchController =
      TextEditingController();

  String selectedDifficulty = "ALL";

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<Exercise> _getExercises() {
    return ExerciseFilterService.filter(
      exercises:
          ExerciseService.exercises,
      category:
          widget.category,
      location:
          widget.location,
      searchQuery:
          searchController.text,
      difficulty:
          selectedDifficulty,
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final exercises =
        _getExercises();

    return Scaffold(
      backgroundColor:
          AppColors.background,

      appBar: AppBar(
        backgroundColor:
            AppColors.background,
        elevation: 0,

        titleSpacing:
            AppSpacing.page,

        title: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              widget.category,
              style: const TextStyle(
                color:
                    AppColors.textPrimary,
                fontSize: 20,
                fontWeight:
                    FontWeight.w800,
              ),
            ),

            const SizedBox(
              height: 2,
            ),

            Text(
              widget.location,
              style: const TextStyle(
                color:
                    AppColors.textMuted,
                fontSize: 11,
                fontWeight:
                    FontWeight.w600,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),

      body: SafeArea(
        top: false,

        child: Column(
          children: [
            // =========================
            // SEARCH
            // =========================

            Padding(
              padding:
                  const EdgeInsets.fromLTRB(
                AppSpacing.page,
                AppSpacing.sm,
                AppSpacing.page,
                AppSpacing.md,
              ),

              child: TextField(
                controller:
                    searchController,

                onChanged: (_) {
                  setState(() {});
                },

                style: const TextStyle(
                  color:
                      AppColors.textPrimary,
                ),

                decoration:
                    InputDecoration(
                  hintText:
                      "Search exercises...",

                  prefixIcon:
                      const Icon(
                    Icons.search_rounded,
                  ),

                  suffixIcon:
                      searchController
                              .text
                              .isEmpty
                          ? null
                          : IconButton(
                              onPressed: () {
                                searchController
                                    .clear();

                                setState(() {});
                              },
                              icon:
                                  const Icon(
                                Icons
                                    .close_rounded,
                              ),
                            ),
                ),
              ),
            ),

            // =========================
            // DIFFICULTY
            // =========================

            Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal:
                    AppSpacing.page,
              ),

              child:
                  DifficultySelector(
                selected:
                    selectedDifficulty,

                onChanged:
                    (difficulty) {
                  setState(() {
                    selectedDifficulty =
                        difficulty;
                  });
                },
              ),
            ),

            const SizedBox(
              height: AppSpacing.lg,
            ),

            // =========================
            // RESULTS HEADER
            // =========================

            Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal:
                    AppSpacing.page,
              ),

              child:
                  AppSectionTitle(
                title:
                    "EXERCISES",

                subtitle:
                    "${exercises.length} available",
              ),
            ),

            const SizedBox(
              height: AppSpacing.md,
            ),

            // =========================
            // LIST
            // =========================

            Expanded(
              child: exercises.isEmpty
                  ? const _EmptyResults()
                  : ListView.builder(
                      padding:
                          const EdgeInsets.fromLTRB(
                        AppSpacing.page,
                        0,
                        AppSpacing.page,
                        28,
                      ),

                      itemCount:
                          exercises.length,

                      itemBuilder:
                          (context, index) {
                        final exercise =
                            exercises[index];

                        return Padding(
                          padding:
                              const EdgeInsets
                                  .only(
                            bottom:
                                AppSpacing.md,
                          ),

                          child:
                              _ExerciseCard(
                            exercise:
                                exercise,

                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) =>
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
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// EXERCISE CARD
// ============================================================

class _ExerciseCard
    extends StatelessWidget {
  final Exercise exercise;
  final VoidCallback onTap;

  const _ExerciseCard({
    required this.exercise,
    required this.onTap,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return AppCard(
      padding:
          const EdgeInsets.all(
        AppSpacing.lg,
      ),

      onTap: onTap,

      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,

            decoration: BoxDecoration(
              color:
                  AppColors.surfaceLight,

              borderRadius:
                  BorderRadius.circular(
                AppSpacing.radiusMedium,
              ),
            ),

            child: const Icon(
              Icons.fitness_center,
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
                    fontSize: 16,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),

                Text(
                  "${exercise.difficulty} • "
                  "${exercise.defaultSets} × "
                  "${exercise.defaultReps}",

                  style:
                      const TextStyle(
                    color:
                        AppColors.textMuted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            width: AppSpacing.sm,
          ),

          const Icon(
            Icons
                .arrow_forward_ios_rounded,
            size: 15,
            color:
                AppColors.textMuted,
          ),
        ],
      ),
    );
  }
}

// ============================================================
// EMPTY RESULTS
// ============================================================

class _EmptyResults
    extends StatelessWidget {
  const _EmptyResults();

  @override
  Widget build(
    BuildContext context,
  ) {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.all(
          30,
        ),

        child: Column(
          mainAxisSize:
              MainAxisSize.min,

          children: [
            Container(
              width: 70,
              height: 70,

              decoration:
                  BoxDecoration(
                color:
                    AppColors.surface,
                borderRadius:
                    BorderRadius.circular(
                  22,
                ),
              ),

              child: const Icon(
                Icons.search_off_rounded,
                size: 32,
                color:
                    AppColors.textMuted,
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            const Text(
              "No exercises found",
              style: TextStyle(
                color:
                    AppColors.textPrimary,
                fontSize: 18,
                fontWeight:
                    FontWeight.w700,
              ),
            ),

            const SizedBox(
              height: 6,
            ),

            const Text(
              "Try another search or difficulty.",
              textAlign:
                  TextAlign.center,

              style: TextStyle(
                color:
                    AppColors.textMuted,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}