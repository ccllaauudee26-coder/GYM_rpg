import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

class AppBadge extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? backgroundColor;

  const AppBadge({
    super.key,
    required this.text,
    this.color,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color:
            backgroundColor ?? AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusSmall,
        ),
      ),
      child: Text(
        text,
        style: AppTypography.labelPrimary.copyWith(
          color:
              color ?? AppColors.primaryLight,
        ),
      ),
    );
  }
}