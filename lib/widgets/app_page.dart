import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

class AppPage extends StatelessWidget {
  final String title;
  final Widget body;

  final List<Widget>? actions;

  final bool centerTitle;

  final EdgeInsetsGeometry? padding;

  const AppPage({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.centerTitle = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: centerTitle,
        titleSpacing: AppSpacing.page,

        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.4,
          ),
        ),

        actions: actions,
      ),

      body: SafeArea(
        top: false,
        child: Padding(
          padding:
              padding ??
              const EdgeInsets.fromLTRB(
                AppSpacing.page,
                AppSpacing.sm,
                AppSpacing.page,
                30,
              ),
          child: body,
        ),
      ),
    );
  }
}