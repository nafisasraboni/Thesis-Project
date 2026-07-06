import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/app_formatters.dart';
import '../../../../core/widgets/cyber_card.dart';
import '../../domain/entities/scan_asset_entity.dart';

/// Displays the metadata for the currently selected scan asset.
class ScannerSelectionSummary extends StatelessWidget {
  /// Creates a selection summary.
  const ScannerSelectionSummary({required this.asset, super.key});

  final ScanAssetEntity asset;

  @override
  Widget build(BuildContext context) {
    return CyberCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSizes.sm),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                ),
                child: Icon(
                  asset.isImage
                      ? Icons.image_outlined
                      : Icons.insert_drive_file_outlined,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppSizes.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(asset.fileName, style: AppTextStyles.subheading),
                    const SizedBox(height: AppSizes.xxs),
                    Text(
                      asset.isImage ? 'Image evidence' : 'Binary file sample',
                      style: AppTextStyles.bodySecondary,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.lg),
          _DetailRow(label: 'Extension', value: asset.extension.toUpperCase()),
          _DetailRow(
            label: 'Size',
            value: AppFormatters.formatFileSize(asset.sizeInBytes),
          ),
          _DetailRow(label: 'SHA256', value: asset.sha256),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 86, child: Text(label, style: AppTextStyles.label)),
          const SizedBox(width: AppSizes.sm),
          Expanded(child: SelectableText(value, style: AppTextStyles.body)),
        ],
      ),
    );
  }
}
