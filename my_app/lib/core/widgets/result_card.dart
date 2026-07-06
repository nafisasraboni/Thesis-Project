import 'package:flutter/material.dart';

import '../theme/app_sizes.dart';
import '../theme/app_text_styles.dart';
import '../utils/scan_classification.dart';
import 'cyber_card.dart';

/// Displays a prediction summary with confidence visualization.
class ResultCard extends StatelessWidget {
  /// Creates a result summary card.
  const ResultCard({
    required this.classification,
    required this.confidence,
    super.key,
    this.message,
    this.processingTime,
  });

  final ScanClassification classification;
  final double confidence;
  final String? message;
  final String? processingTime;

  @override
  Widget build(BuildContext context) {
    return CyberCard(
      borderColor: classification.color.withValues(alpha: 0.35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(classification.icon, color: classification.color),
              const SizedBox(width: AppSizes.sm),
              Expanded(
                child: Text(
                  classification.label,
                  style: AppTextStyles.subheading.copyWith(
                    color: classification.color,
                  ),
                ),
              ),
              if (processingTime != null)
                Text(processingTime!, style: AppTextStyles.label),
            ],
          ),
          const SizedBox(height: AppSizes.lg),
          Row(
            children: [
              SizedBox(
                width: 72,
                height: 72,
                child: CircularProgressIndicator(
                  value: confidence.clamp(0, 100) / 100,
                  strokeWidth: 6,
                  color: classification.color,
                ),
              ),
              const SizedBox(width: AppSizes.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${confidence.toStringAsFixed(2)}%',
                      style: AppTextStyles.metric,
                    ),
                    const SizedBox(height: AppSizes.xs),
                    Text(
                      message ?? classification.defaultMessage,
                      style: AppTextStyles.bodySecondary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
