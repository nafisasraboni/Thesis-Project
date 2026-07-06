import 'package:flutter/material.dart';

import '../theme/app_sizes.dart';
import '../theme/app_text_styles.dart';

/// Consistent section heading for pages and grouped content.
class SectionHeader extends StatelessWidget {
  /// Creates a section heading.
  const SectionHeader({
    required this.title,
    super.key,
    this.subtitle,
    this.trailing,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.heading),
              if (subtitle != null) ...[
                const SizedBox(height: AppSizes.xs),
                Text(subtitle!, style: AppTextStyles.bodySecondary),
              ],
            ],
          ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: AppSizes.md),
          trailing!,
        ],
      ],
    );
  }
}
