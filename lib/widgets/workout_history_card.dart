import 'package:flutter/material.dart';

import '../models/workout_record.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

import '../screens/workout_record_details_screen.dart';

class WorkoutHistoryCard extends StatelessWidget {
  final WorkoutRecord record;

  const WorkoutHistoryCard({
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

    return "$day.$month.${date.year} "
        "$hour:$minute";
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  WorkoutRecordDetailsScreen(
                record: record,
              ),
            ),
          );
        },
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
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(
                    AppSpacing.radiusMedium,
                  ),
                ),
                child: const Icon(
                  Icons.fitness_center_rounded,
                  color: AppColors.primaryLight,
                  size: 22,
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
                      record.exerciseName,
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                      style: const TextStyle(
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
                      "${record.sets} sets • "
                      "${record.reps} reps",
                      style: const TextStyle(
                        color:
                            AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),

                    const SizedBox(
                      height: 4,
                    ),

                    Text(
                      _formatDate(record.date),
                      style: const TextStyle(
                        color:
                            AppColors.textMuted,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                width: AppSpacing.sm,
              ),

              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.end,
                children: [
                  Text(
                    "+${record.xp} XP",
                    style: const TextStyle(
                      color: AppColors.xp,
                      fontSize: 11,
                      fontWeight:
                          FontWeight.w700,
                    ),
                  ),

                  const SizedBox(
                    height: 4,
                  ),

                  Text(
                    "+${record.gems} GEMS",
                    style: const TextStyle(
                      color: AppColors.gems,
                      fontSize: 11,
                      fontWeight:
                          FontWeight.w700,
                    ),
                  ),

                  const SizedBox(
                    height: 5,
                  ),

                  const Icon(
                    Icons
                        .arrow_forward_ios_rounded,
                    size: 13,
                    color: AppColors.textMuted,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}