import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData dark() {
    final colorScheme =
        ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    ).copyWith(
      primary: AppColors.primary,
      onPrimary: Colors.white,
      secondary: AppColors.primaryLight,
      onSecondary: Colors.white,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      error: AppColors.error,
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      colorScheme: colorScheme,

      scaffoldBackgroundColor:
          AppColors.background,

      canvasColor:
          AppColors.background,

      textTheme: const TextTheme(
        displayLarge:
            AppTypography.displayLarge,
        displayMedium:
            AppTypography.displayMedium,
        headlineLarge:
            AppTypography.headingLarge,
        headlineMedium:
            AppTypography.headingMedium,
        headlineSmall:
            AppTypography.headingSmall,
        bodyLarge:
            AppTypography.bodyLarge,
        bodyMedium:
            AppTypography.bodyMedium,
        bodySmall:
            AppTypography.bodySmall,
        labelLarge:
            AppTypography.button,
        labelMedium:
            AppTypography.labelPrimary,
        labelSmall:
            AppTypography.label,
      ),

      appBarTheme:
          const AppBarTheme(
        backgroundColor:
            AppColors.background,
        foregroundColor:
            AppColors.textPrimary,
        elevation: 0,
        centerTitle: true,
        surfaceTintColor:
            Colors.transparent,
      ),

      navigationBarTheme:
          NavigationBarThemeData(
        backgroundColor:
            AppColors.surface,
        indicatorColor:
            AppColors.primary,
        surfaceTintColor:
            Colors.transparent,
        elevation: 0,
        height: 72,
        labelBehavior:
            NavigationDestinationLabelBehavior
                .onlyShowSelected,

        labelTextStyle:
            WidgetStateProperty.resolveWith(
          (states) {
            final selected =
                states.contains(
              WidgetState.selected,
            );

            return TextStyle(
              color: selected
                  ? AppColors.textPrimary
                  : AppColors.textMuted,
              fontSize: 11,
              fontWeight: selected
                  ? FontWeight.w700
                  : FontWeight.w500,
            );
          },
        ),

        iconTheme:
            WidgetStateProperty.resolveWith(
          (states) {
            final selected =
                states.contains(
              WidgetState.selected,
            );

            return IconThemeData(
              color: selected
                  ? Colors.white
                  : AppColors.textMuted,
              size: 23,
            );
          },
        ),
      ),

      cardTheme:
          const CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
      ),

      dividerTheme:
          const DividerThemeData(
        color: AppColors.surfaceLight,
        thickness: 1,
      ),

      elevatedButtonTheme:
          ElevatedButtonThemeData(
        style:
            ElevatedButton.styleFrom(
          backgroundColor:
              AppColors.primary,
          foregroundColor:
              Colors.white,
          disabledBackgroundColor:
              AppColors.primaryDark,
          elevation: 0,
          minimumSize:
              const Size(
            double.infinity,
            52,
          ),
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(16),
          ),
          textStyle:
              AppTypography.button,
        ),
      ),

      outlinedButtonTheme:
          OutlinedButtonThemeData(
        style:
            OutlinedButton.styleFrom(
          foregroundColor:
              AppColors.textPrimary,
          minimumSize:
              const Size(
            double.infinity,
            50,
          ),
          side:
              const BorderSide(
            color:
                AppColors.surfaceLight,
          ),
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(16),
          ),
          textStyle:
              AppTypography.button,
        ),
      ),

      inputDecorationTheme:
          InputDecorationTheme(
        filled: true,
        fillColor:
            AppColors.surface,

        hintStyle:
            AppTypography.bodyMedium
                .copyWith(
          color:
              AppColors.textMuted,
        ),

        prefixIconColor:
            AppColors.textMuted,

        contentPadding:
            const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),

        border:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(16),
          borderSide:
              BorderSide.none,
        ),

        enabledBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(16),
          borderSide:
              BorderSide.none,
        ),

        focusedBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(16),
          borderSide:
              const BorderSide(
            color:
                AppColors.primary,
            width: 1.2,
          ),
        ),
      ),

      progressIndicatorTheme:
          const ProgressIndicatorThemeData(
        color:
            AppColors.primary,
        linearTrackColor:
            AppColors.surfaceLight,
      ),

      snackBarTheme:
          SnackBarThemeData(
        backgroundColor:
            AppColors.surfaceElevated,
        contentTextStyle:
            AppTypography.bodyMedium
                .copyWith(
          color:
              AppColors.textPrimary,
        ),
        behavior:
            SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(14),
        ),
      ),

      dialogTheme:
          DialogThemeData(
        backgroundColor:
            AppColors.surfaceElevated,
        surfaceTintColor:
            Colors.transparent,
        shape:
            RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(22),
        ),
      ),
    );
  }
}