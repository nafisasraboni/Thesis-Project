import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';
import '../theme/app_text_styles.dart';

/// Premium primary call-to-action button.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.icon,
    this.isLoading = false,
    this.isExpanded = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final child = isLoading
        ? const SizedBox(
            width: AppSizes.iconMd,
            height: AppSizes.iconMd,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: AppColors.textPrimary,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: AppSizes.iconSm),
                const SizedBox(width: AppSizes.xs),
              ],
              Text(label, style: AppTextStyles.button),
            ],
          );

    return Semantics(
      button: true,
      label: label,
      child: SizedBox(
        width: isExpanded ? double.infinity : null,
        height: AppSizes.minTapTarget,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          child: child,
        ),
      ),
    );
  }
}