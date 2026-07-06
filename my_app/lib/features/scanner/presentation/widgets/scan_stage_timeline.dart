import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/cyber_card.dart';

/// Visualizes progress through the staged scanning workflow.
class ScanStageTimeline extends StatelessWidget {
  /// Creates a stage timeline.
  const ScanStageTimeline({
    required this.stages,
    required this.currentStageIndex,
    super.key,
  });

  final List<String> stages;
  final int currentStageIndex;

  @override
  Widget build(BuildContext context) {
    return CyberCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Scan Process', style: AppTextStyles.subheading),
          const SizedBox(height: AppSizes.lg),
          ...List<Widget>.generate(stages.length, (index) {
            final isCompleted = index < currentStageIndex;
            final isActive = index == currentStageIndex;
            final color = isCompleted || isActive
                ? AppColors.primary
                : AppColors.surfaceSoft;

            return Padding(
              padding: const EdgeInsets.only(bottom: AppSizes.md),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: isActive ? 0.2 : 1),
                      borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                      border: Border.all(
                        color: isActive ? AppColors.primary : color,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: isCompleted
                        ? const Icon(
                            Icons.check,
                            size: AppSizes.iconSm,
                            color: AppColors.textPrimary,
                          )
                        : isActive
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(
                            '${index + 1}',
                            style: AppTextStyles.label.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                  ),
                  const SizedBox(width: AppSizes.md),
                  Expanded(
                    child: Text(
                      stages[index],
                      style: AppTextStyles.body.copyWith(
                        color: isCompleted || isActive
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
