import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

class AppSectionTitle extends StatelessWidget {
  final String title;

  final String? subtitle;

  final Widget? trailing;

  const AppSectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight:
                      FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),

              if (subtitle != null) ...[
                const SizedBox(
                  height: AppSpacing.xs,
                ),

                Text(
                  subtitle!,
                  style: const TextStyle(
                    color:
                        AppColors.textMuted,
                    fontSize: 13,
                  ),
                ),
              ],
            ],
          ),
        ),

        if (trailing != null) ...[
          const SizedBox(
            width: AppSpacing.md,
          ),
          trailing!,
        ],
      ],
    );
  }
}