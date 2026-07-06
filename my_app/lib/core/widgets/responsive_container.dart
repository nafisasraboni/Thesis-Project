import 'package:flutter/material.dart';

import '../theme/app_sizes.dart';

/// Constrains content width for tablet, desktop, and web layouts.
class ResponsiveContainer extends StatelessWidget {
  /// Creates a responsive content wrapper.
  const ResponsiveContainer({
    required this.child,
    super.key,
    this.padding = AppSizes.pagePadding,
    this.maxWidth = AppSizes.contentMaxWidth,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
