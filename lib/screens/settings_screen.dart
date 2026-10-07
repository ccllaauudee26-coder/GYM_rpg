import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

import '../view_models/settings_view_model.dart';

import '../widgets/app_page.dart';
import '../widgets/provem_brand.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();
}

class _SettingsScreenState
    extends State<SettingsScreen> {
  late final SettingsViewModel viewModel;

  @override
  void initState() {
    super.initState();

    viewModel = SettingsViewModel();
  }

  @override
  void dispose() {
    viewModel.dispose();

    super.dispose();
  }

  Future<void> _confirmReset() async {
    if (viewModel.isResetting) {
      return;
    }

    final bool? confirmed =
        await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor:
              AppColors.surfaceElevated,

          title: const Text(
            "Reset Progress?",
            style: TextStyle(
              color:
                  AppColors.textPrimary,
              fontWeight:
                  FontWeight.w800,
            ),
          ),

          content: const Text(
            "This will reset your XP, GEMS, "
            "streak, workout history, "
            "muscle progress and achievements.",
            style: TextStyle(
              color:
                  AppColors.textSecondary,
              height: 1.4,
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  false,
                );
              },
              child:
                  const Text("CANCEL"),
            ),

            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  true,
                );
              },
              child: const Text(
                "RESET",
                style: TextStyle(
                  color:
                      AppColors.error,
                  fontWeight:
                      FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      return;
    }

    final bool success =
        await viewModel.resetProgress();

    if (!mounted) {
      return;
    }

    if (!success) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            viewModel.error ??
                "Could not reset progress.",
          ),
        ),
      );

      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          "Progress reset successfully.",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: viewModel,

      builder: (context, child) {
        return AppPage(
          title: "SETTINGS",

          body: ListView(
            padding: EdgeInsets.zero,

            children: [
              // =========================
              // ACCOUNT
              // =========================

              const _SettingsSectionTitle(
                title: "ACCOUNT",
              ),

              const SizedBox(
                height: AppSpacing.md,
              ),

              _SettingsTile(
                icon:
                    Icons.person_outline_rounded,
                title: "Profile",
                subtitle:
                    "Your PROVEM profile",
                onTap: () {
                  Navigator.pop(
                    context,
                  );
                },
              ),

              const SizedBox(
                height: AppSpacing.xxxl,
              ),

              // =========================
              // DATA
              // =========================

              const _SettingsSectionTitle(
                title: "DATA",
              ),

              const SizedBox(
                height: AppSpacing.md,
              ),

              _SettingsTile(
                icon:
                    Icons.delete_outline_rounded,
                title:
                    "Reset Progress",
                subtitle:
                    "Delete all local progress",
                iconColor:
                    AppColors.error,
                enabled:
                    !viewModel.isResetting,
                trailing:
                    viewModel.isResetting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child:
                                CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : null,
                onTap:
                    _confirmReset,
              ),

              const SizedBox(
                height: AppSpacing.xxxl,
              ),

              // =========================
              // APP
              // =========================

              const _SettingsSectionTitle(
                title: "APP",
              ),

              const SizedBox(
                height: AppSpacing.md,
              ),

              Container(
                padding:
                    const EdgeInsets.all(
                  AppSpacing.lg,
                ),
                decoration:
                    BoxDecoration(
                  color:
                      AppColors.surface,
                  borderRadius:
                      BorderRadius.circular(
                    AppSpacing.radiusLarge,
                  ),
                ),
                child: const ProvemBrand(
                  iconSize: 46,
                  showSubtitle: true,
                ),
              ),

              const SizedBox(
                height: AppSpacing.xxl,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SettingsSectionTitle
    extends StatelessWidget {
  final String title;

  const _SettingsSectionTitle({
    required this.title,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Text(
      title,
      style: const TextStyle(
        color:
            AppColors.textMuted,
        fontSize: 11,
        fontWeight:
            FontWeight.w800,
        letterSpacing: 1.0,
      ),
    );
  }
}

class _SettingsTile
    extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  final VoidCallback onTap;

  final Color? iconColor;

  final bool enabled;

  final Widget? trailing;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.iconColor,
    this.enabled = true,
    this.trailing,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Opacity(
      opacity:
          enabled ? 1 : 0.55,

      child: Material(
        color:
            Colors.transparent,

        child: InkWell(
          onTap:
              enabled ? onTap : null,

          borderRadius:
              BorderRadius.circular(
            AppSpacing.radiusLarge,
          ),

          child: Ink(
            padding:
                const EdgeInsets.all(
              AppSpacing.lg,
            ),

            decoration:
                BoxDecoration(
              color:
                  AppColors.surface,
              borderRadius:
                  BorderRadius.circular(
                AppSpacing.radiusLarge,
              ),
            ),

            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,

                  decoration:
                      BoxDecoration(
                    color:
                        AppColors
                            .surfaceLight,
                    borderRadius:
                        BorderRadius.circular(
                      14,
                    ),
                  ),

                  child: Icon(
                    icon,
                    color:
                        iconColor ??
                        AppColors
                            .primaryLight,
                    size: 22,
                  ),
                ),

                const SizedBox(
                  width:
                      AppSpacing.md,
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                    children: [
                      Text(
                        title,
                        style:
                            const TextStyle(
                          color:
                              AppColors
                                  .textPrimary,
                          fontSize: 15,
                          fontWeight:
                              FontWeight.w700,
                        ),
                      ),

                      const SizedBox(
                        height: 4,
                      ),

                      Text(
                        subtitle,
                        style:
                            const TextStyle(
                          color:
                              AppColors
                                  .textMuted,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                trailing ??
                    const Icon(
                      Icons
                          .arrow_forward_ios_rounded,
                      size: 15,
                      color:
                          AppColors
                              .textMuted,
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}