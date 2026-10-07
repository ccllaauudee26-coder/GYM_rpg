import 'package:flutter/material.dart';

import '../models/exercise.dart';

import '../services/exercise_service.dart';
import '../services/workout_filter_service.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

import '../widgets/app_section_title.dart';
import '../widgets/workout_category_card.dart';

import 'exercise_list_screen.dart';
import 'favorites_screen.dart';
import 'recent_exercises_screen.dart';

class WorkoutsScreen extends StatefulWidget {
  const WorkoutsScreen({super.key});

  @override
  State<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  String selectedLocation = "BOTH";

  final List<String> locations = const [
    "HOME",
    "GYM",
    "BOTH",
  ];

  final List<_WorkoutCategory> categories = const [
    _WorkoutCategory(
      title: "Chest",
      emoji: "💪",
    ),
    _WorkoutCategory(
      title: "Back",
      emoji: "🔙",
    ),
    _WorkoutCategory(
      title: "Arms",
      emoji: "💪",
    ),
    _WorkoutCategory(
      title: "Legs",
      emoji: "🦵",
    ),
    _WorkoutCategory(
      title: "Core",
      emoji: "🔥",
    ),
    _WorkoutCategory(
      title: "Cardio",
      emoji: "❤️",
    ),
  ];

  List<Exercise> _getExercisesForCategory(
    String category,
  ) {
    final locationFiltered =
        WorkoutFilterService.filterByLocation(
      exercises: ExerciseService.exercises,
      location: selectedLocation,
    );

    return locationFiltered
        .where(
          (exercise) => exercise.category == category,
        )
        .toList();
  }

  void _openCategory(
    _WorkoutCategory category,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ExerciseListScreen(
          category: category.title,
          location: selectedLocation,
        ),
      ),
    );
  }

  void _openFavorites() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const FavoritesScreen(),
      ),
    );
  }

  void _openRecent() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const RecentExercisesScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: false,
        titleSpacing: AppSpacing.page,
        title: const Text(
          "WORKOUTS",
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.8,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.page,
            AppSpacing.sm,
            AppSpacing.page,
            32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Build your next session",
                style: AppTypography.headingLarge,
              ),

              const SizedBox(
                height: AppSpacing.xs,
              ),

              const Text(
                "Choose a muscle group and start training.",
                style: AppTypography.bodyMedium,
              ),

              const SizedBox(
                height: AppSpacing.xxl,
              ),

              const AppSectionTitle(
                title: "LOCATION",
              ),

              const SizedBox(
                height: AppSpacing.md,
              ),

              _LocationSelector(
                locations: locations,
                selectedLocation: selectedLocation,
                onChanged: (value) {
                  setState(() {
                    selectedLocation = value;
                  });
                },
              ),

              const SizedBox(
                height: AppSpacing.xxl,
              ),

              Row(
                children: [
                  Expanded(
                    child: _QuickActionCard(
                      icon: Icons.favorite_rounded,
                      title: "Favorites",
                      subtitle: "Saved exercises",
                      onTap: _openFavorites,
                    ),
                  ),
                  const SizedBox(
                    width: AppSpacing.md,
                  ),
                  Expanded(
                    child: _QuickActionCard(
                      icon: Icons.history_rounded,
                      title: "Recent",
                      subtitle: "Train again",
                      onTap: _openRecent,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: AppSpacing.xxl,
              ),

              const AppSectionTitle(
                title: "MUSCLE GROUPS",
              ),

              const SizedBox(
                height: AppSpacing.md,
              ),

              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                separatorBuilder: (_, __) {
                  return const SizedBox(
                    height: AppSpacing.md,
                  );
                },
                itemBuilder: (context, index) {
                  final category = categories[index];

                  final exerciseCount =
                      _getExercisesForCategory(
                    category.title,
                  ).length;

                  return WorkoutCategoryCard(
                    title: category.title,
                    emoji: category.emoji,
                    exerciseCount: exerciseCount,
                    onTap: () {
                      _openCategory(category);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LocationSelector extends StatelessWidget {
  final List<String> locations;
  final String selectedLocation;
  final ValueChanged<String> onChanged;

  const _LocationSelector({
    required this.locations,
    required this.selectedLocation,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusMedium,
        ),
      ),
      child: Row(
        children: locations.map(
          (location) {
            final selected =
                location == selectedLocation;

            return Expanded(
              child: GestureDetector(
                onTap: () => onChanged(location),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 180,
                  ),
                  curve: Curves.easeOut,
                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 11,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? AppColors.primary
                        : Colors.transparent,
                    borderRadius:
                        BorderRadius.circular(
                      AppSpacing.radiusSmall,
                    ),
                  ),
                  child: Text(
                    location,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: selected
                          ? Colors.white
                          : AppColors.textMuted,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusLarge,
        ),
        child: Ink(
          padding: const EdgeInsets.all(
            AppSpacing.lg,
          ),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(
              AppSpacing.radiusLarge,
            ),
            border: Border.all(
              color: AppColors.surfaceLight,
              width: 0.8,
            ),
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.primary
                      .withValues(alpha: 0.14),
                  borderRadius:
                      BorderRadius.circular(
                    AppSpacing.radiusSmall,
                  ),
                ),
                child: Icon(
                  icon,
                  color: AppColors.primaryLight,
                  size: 21,
                ),
              ),

              const SizedBox(
                height: AppSpacing.md,
              ),

              Text(
                title,
                style: AppTypography.headingSmall,
              ),

              const SizedBox(
                height: 3,
              ),

              Text(
                subtitle,
                style: AppTypography.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WorkoutCategory {
  final String title;
  final String emoji;

  const _WorkoutCategory({
    required this.title,
    required this.emoji,
  });
}