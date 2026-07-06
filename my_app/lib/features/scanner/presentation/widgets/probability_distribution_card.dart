import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/cyber_card.dart';

/// Displays class probabilities returned by the prediction service.
class ProbabilityDistributionCard extends StatelessWidget {
  /// Creates a probability distribution card.
  const ProbabilityDistributionCard({required this.probabilities, super.key});

  final Map<String, double> probabilities;

  @override
  Widget build(BuildContext context) {
    final orderedEntries = probabilities.entries.toList()
      ..sort((left, right) => right.value.compareTo(left.value));

    return CyberCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Probability Distribution',
            style: AppTextStyles.subheading,
          ),
          const SizedBox(height: AppSizes.lg),
          ...orderedEntries.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: AppSizes.md),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(entry.key, style: AppTextStyles.body),
                      ),
                      Text(
                        '${entry.value.toStringAsFixed(2)}%',
                        style: AppTextStyles.body,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.xs),
                  LinearProgressIndicator(
                    value: entry.value.clamp(0, 100) / 100,
                    minHeight: 10,
                    color: _resolveColor(entry.key),
                    backgroundColor: AppColors.surfaceSoft,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _resolveColor(String key) {
    switch (key.toLowerCase()) {
      case 'safe':
        return AppColors.success;
      case 'suspicious':
        return AppColors.warning;
      default:
        return AppColors.danger;
    }
  }
}
