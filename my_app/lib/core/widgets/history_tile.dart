import 'package:flutter/material.dart';

import '../theme/app_sizes.dart';
import '../theme/app_text_styles.dart';
import '../utils/scan_classification.dart';
import 'cyber_card.dart';

/// Premium tile that represents a single historical scan record.
class HistoryTile extends StatelessWidget {
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
    return AppCard(
      onTap: onTap,
      padding: AppSizes.compactCardPadding,
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: classification.color.withAlpha(30),
              borderRadius: BorderRadius.circular(AppSizes.radiusSm),
            ),
            alignment: Alignment.center,
            child: Icon(
              classification.icon,
              color: classification.color,
              size: AppSizes.iconMd,
            ),
          ),
          SizedBox(width: AppSizes.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  fileName,
                  style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(height: AppSizes.xxs),
                Text(
                  '$extension${fileSize == null ? '' : ' • $fileSize'} • $scanDate',
                  style: AppTextStyles.caption,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          SizedBox(width: AppSizes.sm),
          _ClassificationBadge(classification: classification),
          SizedBox(width: AppSizes.sm),
          Text(
            '${confidence.toStringAsFixed(1)}%',
            style: AppTextStyles.body.copyWith(
              color: classification.color,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (onDelete != null) ...[
            const SizedBox(width: AppSizes.xxs),
            Semantics(
              button: true,
              label: 'Delete record',
              child: IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.close, size: AppSizes.iconSm),
                splashRadius: 22,
                visualDensity: VisualDensity.compact,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ClassificationBadge extends StatelessWidget {
  const _ClassificationBadge({required this.classification});

  final ScanClassification classification;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.sm,
        vertical: AppSizes.xxs,
      ),
      decoration: BoxDecoration(
        color: classification.color.withAlpha(30),
        borderRadius: BorderRadius.circular(AppSizes.radiusXs),
      ),
      child: Text(
        classification.label,
        style: AppTextStyles.label.copyWith(
          color: classification.color,
          height: 1.2,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}