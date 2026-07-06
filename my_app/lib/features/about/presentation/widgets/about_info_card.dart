import 'package:flutter/material.dart';

import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/cyber_card.dart';

/// Shared informational card used by the about page.
class AboutInfoCard extends StatelessWidget {
  /// Creates an about info card.
  const AboutInfoCard({
    required this.title,
    required this.description,
    super.key,
    this.icon,
    this.footer,
  });

  final String title;
  final String description;
  final IconData? icon;
  final String? footer;

  @override
  Widget build(BuildContext context) {
    return CyberCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon),
                const SizedBox(width: AppSizes.sm),
              ],
              Expanded(child: Text(title, style: AppTextStyles.subheading)),
            ],
          ),
          const SizedBox(height: AppSizes.sm),
          Text(description, style: AppTextStyles.bodySecondary),
          if (footer != null) ...[
            const SizedBox(height: AppSizes.md),
            Text(footer!, style: AppTextStyles.label),
          ],
        ],
      ),
    );
  }
}
