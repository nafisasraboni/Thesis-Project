import '../entities/scan_history_summary_entity.dart';
import '../repositories/scan_history_repository.dart';

/// Watches aggregate scan history statistics for dashboard consumption.
class WatchScanHistorySummaryUseCase {
  /// Creates the use case.
  const WatchScanHistorySummaryUseCase(this._repository);

  final ScanHistoryRepository _repository;

  Stream<ScanHistorySummaryEntity> call() => _repository.watchSummary();
}
