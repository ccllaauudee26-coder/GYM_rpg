import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

class AppPrimaryButton extends StatelessWidget {
  final String text;

  final VoidCallback? onPressed;

  final IconData? icon;

  final bool loading;

  const AppPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,

      child: ElevatedButton(
        onPressed:
            loading ? null : onPressed,

        style:
            ElevatedButton.styleFrom(
          backgroundColor:
              AppColors.primary,
          foregroundColor:
              Colors.white,

          disabledBackgroundColor:
              AppColors.primaryDark,

          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
              AppSpacing.radiusMedium,
            ),
          ),

          elevation: 0,
        ),

        child: loading
            ? const SizedBox(
                width: 22,
                height: 22,
                child:
                    CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      size: 20,
                    ),

                    const SizedBox(
                      width: 8,
                    ),
                  ],

                  Text(
                    text,
                    style:
                        const TextStyle(
                      fontSize: 15,
                      fontWeight:
                          FontWeight.w700,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}