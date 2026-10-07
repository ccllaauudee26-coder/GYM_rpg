import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

class WeeklyActivityChart extends StatelessWidget {
  final List<int> values;

  const WeeklyActivityChart({
    super.key,
    required this.values,
  });

  static const List<String> labels = [
    "M",
    "T",
    "W",
    "T",
    "F",
    "S",
    "S",
  ];

  int _safeValue(int index) {
    if (index < 0 || index >= values.length) {
      return 0;
    }

    return values[index];
  }

  @override
  Widget build(BuildContext context) {
    final int maximum = values.isEmpty
        ? 1
        : values.reduce(
              (a, b) => a > b ? a : b,
            ) ==
            0
            ? 1
            : values.reduce(
                (a, b) => a > b ? a : b,
              );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        AppSpacing.xl,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusXLarge,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            "WEEKLY ACTIVITY",
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(
            height: AppSpacing.xs,
          ),

          const Text(
            "Your workouts over the last 7 days",
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 13,
            ),
          ),

          const SizedBox(
            height: AppSpacing.xxl,
          ),

          SizedBox(
            height: 150,
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.end,
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: List.generate(
                7,
                (index) {
                  final int value =
                      _safeValue(index);

                  final double ratio =
                      value / maximum;

                  return Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 4,
                      ),
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.end,
                        children: [
                          Text(
                            "$value",
                            style:
                                const TextStyle(
                              color:
                                  AppColors.textSecondary,
                              fontSize: 11,
                              fontWeight:
                                  FontWeight.w700,
                            ),
                          ),

                          const SizedBox(
                            height: 6,
                          ),

                          AnimatedContainer(
                            duration:
                                const Duration(
                              milliseconds: 300,
                            ),
                            width: 24,
                            height: 95 * ratio +
                                6,
                            decoration:
                                BoxDecoration(
                              color:
                                  value > 0
                                      ? AppColors
                                          .primary
                                      : AppColors
                                          .surfaceLight,
                              borderRadius:
                                  BorderRadius.circular(
                                10,
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 8,
                          ),

                          Text(
                            labels[index],
                            style:
                                const TextStyle(
                              color:
                                  AppColors.textMuted,
                              fontSize: 11,
                              fontWeight:
                                  FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}