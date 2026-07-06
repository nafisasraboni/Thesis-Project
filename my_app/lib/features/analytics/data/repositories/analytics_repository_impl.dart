import '../../../history/domain/entities/history_query_entity.dart';
import '../../../history/domain/entities/scan_history_record_entity.dart';
import '../../../history/domain/repositories/scan_history_repository.dart';
import '../../domain/entities/analytics_overview_entity.dart';
import '../../domain/entities/file_type_metric_entity.dart';
import '../../domain/entities/scan_volume_bucket_entity.dart';
import '../../domain/repositories/analytics_repository.dart';

/// History-backed analytics repository implementation.
class AnalyticsRepositoryImpl implements AnalyticsRepository {
  /// Creates a repository implementation.
  const AnalyticsRepositoryImpl(this._historyRepository);

  final ScanHistoryRepository _historyRepository;

  @override
  Stream<AnalyticsOverviewEntity> watchOverview({required int windowDays}) {
    return _historyRepository
        .watchHistory(const HistoryQueryEntity())
        .map((records) => _buildOverview(records, windowDays: windowDays));
  }

  AnalyticsOverviewEntity _buildOverview(
    List<ScanHistoryRecordEntity> records, {
    required int windowDays,
  }) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final totalScans = records.length;

    final dailyScans = records
        .where((record) => _dateOnly(record.scanDate) == today)
        .length;
    final weeklyScans = records
        .where(
          (record) => !_dateOnly(
            record.scanDate,
          ).isBefore(today.subtract(const Duration(days: 6))),
        )
        .length;
    final monthlyScans = records
        .where(
          (record) => !_dateOnly(
            record.scanDate,
          ).isBefore(today.subtract(const Duration(days: 29))),
        )
        .length;

    final safeCount = records
        .where((record) => record.prediction == 'Safe')
        .length;
    final suspiciousCount = records
        .where((record) => record.prediction == 'Suspicious')
        .length;
    final malwareCount = records
        .where((record) => record.prediction == 'Malware Detected')
        .length;

    final averageConfidence = totalScans == 0
        ? 0.0
        : records
                  .map((record) => record.confidence)
                  .reduce((left, right) => left + right) /
              totalScans;

    return AnalyticsOverviewEntity(
      totalScans: totalScans,
      dailyScans: dailyScans,
      weeklyScans: weeklyScans,
      monthlyScans: monthlyScans,
      safeRatio: totalScans == 0 ? 0 : safeCount / totalScans,
      suspiciousRatio: totalScans == 0 ? 0 : suspiciousCount / totalScans,
      malwareRatio: totalScans == 0 ? 0 : malwareCount / totalScans,
      averageConfidence: averageConfidence,
      windowDays: windowDays,
      trendBuckets: _buildTrendBuckets(records, windowDays: windowDays),
      topFileTypes: _buildTopFileTypes(records, totalScans: totalScans),
    );
  }

  List<ScanVolumeBucketEntity> _buildTrendBuckets(
    List<ScanHistoryRecordEntity> records, {
    required int windowDays,
  }) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final countsByDate = <DateTime, int>{};

    for (final record in records) {
      final date = _dateOnly(record.scanDate);
      countsByDate.update(date, (count) => count + 1, ifAbsent: () => 1);
    }

    return List<ScanVolumeBucketEntity>.generate(windowDays, (index) {
      final date = today.subtract(Duration(days: windowDays - index - 1));
      return ScanVolumeBucketEntity(
        label: _dayLabel(date.weekday),
        date: date,
        count: countsByDate[date] ?? 0,
      );
    });
  }

  List<FileTypeMetricEntity> _buildTopFileTypes(
    List<ScanHistoryRecordEntity> records, {
    required int totalScans,
  }) {
    final countsByExtension = <String, int>{};

    for (final record in records) {
      final extension = record.extension.toUpperCase();
      countsByExtension.update(
        extension,
        (count) => count + 1,
        ifAbsent: () => 1,
      );
    }

    final entries = countsByExtension.entries.toList()
      ..sort((left, right) => right.value.compareTo(left.value));

    return entries.take(5).map((entry) {
      return FileTypeMetricEntity(
        extension: entry.key,
        count: entry.value,
        ratio: totalScans == 0 ? 0 : entry.value / totalScans,
      );
    }).toList();
  }

  DateTime _dateOnly(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  String _dayLabel(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Mon';
      case DateTime.tuesday:
        return 'Tue';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thu';
      case DateTime.friday:
        return 'Fri';
      case DateTime.saturday:
        return 'Sat';
      default:
        return 'Sun';
    }
  }
}
