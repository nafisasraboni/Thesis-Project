import 'package:flutter/material.dart';

import '../theme/app_sizes.dart';
import '../theme/app_text_styles.dart';

/// Premium consistent section heading for pages and grouped content.
class SectionHeader extends StatelessWidget {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.heading,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: AppSizes.md),
              trailing!,
            ],
          ],
        ),
        if (subtitle != null) ...[
          SizedBox(height: AppSizes.xs),
          Text(
            subtitle!,
            style: AppTextStyles.caption,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ],
    );
  }
}