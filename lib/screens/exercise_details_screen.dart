import 'package:flutter/material.dart';

import '../models/exercise.dart';

import '../services/recent_exercises_service.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

import '../widgets/app_badge.dart';
import '../widgets/app_card.dart';
import '../widgets/app_page.dart';
import '../widgets/app_primary_button.dart';
import '../widgets/favorite_button.dart';

import 'workout_session_screen.dart';

class ExerciseDetailsScreen extends StatefulWidget {
  final Exercise exercise;

  const ExerciseDetailsScreen({
    super.key,
    required this.exercise,
  });

  @override
  State<ExerciseDetailsScreen> createState() =>
      _ExerciseDetailsScreenState();
}

class _ExerciseDetailsScreenState
    extends State<ExerciseDetailsScreen> {
  bool isStarting = false;

  Future<void> _startWorkout() async {
    if (isStarting) {
      return;
    }

    setState(() {
      isStarting = true;
    });

    await RecentExercisesService.add(
      widget.exercise.name,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      isStarting = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WorkoutSessionScreen(
          exercise: widget.exercise,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final exercise = widget.exercise;

    return AppPage(
      title: 'EXERCISE',
      actions: [
        FavoriteButton(
          exerciseName: exercise.name,
        ),
      ],
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.page,
        AppSpacing.sm,
        AppSpacing.page,
        30,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppCard(
            padding: const EdgeInsets.all(
              AppSpacing.xl,
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
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight,
                        borderRadius:
                            BorderRadius.circular(
                          AppSpacing.radiusMedium,
                        ),
                      ),
                      child: const Icon(
                        Icons.fitness_center_rounded,
                        color: AppColors.primaryLight,
                        size: 30,
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
                            style: AppTypography.headingLarge,
                          ),
                          const SizedBox(
                            height: AppSpacing.xs,
                          ),
                          Text(
                            exercise.category,
                            style:
                                AppTypography.bodyMedium,
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
                    AppBadge(
                      text: exercise.difficulty,
                      color: AppColors.primaryLight,
                      backgroundColor:
                          AppColors.primary.withValues(
                        alpha: 0.14,
                      ),
                    ),
                    const SizedBox(
                      width: AppSpacing.sm,
                    ),
                    AppBadge(
                      text:
                          '${exercise.defaultSets} sets',
                      color: AppColors.textSecondary,
                      backgroundColor:
                          AppColors.surfaceLight,
                    ),
                    const SizedBox(
                      width: AppSpacing.sm,
                    ),
                    AppBadge(
                      text:
                          '${exercise.defaultReps} reps',
                      color: AppColors.textSecondary,
                      backgroundColor:
                          AppColors.surfaceLight,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(
            height: AppSpacing.xxl,
          ),

          const Text(
            'WORKOUT',
            style: AppTypography.label,
          ),

          const SizedBox(
            height: AppSpacing.sm,
          ),

          AppCard(
            padding: const EdgeInsets.all(
              AppSpacing.lg,
            ),
            child: Row(
              children: [
                Expanded(
                  child: _InfoItem(
                    label: 'SETS',
                    value:
                        '${exercise.defaultSets}',
                  ),
                ),
                Expanded(
                  child: _InfoItem(
                    label: 'REPS',
                    value:
                        '${exercise.defaultReps}',
                  ),
                ),
                Expanded(
                  child: _InfoItem(
                    label: 'XP',
                    value: '+${exercise.xp}',
                    valueColor: AppColors.xp,
                  ),
                ),
                Expanded(
                  child: _InfoItem(
                    label: 'GEMS',
                    value: '+${exercise.gems}',
                    valueColor: AppColors.gems,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: AppSpacing.xxl,
          ),

          const Text(
            'MUSCLES',
            style: AppTypography.label,
          ),

          const SizedBox(
            height: AppSpacing.sm,
          ),

          AppCard(
            padding: const EdgeInsets.all(
              AppSpacing.lg,
            ),
            child: Column(
              children: exercise.muscleWeights.entries
                  .map(
                    (entry) => Padding(
                      padding:
                          const EdgeInsets.only(
                        bottom: AppSpacing.md,
                      ),
                      child: _MuscleRow(
                        muscle: entry.key,
                        percentage:
                            entry.value,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),

          const SizedBox(
            height: AppSpacing.xxl,
          ),

          AppPrimaryButton(
            text: 'START WORKOUT',
            icon: Icons.play_arrow_rounded,
            loading: isStarting,
            onPressed: _startWorkout,
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoItem({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: AppTypography.label,
        ),
        const SizedBox(
          height: AppSpacing.xs,
        ),
        Text(
          value,
          style: TextStyle(
            color:
                valueColor ?? AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _MuscleRow extends StatelessWidget {
  final String muscle;
  final double percentage;

  const _MuscleRow({
    required this.muscle,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    final percentText =
        '${(percentage * 100).round()}%';

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                muscle,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Text(
              percentText,
              style: AppTypography.labelPrimary,
            ),
          ],
        ),
        const SizedBox(
          height: AppSpacing.xs,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(
            100,
          ),
          child: LinearProgressIndicator(
            value: percentage,
            minHeight: 7,
            backgroundColor:
                AppColors.surfaceLight,
            valueColor:
                const AlwaysStoppedAnimation<Color>(
              AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}