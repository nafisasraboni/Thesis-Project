import '../../../../data/local/app_database.dart';
import '../../domain/entities/history_query_entity.dart';
import '../../domain/entities/scan_history_record_entity.dart';
import '../../domain/entities/scan_history_summary_entity.dart';
import '../../domain/repositories/scan_history_repository.dart';
import '../../../scanner/domain/entities/scan_report_entity.dart';

/// Drift-backed implementation of the local scan history repository.
class ScanHistoryRepositoryImpl implements ScanHistoryRepository {
  /// Creates a repository implementation.
  const ScanHistoryRepositoryImpl(this._database);

  final AppDatabase _database;

  @override
  Future<void> saveScanReport(ScanReportEntity report) {
    return _database.insertScanHistory(
      buildScanHistoryCompanion(
        fileName: report.asset.fileName,
        extension: report.asset.extension,
        sizeInBytes: report.asset.sizeInBytes,
        sha256: report.asset.sha256,
        prediction: report.prediction.prediction,
        confidence: report.prediction.confidence,
        processingTime: report.prediction.processingTime,
        probabilities: report.prediction.probabilities,
        assetType: report.asset.assetType.name,
        scanDate: report.scanDate,
      ),
    );
  }

  @override
  Stream<List<ScanHistoryRecordEntity>> watchHistory(HistoryQueryEntity query) {
    return _database.watchHistory(query: query);
  }

  @override
  Future<List<ScanHistoryRecordEntity>> getHistory(HistoryQueryEntity query) {
    return _database.getHistory(query: query);
  }

  @override
  Stream<List<ScanHistoryRecordEntity>> watchRecentHistory({int limit = 5}) {
    return _database.watchRecentHistory(limit: limit);
  }

  @override
  Stream<ScanHistorySummaryEntity> watchSummary() {
    return _database.watchAllHistory().map((records) {
      final total = records.length;
      final safe = records
          .where((record) => record.prediction == 'Safe')
          .length;
      final suspicious = records
          .where((record) => record.prediction == 'Suspicious')
          .length;
      final malware = records
          .where((record) => record.prediction == 'Malware Detected')
          .length;
      final averageConfidence = total == 0
          ? 0.0
          : records
                    .map((record) => record.confidence)
                    .reduce((sum, value) => sum + value) /
                total;

      return ScanHistorySummaryEntity(
        totalScannedFiles: total,
        safeFiles: safe,
        suspiciousFiles: suspicious,
        malwareDetectedFiles: malware,
        averageConfidence: averageConfidence,
        lastScan: records.isEmpty ? null : records.first,
      );
    });
  }

  @override
  Future<void> deleteHistoryEntry(int id) {
    return _database.deleteHistoryEntry(id);
  }

  @override
  Future<void> clearHistory() {
    return _database.clearHistory();
  }
}
