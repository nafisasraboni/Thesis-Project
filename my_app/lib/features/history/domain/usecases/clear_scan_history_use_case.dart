import '../repositories/scan_history_repository.dart';

/// Clears all persisted scan history records.
class ClearScanHistoryUseCase {
  /// Creates the use case.
  const ClearScanHistoryUseCase(this._repository);

  final ScanHistoryRepository _repository;

  Future<void> call() => _repository.clearHistory();
}
