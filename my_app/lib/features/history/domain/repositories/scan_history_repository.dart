import '../../../scanner/domain/entities/scan_report_entity.dart';
import '../entities/history_query_entity.dart';
import '../entities/scan_history_record_entity.dart';
import '../entities/scan_history_summary_entity.dart';

/// Repository abstraction for persisted scan history records.
abstract class ScanHistoryRepository {
  /// Saves a completed scan report to local history.
  Future<void> saveScanReport(ScanReportEntity report);

  /// Watches history records matching the provided query.
  Stream<List<ScanHistoryRecordEntity>> watchHistory(HistoryQueryEntity query);

  /// Loads history records for synchronous operations such as export.
  Future<List<ScanHistoryRecordEntity>> getHistory(HistoryQueryEntity query);

  /// Watches the most recent persisted records.
  Stream<List<ScanHistoryRecordEntity>> watchRecentHistory({int limit = 5});

  /// Watches the aggregated history summary.
  Stream<ScanHistorySummaryEntity> watchSummary();

  /// Deletes a single history record by id.
  Future<void> deleteHistoryEntry(int id);

  /// Clears the entire persisted history.
  Future<void> clearHistory();
}
