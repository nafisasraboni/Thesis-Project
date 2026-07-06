import '../entities/history_query_entity.dart';
import '../entities/scan_history_record_entity.dart';
import '../repositories/scan_history_repository.dart';

/// Watches persisted history entries based on a live query.
class WatchScanHistoryUseCase {
  /// Creates the use case.
  const WatchScanHistoryUseCase(this._repository);

  final ScanHistoryRepository _repository;

  Stream<List<ScanHistoryRecordEntity>> call(HistoryQueryEntity query) {
    return _repository.watchHistory(query);
  }
}
