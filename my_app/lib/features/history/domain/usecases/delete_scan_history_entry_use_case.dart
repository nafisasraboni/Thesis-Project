import '../repositories/scan_history_repository.dart';

/// Deletes a single scan history entry.
class DeleteScanHistoryEntryUseCase {
  /// Creates the use case.
  const DeleteScanHistoryEntryUseCase(this._repository);

  final ScanHistoryRepository _repository;

  Future<void> call(int id) => _repository.deleteHistoryEntry(id);
}
