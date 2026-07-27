import 'package:flutter/material.dart';

import '../theme/app_sizes.dart';
import '../theme/app_text_styles.dart';
import '../utils/scan_classification.dart';
import 'cyber_card.dart';

/// Premium warning panel for suspicious or malicious findings.
class WarningCard extends StatelessWidget {
  const WarningCard({
    required this.classification,
    required this.title,
    required this.message,
    super.key,
  });

  final ScanClassification classification;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      backgroundColor: classification.color.withAlpha(20),
      borderColor: classification.color,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(classification.icon, color: classification.color, size: AppSizes.iconLg),
          const SizedBox(width: AppSizes.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.subheading.copyWith(
                    color: classification.color,
                  ),
                ),
                const SizedBox(height: AppSizes.xs),
                Text(message, style: AppTextStyles.bodySecondary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}