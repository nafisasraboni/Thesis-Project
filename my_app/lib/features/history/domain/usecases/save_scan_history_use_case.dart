import '../../../scanner/domain/entities/scan_report_entity.dart';
import '../repositories/scan_history_repository.dart';

/// Saves a completed scan report into local history storage.
class SaveScanHistoryUseCase {
  /// Creates the use case.
  const SaveScanHistoryUseCase(this._repository);

  final ScanHistoryRepository _repository;

  Future<void> call(ScanReportEntity report) {
    return _repository.saveScanReport(report);
  }
}
