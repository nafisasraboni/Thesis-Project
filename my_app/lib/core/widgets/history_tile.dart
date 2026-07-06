import 'package:flutter/material.dart';

import '../theme/app_sizes.dart';
import '../theme/app_text_styles.dart';
import '../utils/scan_classification.dart';
import 'cyber_card.dart';

/// Tile that represents a single historical scan record.
class HistoryTile extends StatelessWidget {
  /// Creates a history tile.
  const HistoryTile({
    required this.fileName,
    required this.extension,
    required this.scanDate,
    required this.classification,
    required this.confidence,
    super.key,
    this.fileSize,
    this.onTap,
    this.onDelete,
  });

  final String fileName;
  final String extension;
  final String scanDate;
  final ScanClassification classification;
  final double confidence;
  final String? fileSize;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return CyberCard(
      onTap: onTap,
      padding: AppSizes.compactCardPadding,
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: classification.color.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(AppSizes.radiusSm),
            ),
            child: Icon(classification.icon, color: classification.color),
          ),
          const SizedBox(width: AppSizes.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(fileName, style: AppTextStyles.subheading),
                const SizedBox(height: AppSizes.xxs),
                Text(
                  '$extension${fileSize == null ? '' : ' • $fileSize'} • $scanDate',
                  style: AppTextStyles.bodySecondary,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.sm,
                  vertical: AppSizes.xs,
                ),
                decoration: BoxDecoration(
                  color: classification.color.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                ),
                child: Text(
                  classification.label,
                  style: AppTextStyles.label.copyWith(
                    color: classification.color,
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.xs),
              Text(
                '${confidence.toStringAsFixed(2)}%',
                style: AppTextStyles.body,
              ),
            ],
          ),
          if (onDelete != null) ...[
            const SizedBox(width: AppSizes.xs),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ],
      ),
    );
  }
}
