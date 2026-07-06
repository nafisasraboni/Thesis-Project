import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/providers/history_providers.dart';
import '../../domain/entities/history_query_entity.dart';

final historyActionsControllerProvider = Provider<HistoryActionsController>(
  HistoryActionsController.new,
);

/// Executes destructive or export actions for persisted history records.
class HistoryActionsController {
  /// Creates a controller.
  HistoryActionsController(this.ref);

  final Ref ref;

  Future<void> deleteHistoryEntry(int id) {
    return ref.read(deleteScanHistoryEntryUseCaseProvider)(id);
  }

  Future<void> clearHistory() {
    return ref.read(clearScanHistoryUseCaseProvider)();
  }

  Future<bool> exportHistory(HistoryQueryEntity query) async {
    final records = await ref.read(getScanHistoryUseCaseProvider)(query);
    if (records.isEmpty) {
      return false;
    }

    return ref.read(historyExportServiceProvider).export(records);
  }
}
