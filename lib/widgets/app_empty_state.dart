import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

class AppEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;

  const AppEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(
          AppSpacing.xxl,
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            Container(
              width: 76,
              height: 76,

              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius:
                    BorderRadius.circular(
                  AppSpacing.radiusXLarge,
                ),
              ),

              child: Icon(
                icon,
                size: 34,
                color: AppColors.textMuted,
              ),
            ),

            const SizedBox(
              height: AppSpacing.lg,
            ),

            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTypography.headingMedium,
            ),

            const SizedBox(
              height: AppSpacing.sm,
            ),

            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTypography.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}