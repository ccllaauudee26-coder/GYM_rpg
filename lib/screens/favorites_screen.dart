import 'package:flutter/material.dart';

import '../services/exercise_favorites_service.dart';
import '../services/exercise_service.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

import '../widgets/app_page.dart';
import '../widgets/app_section_title.dart';

import 'exercise_details_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({
    super.key,
  });

  @override
  State<FavoritesScreen> createState() =>
      _FavoritesScreenState();
}

class _FavoritesScreenState
    extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();

    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    await ExerciseFavoritesService.load();

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  Future<void> _removeFavorite(
    String exerciseName,
  ) async {
    await ExerciseFavoritesService.toggle(
      exerciseName,
    );

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final favoriteExercises =
        ExerciseService.exercises.where(
      (exercise) =>
          ExerciseFavoritesService.isFavorite(
        exercise.name,
      ),
    ).toList();

    return AppPage(
      title: "FAVORITES",

      body: favoriteExercises.isEmpty
          ? const _EmptyFavorites()
          : ListView(
              padding: EdgeInsets.zero,

              children: [
                AppSectionTitle(
                  title: "YOUR FAVORITES",
                  subtitle:
                      "${favoriteExercises.length} saved exercises",
                ),

                const SizedBox(
                  height: AppSpacing.md,
                ),

                ...favoriteExercises.map(
                  (exercise) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(
                        bottom: AppSpacing.md,
                      ),

                      child:
                          _FavoriteExerciseCard(
                        name: exercise.name,
                        category:
                            exercise.category,
                        difficulty:
                            exercise.difficulty,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ExerciseDetailsScreen(
                                exercise: exercise,
                              ),
                            ),
                          );
                        },
                        onRemove: () {
                          _removeFavorite(
                            exercise.name,
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

class _FavoriteExerciseCard
    extends StatelessWidget {
  final String name;
  final String category;
  final String difficulty;

  final VoidCallback onTap;
  final VoidCallback onRemove;

  const _FavoriteExerciseCard({
    required this.name,
    required this.category,
    required this.difficulty,
    required this.onTap,
    required this.onRemove,
  });

  Color _difficultyColor() {
    switch (difficulty) {
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
                      .fitness_center_rounded,
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
                      name,
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
                      category,
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
                      difficulty,
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

              IconButton(
                onPressed: onRemove,
                tooltip:
                    "Remove favorite",
                icon: const Icon(
                  Icons.favorite_rounded,
                  color: AppColors.error,
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

class _EmptyFavorites
    extends StatelessWidget {
  const _EmptyFavorites();

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
                Icons
                    .favorite_border_rounded,
                size: 35,
                color:
                    AppColors.textMuted,
              ),
            ),

            const SizedBox(
              height: AppSpacing.lg,
            ),

            const Text(
              "No favorites yet",
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
              "Save exercises you want to access quickly.",
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