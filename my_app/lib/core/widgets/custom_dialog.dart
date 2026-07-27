import 'package:flutter/material.dart';

import '../theme/app_sizes.dart';
import '../theme/app_text_styles.dart';

/// Premium application dialog helper for alerts and confirmations.
abstract final class CustomDialog {
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
          contentPadding: const EdgeInsets.fromLTRB(
            AppSizes.xl,
            AppSizes.md,
            AppSizes.xl,
            AppSizes.xl,
          ),
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
          actions: actions ??
              [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ],
          actionsPadding: const EdgeInsets.fromLTRB(
            AppSizes.md,
            0,
            AppSizes.md,
            AppSizes.sm,
          ),
        );
      },
    );
  }
}