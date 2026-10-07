import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

class AppStatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? iconColor;

  const AppStatCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.all(
        AppSpacing.lg,
      ),

      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusMedium,
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Container(
            width: 38,
            height: 38,

            decoration: BoxDecoration(
              color:
                  AppColors.surfaceLight,
              borderRadius:
                  BorderRadius.circular(
                AppSpacing.radiusSmall,
              ),
            ),

            child: Icon(
              icon,
              size: 20,
              color:
                  iconColor ??
                  AppColors.primaryLight,
            ),
          ),

          const SizedBox(height: 14),

          Text(
            label,
            style: const TextStyle(
              color:
                  AppColors.textMuted,
              fontSize: 12,
              fontWeight:
                  FontWeight.w500,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            value,
            style: const TextStyle(
              color:
                  AppColors.textPrimary,
              fontSize: 24,
              fontWeight:
                  FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }
}