import 'package:flutter/material.dart';

import '../services/achievement_service.dart';
import '../services/reward_calculator.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

import '../widgets/app_card.dart';
import '../widgets/app_primary_button.dart';

class WorkoutResultScreen extends StatefulWidget {
  final RewardResult reward;
  final int totalSets;
  final int totalReps;
  final Achievement? achievement;

  const WorkoutResultScreen({
    super.key,
    required this.reward,
    required this.totalSets,
    required this.totalReps,
    required this.achievement,
  });

  @override
  State<WorkoutResultScreen> createState() =>
      _WorkoutResultScreenState();
}

class _WorkoutResultScreenState
    extends State<WorkoutResultScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _iconScale;
  late final Animation<double> _contentOpacity;
  late final Animation<Offset> _contentOffset;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 700,
      ),
    );

    _iconScale = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.0,
        0.45,
        curve: Curves.elasticOut,
      ),
    );

    _contentOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.25,
        0.75,
        curve: Curves.easeOut,
      ),
    );

    _contentOffset = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.25,
          0.8,
          curve: Curves.easeOutCubic,
        ),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.page,
            40,
            AppSpacing.page,
            30,
          ),
          child: Column(
            children: [
              ScaleTransition(
                scale: _iconScale,
                child: Container(
                  width: 92,
                  height: 92,
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(
                      alpha: 0.12,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: AppColors.success,
                    size: 52,
                  ),
                ),
              ),

              const SizedBox(
                height: AppSpacing.xl,
              ),

              FadeTransition(
                opacity: _contentOpacity,
                child: SlideTransition(
                  position: _contentOffset,
                  child: Column(
                    children: [
                      const Text(
                        'WORKOUT COMPLETE',
                        textAlign: TextAlign.center,
                        style:
                            AppTypography.displayMedium,
                      ),

                      const SizedBox(
                        height: AppSpacing.xs,
                      ),

                      const Text(
                        'Great work. You proved it.',
                        textAlign: TextAlign.center,
                        style:
                            AppTypography.bodyLarge,
                      ),

                      const SizedBox(
                        height: AppSpacing.xxxl,
                      ),

                      _buildRewards(),

                      const SizedBox(
                        height: AppSpacing.lg,
                      ),

                      _buildSummary(),

                      if (widget.achievement != null) ...[
                        const SizedBox(
                          height: AppSpacing.lg,
                        ),
                        _buildAchievement(),
                      ],

                      const SizedBox(
                        height: AppSpacing.xxxl,
                      ),

                      AppPrimaryButton(
                        text: 'DONE',
                        icon:
                            Icons.arrow_forward_rounded,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRewards() {
    return AppCard(
      padding: const EdgeInsets.all(
        AppSpacing.xl,
      ),
      child: Row(
        children: [
          Expanded(
            child: _RewardItem(
              icon: Icons.bolt_rounded,
              label: 'XP',
              value: '+${widget.reward.xp}',
              color: AppColors.xp,
            ),
          ),
          Container(
            width: 1,
            height: 58,
            color: AppColors.surfaceLight,
          ),
          Expanded(
            child: _RewardItem(
              icon: Icons.diamond_rounded,
              label: 'GEMS',
              value: '+${widget.reward.gems}',
              color: AppColors.gems,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummary() {
    return AppCard(
      padding: const EdgeInsets.all(
        AppSpacing.lg,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            'SESSION SUMMARY',
            style: AppTypography.headingSmall,
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          _SummaryRow(
            icon: Icons.layers_rounded,
            label: 'Sets',
            value: '${widget.totalSets}',
          ),

          const SizedBox(
            height: AppSpacing.md,
          ),

          _SummaryRow(
            icon: Icons.repeat_rounded,
            label: 'Total reps',
            value: '${widget.totalReps}',
          ),
        ],
      ),
    );
  }

  Widget _buildAchievement() {
    final achievement = widget.achievement!;

    return AppCard(
      padding: const EdgeInsets.all(
        AppSpacing.xl,
      ),
      child: Column(
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(
                alpha: 0.12,
              ),
              borderRadius: BorderRadius.circular(
                AppSpacing.radiusMedium,
              ),
            ),
            child: const Icon(
              Icons.emoji_events_rounded,
              color: AppColors.warning,
              size: 32,
            ),
          ),

          const SizedBox(
            height: AppSpacing.md,
          ),

          const Text(
            'ACHIEVEMENT UNLOCKED',
            textAlign: TextAlign.center,
            style: AppTypography.label,
          ),

          const SizedBox(
            height: AppSpacing.sm,
          ),

          Text(
            achievement.title,
            textAlign: TextAlign.center,
            style: AppTypography.headingMedium,
          ),

          const SizedBox(
            height: AppSpacing.xs,
          ),

          Text(
            achievement.description,
            textAlign: TextAlign.center,
            style: AppTypography.bodyMedium,
          ),

          const SizedBox(
            height: AppSpacing.md,
          ),

          Text(
            '+${achievement.xpReward} XP  •  '
            '+${achievement.gemsReward} GEMS',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _RewardItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _RewardItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 22,
        ),

        const SizedBox(
          height: AppSpacing.xs,
        ),

        Text(
          label,
          style: AppTypography.label,
        ),

        const SizedBox(
          height: 2,
        ),

        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 28,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _SummaryRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.textMuted,
          size: 20,
        ),

        const SizedBox(
          width: AppSpacing.md,
        ),

        Expanded(
          child: Text(
            label,
            style: AppTypography.bodyMedium,
          ),
        ),

        Text(
          value,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}