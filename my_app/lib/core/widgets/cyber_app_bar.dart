import 'package:flutter/material.dart';

import '../theme/app_sizes.dart';
import '../theme/app_text_styles.dart';

/// Shared application app bar with title and subtitle support.
class CyberAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a styled app bar.
  const CyberAppBar({
    required this.title,
    super.key,
    this.subtitle,
    this.actions,
  });

  final String title;
  final String? subtitle;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(76);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 76,
      titleSpacing: AppSizes.lg,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: AppTextStyles.subheading),
          if (subtitle != null)
            Text(subtitle!, style: AppTextStyles.bodySecondary),
        ],
      ),
      actions: actions,
    );
  }
}
