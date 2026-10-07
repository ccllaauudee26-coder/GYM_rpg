import 'package:flutter/material.dart';

import '../app/workout_dependencies_provider.dart';

import '../models/exercise.dart';

import '../services/achievement_service.dart';
import '../services/reward_calculator.dart';
import '../services/workout_live_summary_service.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

import '../view_models/workout_view_model.dart';

import '../widgets/app_card.dart';
import '../widgets/app_primary_button.dart';
import '../widgets/workout_live_summary_card.dart';
import '../widgets/workout_set_card.dart';
import '../widgets/workout_session_header.dart';

import 'workout_result_screen.dart';

class WorkoutSessionScreen extends StatefulWidget {
  final Exercise exercise;

  const WorkoutSessionScreen({
    super.key,
    required this.exercise,
  });

  @override
  State<WorkoutSessionScreen> createState() =>
      _WorkoutSessionScreenState();
}

class _WorkoutSessionScreenState
    extends State<WorkoutSessionScreen> {
  late final WorkoutViewModel viewModel;

  late List<int> reps;

  @override
  void initState() {
    super.initState();

    reps = List.generate(
      widget.exercise.defaultSets,
      (_) => widget.exercise.defaultReps,
    );

    final dependencies =
        WorkoutDependenciesProvider.create();

    viewModel = WorkoutViewModel(
      exercise: widget.exercise,
      playerRepository:
          dependencies.playerRepository,
      workoutRepository:
          dependencies.workoutRepository,
      muscleRepository:
          dependencies.muscleRepository,
      achievementRepository:
          dependencies.achievementRepository,
      dailyQuestRepository:
          dependencies.dailyQuestRepository,
    );

    viewModel.addListener(
      _onViewModelChanged,
    );
  }

  @override
  void dispose() {
    viewModel.removeListener(
      _onViewModelChanged,
    );

    viewModel.dispose();

    super.dispose();
  }

  void _onViewModelChanged() {
    if (!mounted) {
      return;
    }

    setState(() {});
  }

  void _addSet() {
    if (viewModel.isSaving) {
      return;
    }

    setState(() {
      reps.add(
        widget.exercise.defaultReps,
      );
    });
  }

  void _removeSet() {
    if (viewModel.isSaving) {
      return;
    }

    if (reps.length <= 1) {
      return;
    }

    setState(() {
      reps.removeLast();
    });
  }

  void _increaseReps(int index) {
    if (viewModel.isSaving) {
      return;
    }

    setState(() {
      reps[index]++;
    });
  }

  void _decreaseReps(int index) {
    if (viewModel.isSaving) {
      return;
    }

    if (reps[index] <= 0) {
      return;
    }

    setState(() {
      reps[index]--;
    });
  }

  Future<void> _completeWorkout() async {
    if (viewModel.isSaving) {
      return;
    }

    final RewardResult? result =
        await viewModel.completeWorkout(
      repsPerSet: reps,
    );

    if (!mounted) {
      return;
    }

    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            viewModel.error ??
                "Could not save workout.",
          ),
        ),
      );

      return;
    }

    final int totalReps = reps.fold(
      0,
      (sum, value) => sum + value,
    );

    final Achievement? achievement =
        viewModel.achievement;

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WorkoutResultScreen(
          reward: result,
          totalSets: reps.length,
          totalReps: totalReps,
          achievement: achievement,
        ),
      ),
    );

    if (!mounted) {
      return;
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final int totalReps = reps.fold(
      0,
      (sum, value) => sum + value,
    );

    final liveSummary =
        WorkoutLiveSummaryService.calculate(
      exercise: widget.exercise,
      repsPerSet: reps,
    );

    return Scaffold(
      backgroundColor:
          AppColors.background,
      appBar: AppBar(
        backgroundColor:
            Colors.transparent,
        elevation: 0,
        title: const Text(
          "WORKOUT",
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight:
                FontWeight.w800,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.page,
            AppSpacing.sm,
            AppSpacing.page,
            30,
          ),
          children: [
            WorkoutSessionHeader(
              exercise: widget.exercise,
            ),

            const SizedBox(
              height: AppSpacing.xxxl,
            ),

            const Text(
              "YOUR SETS",
              style: TextStyle(
                color:
                    AppColors.textPrimary,
                fontSize: 18,
                fontWeight:
                    FontWeight.w700,
              ),
            ),

            const SizedBox(
              height: AppSpacing.md,
            ),

            ...List.generate(
              reps.length,
              (index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(
                    bottom: AppSpacing.md,
                  ),
                  child: WorkoutSetCard(
                    setNumber:
                        index + 1,
                    reps:
                        reps[index],
                    disabled:
                        viewModel.isSaving,
                    onDecrease:
                        () =>
                            _decreaseReps(index),
                    onIncrease:
                        () =>
                            _increaseReps(index),
                  ),
                );
              },
            ),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed:
                        viewModel.isSaving
                            ? null
                            : _removeSet,
                    icon: const Icon(
                      Icons.remove,
                    ),
                    label: const Text(
                      "REMOVE SET",
                    ),
                  ),
                ),
                const SizedBox(
                  width: AppSpacing.sm,
                ),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed:
                        viewModel.isSaving
                            ? null
                            : _addSet,
                    icon: const Icon(
                      Icons.add,
                    ),
                    label: const Text(
                      "ADD SET",
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: AppSpacing.xl,
            ),

            WorkoutLiveSummaryCard(
              summary: liveSummary,
            ),

            const SizedBox(
              height: AppSpacing.xl,
            ),

            AppCard(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    "SESSION SUMMARY",
                    style: TextStyle(
                      color:
                          AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight:
                          FontWeight.w700,
                    ),
                  ),

                  const SizedBox(
                    height: AppSpacing.lg,
                  ),

                  _SummaryRow(
                    label: "Sets",
                    value:
                        "${reps.length}",
                  ),

                  const SizedBox(
                    height: AppSpacing.md,
                  ),

                  _SummaryRow(
                    label: "Total reps",
                    value:
                        "$totalReps",
                  ),

                  const SizedBox(
                    height: AppSpacing.md,
                  ),

                  _SummaryRow(
                    label: "Base XP",
                    value:
                        "${widget.exercise.xp}",
                  ),

                  const SizedBox(
                    height: AppSpacing.md,
                  ),

                  _SummaryRow(
                    label: "Base GEMS",
                    value:
                        "${widget.exercise.gems}",
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: AppSpacing.xxl,
            ),

            AppPrimaryButton(
              text:
                  viewModel.isSaving
                      ? "SAVING..."
                      : "COMPLETE WORKOUT",
              icon:
                  Icons.check_rounded,
              loading:
                  viewModel.isSaving,
              onPressed:
                  viewModel.isSaving
                      ? null
                      : _completeWorkout,
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color:
                  AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color:
                AppColors.textPrimary,
            fontSize: 15,
            fontWeight:
                FontWeight.w800,
          ),
        ),
      ],
    );
  }
}