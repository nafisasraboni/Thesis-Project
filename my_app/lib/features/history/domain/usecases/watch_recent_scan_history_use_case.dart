import '../entities/scan_history_record_entity.dart';
import '../repositories/scan_history_repository.dart';

/// Watches the most recent persisted history entries.
class WatchRecentScanHistoryUseCase {
  /// Creates the use case.
  const WatchRecentScanHistoryUseCase(this._repository);

  final ScanHistoryRepository _repository;

  Stream<List<ScanHistoryRecordEntity>> call({int limit = 5}) {
    return _repository.watchRecentHistory(limit: limit);
  }
}
