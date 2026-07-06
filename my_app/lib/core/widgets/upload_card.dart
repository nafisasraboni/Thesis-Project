import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';
import '../theme/app_text_styles.dart';
import 'cyber_card.dart';

/// Interactive card for selecting a file or image input source.
class UploadCard extends StatelessWidget {
  /// Creates an upload card.
  const UploadCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.supportedFormats,
    super.key,
    this.onTap,
  });

  final String title;
  final String description;
  final IconData icon;
  final List<String> supportedFormats;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CyberCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSizes.md),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(AppSizes.radiusSm),
            ),
            child: Icon(icon, color: AppColors.primary, size: AppSizes.iconLg),
          ),
          const SizedBox(height: AppSizes.lg),
          Text(title, style: AppTextStyles.subheading),
          const SizedBox(height: AppSizes.xs),
          Text(description, style: AppTextStyles.bodySecondary),
          const SizedBox(height: AppSizes.md),
          Wrap(
            spacing: AppSizes.xs,
            runSpacing: AppSizes.xs,
            children: supportedFormats
                .map(
                  (format) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.sm,
                      vertical: AppSizes.xs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceSoft,
                      borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                    ),
                    child: Text(format, style: AppTextStyles.label),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
