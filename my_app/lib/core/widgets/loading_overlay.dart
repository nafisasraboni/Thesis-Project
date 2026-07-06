import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';
import '../theme/app_text_styles.dart';

/// Stacks a loading indicator above existing content.
class LoadingOverlay extends StatelessWidget {
  /// Creates a loading overlay wrapper.
  const LoadingOverlay({
    required this.child,
    super.key,
    this.isLoading = false,
    this.message,
  });

  final Widget child;
  final bool isLoading;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: ColoredBox(
              color: AppColors.overlay,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    if (message != null) ...[
                      const SizedBox(height: AppSizes.md),
                      Text(message!, style: AppTextStyles.body),
                    ],
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
