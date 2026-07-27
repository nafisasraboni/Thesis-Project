import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';
import '../theme/app_text_styles.dart';

/// Shared application app bar with title and subtitle support for premium minimal UI.
class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({
    required this.title,
    super.key,
    this.subtitle,
    this.actions,
    this.leading,
    this.bottomHeight,
  });

  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final Widget? leading;
  final double? bottomHeight;

  @override
  Size get preferredSize => Size.fromHeight(56 + (bottomHeight ?? 0));

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 56,
      titleSpacing: AppSizes.md,
      leading: leading,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: AppTextStyles.subheading),
          if (subtitle != null)
            Text(
              subtitle!,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textMuted,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
      actions: actions,
    );
  }
}

/// Compatibility alias for existing code. New code should use [AppAppBar].
@Deprecated('Use AppAppBar instead')
class CyberAppBar extends AppAppBar {
  const CyberAppBar({
    required super.title,
    super.key,
    super.subtitle,
    super.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(76);
}