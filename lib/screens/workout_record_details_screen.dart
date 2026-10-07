import 'package:flutter/material.dart';

import '../models/workout_record.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

import '../widgets/app_card.dart';
import '../widgets/app_section_title.dart';

class WorkoutRecordDetailsScreen
    extends StatelessWidget {
  final WorkoutRecord record;

  const WorkoutRecordDetailsScreen({
    super.key,
    required this.record,
  });

  String _formatDate(DateTime date) {
    final day =
        date.day.toString().padLeft(2, '0');

    final month =
        date.month.toString().padLeft(2, '0');

    final hour =
        date.hour.toString().padLeft(2, '0');

    final minute =
        date.minute.toString().padLeft(2, '0');

    return "$day.$month.${date.year}  "
        "$hour:$minute";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColors.background,

      appBar: AppBar(
        backgroundColor:
            AppColors.background,
        elevation: 0,

        title: const Text(
          "WORKOUT DETAILS",
          style: TextStyle(
            color:
                AppColors.textPrimary,
            fontSize: 18,
            fontWeight:
                FontWeight.w800,
            letterSpacing: 0.3,
          ),
        ),
      ),

      body: SafeArea(
        top: false,

        child: ListView(
          padding:
              const EdgeInsets.fromLTRB(
            AppSpacing.page,
            AppSpacing.sm,
            AppSpacing.page,
            30,
          ),

          children: [
            // =========================
            // HEADER
            // =========================

            AppCard(
              padding:
                  const EdgeInsets.all(
                AppSpacing.xl,
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Container(
                    width: 58,
                    height: 58,

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
                          AppColors
                              .primaryLight,
                      size: 28,
                    ),
                  ),

                  const SizedBox(
                    height: AppSpacing.lg,
                  ),

                  Text(
                    record.exerciseName,
                    style:
                        const TextStyle(
                      color:
                          AppColors.textPrimary,
                      fontSize: 27,
                      fontWeight:
                          FontWeight.w800,
                      letterSpacing: -0.6,
                    ),
                  ),

                  const SizedBox(
                    height: 6,
                  ),

                  Text(
                    record.category,
                    style:
                        const TextStyle(
                      color:
                          AppColors
                              .primaryLight,
                      fontSize: 13,
                      fontWeight:
                          FontWeight.w700,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Row(
                    children: [
                      const Icon(
                        Icons.schedule_rounded,
                        size: 16,
                        color:
                            AppColors.textMuted,
                      ),

                      const SizedBox(
                        width: 6,
                      ),

                      Text(
                        _formatDate(
                          record.date,
                        ),
                        style:
                            const TextStyle(
                          color:
                              AppColors.textMuted,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: AppSpacing.xxxl,
            ),

            // =========================
            // WORKOUT STATS
            // =========================

            const AppSectionTitle(
              title: "WORKOUT STATS",
              subtitle:
                  "What you completed",
            ),

            const SizedBox(
              height: AppSpacing.md,
            ),

            Row(
              children: [
                Expanded(
                  child: _LargeStat(
                    icon:
                        Icons.layers_outlined,
                    label: "SETS",
                    value:
                        "${record.sets}",
                  ),
                ),

                const SizedBox(
                  width: AppSpacing.md,
                ),

                Expanded(
                  child: _LargeStat(
                    icon:
                        Icons.repeat_rounded,
                    label: "REPS",
                    value:
                        "${record.reps}",
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: AppSpacing.xxxl,
            ),

            // =========================
            // REWARDS
            // =========================

            const AppSectionTitle(
              title: "REWARDS",
              subtitle:
                  "Earned from this workout",
            ),

            const SizedBox(
              height: AppSpacing.md,
            ),

            Row(
              children: [
                Expanded(
                  child: _RewardCard(
                    icon:
                        Icons.star_rounded,
                    label:
                        "XP EARNED",
                    value:
                        "+${record.xp}",
                    color:
                        AppColors.xp,
                  ),
                ),

                const SizedBox(
                  width: AppSpacing.md,
                ),

                Expanded(
                  child: _RewardCard(
                    icon:
                        Icons.diamond_rounded,
                    label:
                        "GEMS EARNED",
                    value:
                        "+${record.gems}",
                    color:
                        AppColors.gems,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: AppSpacing.xxxl,
            ),

            // =========================
            // SUMMARY
            // =========================

            const AppSectionTitle(
              title: "SUMMARY",
            ),

            const SizedBox(
              height: AppSpacing.md,
            ),

            AppCard(
              child: Column(
                children: [
                  _InfoRow(
                    label: "Exercise",
                    value:
                        record.exerciseName,
                  ),

                  const SizedBox(
                    height: AppSpacing.md,
                  ),

                  _InfoRow(
                    label: "Category",
                    value:
                        record.category,
                  ),

                  const SizedBox(
                    height: AppSpacing.md,
                  ),

                  _InfoRow(
                    label: "Sets completed",
                    value:
                        "${record.sets}",
                  ),

                  const SizedBox(
                    height: AppSpacing.md,
                  ),

                  _InfoRow(
                    label: "Total reps",
                    value:
                        "${record.reps}",
                  ),

                  const SizedBox(
                    height: AppSpacing.md,
                  ),

                  _InfoRow(
                    label: "XP earned",
                    value:
                        "+${record.xp}",
                    valueColor:
                        AppColors.xp,
                  ),

                  const SizedBox(
                    height: AppSpacing.md,
                  ),

                  _InfoRow(
                    label: "GEMS earned",
                    value:
                        "+${record.gems}",
                    valueColor:
                        AppColors.gems,
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: AppSpacing.xxl,
            ),
          ],
        ),
      ),
    );
  }
}

class _LargeStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _LargeStat({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding:
          const EdgeInsets.all(
        AppSpacing.xl,
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Container(
            width: 42,
            height: 42,

            decoration:
                BoxDecoration(
              color:
                  AppColors.surfaceLight,
              borderRadius:
                  BorderRadius.circular(
                13,
              ),
            ),

            child: Icon(
              icon,
              color:
                  AppColors.primaryLight,
              size: 21,
            ),
          ),

          const SizedBox(
            height: AppSpacing.md,
          ),

          Text(
            label,
            style:
                const TextStyle(
              color:
                  AppColors.textMuted,
              fontSize: 10,
              fontWeight:
                  FontWeight.w700,
              letterSpacing: 0.7,
            ),
          ),

          const SizedBox(
            height: 4,
          ),

          Text(
            value,
            style:
                const TextStyle(
              color:
                  AppColors.textPrimary,
              fontSize: 26,
              fontWeight:
                  FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _RewardCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _RewardCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding:
          const EdgeInsets.all(
        AppSpacing.lg,
      ),

      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 22,
          ),

          const SizedBox(
            width: AppSpacing.sm,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  label,
                  style:
                      const TextStyle(
                    color:
                        AppColors.textMuted,
                    fontSize: 9,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),

                const SizedBox(
                  height: 3,
                ),

                Text(
                  value,
                  style:
                      TextStyle(
                    color: color,
                    fontSize: 19,
                    fontWeight:
                        FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style:
                const TextStyle(
              color:
                  AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
        ),

        const SizedBox(
          width: AppSpacing.md,
        ),

        Flexible(
          child: Text(
            value,
            textAlign:
                TextAlign.right,
            style:
                TextStyle(
              color:
                  valueColor ??
                  AppColors.textPrimary,
              fontSize: 14,
              fontWeight:
                  FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}