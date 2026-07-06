import '../entities/history_query_entity.dart';
import '../entities/scan_history_record_entity.dart';
import '../repositories/scan_history_repository.dart';

/// Loads history records for one-shot operations.
class GetScanHistoryUseCase {
  /// Creates the use case.
  const GetScanHistoryUseCase(this._repository);

  final ScanHistoryRepository _repository;

  Future<List<ScanHistoryRecordEntity>> call(HistoryQueryEntity query) {
    return _repository.getHistory(query);
  }
}
