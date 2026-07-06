import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Snackbar helper for quick status feedback.
abstract final class CustomSnackbar {
  static void showSuccess(BuildContext context, String message) {
    _show(context, message, AppColors.success);
  }

  static void showError(BuildContext context, String message) {
    _show(context, message, AppColors.danger);
  }

  static void showInfo(BuildContext context, String message) {
    _show(context, message, AppColors.info);
  }

  static void _show(BuildContext context, String message, Color accentColor) {
    final messenger = ScaffoldMessenger.of(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          showCloseIcon: true,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: accentColor.withValues(alpha: 0.42)),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
  }
}
