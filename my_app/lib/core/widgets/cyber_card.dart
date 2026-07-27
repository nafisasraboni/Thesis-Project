import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';

/// Core surface container used for cards and elevated panels throughout the app.
class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    super.key,
    this.padding = AppSizes.cardPadding,
    this.backgroundColor,
    this.onTap,
    this.borderColor,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        border: borderColor != null
            ? Border.all(color: borderColor!.withAlpha(128))
            : null,
      ),
      child: child,
    );

    if (onTap == null) {
      return content;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        onTap: onTap,
        splashColor: AppColors.primary.withAlpha(30),
        highlightColor: AppColors.primary.withAlpha(15),
        child: content,
      ),
    );
  }
}

/// Compatibility alias for existing code. New code should use [AppCard].
@Deprecated('Use AppCard instead')
class CyberCard extends AppCard {
  const CyberCard({
    required super.child,
    super.key,
    super.padding,
    super.backgroundColor,
    super.onTap,
  });
}