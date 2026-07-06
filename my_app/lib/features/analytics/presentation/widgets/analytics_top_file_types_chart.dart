import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/cyber_card.dart';
import '../../domain/entities/file_type_metric_entity.dart';

/// Horizontal ranking chart for the most common scanned file types.
class AnalyticsTopFileTypesChart extends StatelessWidget {
  /// Creates a top file types chart.
  const AnalyticsTopFileTypesChart({required this.fileTypes, super.key});

  final List<FileTypeMetricEntity> fileTypes;

  @override
  Widget build(BuildContext context) {
    return CyberCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Top File Types', style: AppTextStyles.subheading),
          const SizedBox(height: AppSizes.xs),
          const Text(
            'Extensions most frequently submitted to the detection pipeline.',
            style: AppTextStyles.bodySecondary,
          ),
          const SizedBox(height: AppSizes.lg),
          if (fileTypes.isEmpty)
            const Text(
              'No persisted records yet.',
              style: AppTextStyles.bodySecondary,
            )
          else
            Column(
              children: fileTypes
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSizes.md),
                      child: _FileTypeBar(item: item),
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}

class _FileTypeBar extends StatelessWidget {
  const _FileTypeBar({required this.item});

  final FileTypeMetricEntity item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                '.${item.extension.toLowerCase()}',
                style: AppTextStyles.body,
              ),
            ),
            Text(
              '${item.count} scans',
              style: AppTextStyles.label.copyWith(color: AppColors.textPrimary),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.xs),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.radiusSm),
          child: LinearProgressIndicator(
            value: item.ratio.clamp(0, 1),
            minHeight: 10,
            color: AppColors.primary,
            backgroundColor: AppColors.surfaceSoft,
          ),
        ),
      ],
    );
  }
}
