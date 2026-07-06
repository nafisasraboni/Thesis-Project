import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/cyber_card.dart';
import '../../domain/entities/scan_volume_bucket_entity.dart';

/// Bar chart for scan activity across the configured analytics window.
class AnalyticsTrendChart extends StatelessWidget {
  /// Creates a trend chart card.
  const AnalyticsTrendChart({
    required this.windowDays,
    required this.buckets,
    super.key,
  });

  final int windowDays;
  final List<ScanVolumeBucketEntity> buckets;

  @override
  Widget build(BuildContext context) {
    final maxCount = buckets.isEmpty
        ? 1
        : buckets
              .map((bucket) => bucket.count)
              .reduce((left, right) => left > right ? left : right)
              .clamp(1, 999999);

    return CyberCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Scan Trend ($windowDays days)',
            style: AppTextStyles.subheading,
          ),
          const SizedBox(height: AppSizes.xs),
          const Text(
            'Daily scan volume across the active analytics window.',
            style: AppTextStyles.bodySecondary,
          ),
          const SizedBox(height: AppSizes.xl),
          SizedBox(
            height: 220,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: buckets
                  .map(
                    (bucket) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.xxs,
                        ),
                        child: _TrendBar(bucket: bucket, maxCount: maxCount),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrendBar extends StatelessWidget {
  const _TrendBar({required this.bucket, required this.maxCount});

  final ScanVolumeBucketEntity bucket;
  final int maxCount;

  @override
  Widget build(BuildContext context) {
    final progress = maxCount == 0 ? 0.0 : bucket.count / maxCount;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('${bucket.count}', style: AppTextStyles.label),
        const SizedBox(height: AppSizes.xs),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: progress.clamp(0, 1)),
              duration: const Duration(milliseconds: 450),
              builder: (context, value, child) {
                return FractionallySizedBox(
                  heightFactor: value,
                  widthFactor: 1,
                  alignment: Alignment.bottomCenter,
                  child: child,
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: bucket.count == 0
                      ? AppColors.surfaceSoft
                      : AppColors.primary,
                  borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSizes.sm),
        Text(bucket.label, style: AppTextStyles.label),
      ],
    );
  }
}
