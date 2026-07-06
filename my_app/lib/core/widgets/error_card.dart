import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';
import '../theme/app_text_styles.dart';
import 'cyber_card.dart';

/// Error state card for recoverable failures.
class ErrorCard extends StatelessWidget {
  /// Creates an error card.
  const ErrorCard({
    required this.title,
    required this.message,
    super.key,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return CyberCard(
      borderColor: AppColors.danger.withValues(alpha: 0.35),
      backgroundColor: AppColors.danger.withValues(alpha: 0.08),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.error_outline, color: AppColors.danger),
              SizedBox(width: AppSizes.sm),
              Expanded(
                child: Text(
                  'Initialization Error',
                  style: AppTextStyles.subheading,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.md),
          Text(title, style: AppTextStyles.body),
          const SizedBox(height: AppSizes.xs),
          Text(message, style: AppTextStyles.bodySecondary),
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(height: AppSizes.md),
            TextButton(onPressed: onAction, child: Text(actionLabel!)),
          ],
        ],
      ),
    );
  }
}
