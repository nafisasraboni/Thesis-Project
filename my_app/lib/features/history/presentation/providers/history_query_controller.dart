import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/providers/history_providers.dart';
import '../../domain/entities/history_query_entity.dart';
import '../../domain/entities/scan_history_record_entity.dart';

final historyQueryControllerProvider =
    NotifierProvider<HistoryQueryController, HistoryQueryEntity>(
      HistoryQueryController.new,
    );

final historyRecordsProvider = StreamProvider<List<ScanHistoryRecordEntity>>((
  ref,
) {
  final query = ref.watch(historyQueryControllerProvider);
  final watchHistoryUseCase = ref.watch(watchScanHistoryUseCaseProvider);
  return watchHistoryUseCase(query);
});

/// Controls the active history query state.
class HistoryQueryController extends Notifier<HistoryQueryEntity> {
  @override
  HistoryQueryEntity build() {
    return const HistoryQueryEntity();
  }

  void setSearchTerm(String value) {
    state = state.copyWith(searchTerm: value);
  }

  void setFilter(HistoryFilter filter) {
    state = state.copyWith(filter: filter);
  }

  void setSortOption(HistorySortOption sortOption) {
    state = state.copyWith(sortOption: sortOption);
  }
}
