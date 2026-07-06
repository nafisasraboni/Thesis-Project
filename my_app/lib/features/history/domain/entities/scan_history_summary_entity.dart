import 'scan_history_record_entity.dart';

/// Aggregated dashboard and analytics summary derived from local history.
class ScanHistorySummaryEntity {
  /// Creates a history summary.
  const ScanHistorySummaryEntity({
    required this.totalScannedFiles,
    required this.safeFiles,
    required this.suspiciousFiles,
    required this.malwareDetectedFiles,
    required this.averageConfidence,
    required this.lastScan,
  });

  final int totalScannedFiles;
  final int safeFiles;
  final int suspiciousFiles;
  final int malwareDetectedFiles;
  final double averageConfidence;
  final ScanHistoryRecordEntity? lastScan;

  double get safeRatio =>
      totalScannedFiles == 0 ? 0 : safeFiles / totalScannedFiles;

  double get suspiciousRatio =>
      totalScannedFiles == 0 ? 0 : suspiciousFiles / totalScannedFiles;

  double get malwareRatio =>
      totalScannedFiles == 0 ? 0 : malwareDetectedFiles / totalScannedFiles;
}
