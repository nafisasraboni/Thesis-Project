import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';
import '../theme/app_text_styles.dart';
import 'cyber_card.dart';

/// Compact statistics card for dashboard and analytics views.
class StatCard extends StatelessWidget {
  /// Creates a metric card.
  const StatCard({
    required this.title,
    required this.value,
    required this.icon,
    super.key,
    this.caption,
    this.highlightColor = AppColors.primary,
  });

  final String title;
  final String value;
  final IconData icon;
  final String? caption;
  final Color highlightColor;

  @override
  Widget build(BuildContext context) {
    return CyberCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSizes.sm),
                decoration: BoxDecoration(
                  color: highlightColor.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                ),
                child: Icon(icon, color: highlightColor),
              ),
              const Spacer(),
              Text(title, style: AppTextStyles.label),
            ],
          ),
          const SizedBox(height: AppSizes.lg),
          Text(value, style: AppTextStyles.metric),
          if (caption != null) ...[
            const SizedBox(height: AppSizes.xs),
            Text(caption!, style: AppTextStyles.bodySecondary),
          ],
        ],
      ),
    );
  }
}
