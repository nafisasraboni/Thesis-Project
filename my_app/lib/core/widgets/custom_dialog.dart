import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';
import '../theme/app_text_styles.dart';

/// Application dialog helper for alerts and confirmations.
abstract final class CustomDialog {
  /// Shows a themed dialog.
  static Future<T?> showAppDialog<T>({
    required BuildContext context,
    required String title,
    required String message,
    Widget? icon,
    List<Widget>? actions,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(AppSizes.xl),
          titlePadding: const EdgeInsets.fromLTRB(
            AppSizes.xl,
            AppSizes.xl,
            AppSizes.xl,
            0,
          ),
          title: Row(
            children: [
              if (icon != null) ...[icon, const SizedBox(width: AppSizes.sm)],
              Expanded(child: Text(title, style: AppTextStyles.subheading)),
            ],
          ),
          content: Text(message, style: AppTextStyles.bodySecondary),
          actions:
              actions ??
              [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Close',
                    style: TextStyle(color: AppColors.textPrimary),
                  ),
                ),
              ],
        );
      },
    );
  }
}
