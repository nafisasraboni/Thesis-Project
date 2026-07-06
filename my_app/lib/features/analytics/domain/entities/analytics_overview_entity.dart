import 'file_type_metric_entity.dart';
import 'scan_volume_bucket_entity.dart';

/// Aggregated analytics data derived from persisted scan history.
class AnalyticsOverviewEntity {
  /// Creates an analytics overview entity.
  const AnalyticsOverviewEntity({
    required this.totalScans,
    required this.dailyScans,
    required this.weeklyScans,
    required this.monthlyScans,
    required this.safeRatio,
    required this.suspiciousRatio,
    required this.malwareRatio,
    required this.averageConfidence,
    required this.windowDays,
    required this.trendBuckets,
    required this.topFileTypes,
  });

  final int totalScans;
  final int dailyScans;
  final int weeklyScans;
  final int monthlyScans;
  final double safeRatio;
  final double suspiciousRatio;
  final double malwareRatio;
  final double averageConfidence;
  final int windowDays;
  final List<ScanVolumeBucketEntity> trendBuckets;
  final List<FileTypeMetricEntity> topFileTypes;

  int get maxTrendCount {
    if (trendBuckets.isEmpty) {
      return 0;
    }

    return trendBuckets
        .map((bucket) => bucket.count)
        .reduce((left, right) => left > right ? left : right);
  }
}
