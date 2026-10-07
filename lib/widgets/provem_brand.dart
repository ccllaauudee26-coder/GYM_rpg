import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

class ProvemBrand extends StatelessWidget {
  final double iconSize;
  final bool showSubtitle;

  const ProvemBrand({
    super.key,
    this.iconSize = 42,
    this.showSubtitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: iconSize,
          height: iconSize,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(
              AppSpacing.radiusMedium,
            ),
          ),
          child: Icon(
            Icons.fitness_center_rounded,
            color: Colors.white,
            size: iconSize * 0.52,
          ),
        ),

        const SizedBox(
          width: AppSpacing.sm,
        ),

        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'PROVEM',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.1,
              ),
            ),

            if (showSubtitle) ...[
              const SizedBox(
                height: 2,
              ),
              Text(
                'TRAIN • PROGRESS • PROVE',
                style: AppTypography.label.copyWith(
                  color: AppColors.textMuted,
                  fontSize: 8,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}