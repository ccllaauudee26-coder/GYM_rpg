import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? iconColor;
  final Color? backgroundColor;
  final double size;

  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.iconColor,
    this.backgroundColor,
    this.size = 44,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color:
              backgroundColor ?? AppColors.surface,
          borderRadius: BorderRadius.circular(
            AppSpacing.radiusMedium,
          ),
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(
            AppSpacing.radiusMedium,
          ),
          child: Icon(
            icon,
            size: 20,
            color:
                iconColor ?? AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}