import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/providers/history_providers.dart';
import '../../../history/domain/entities/scan_history_record_entity.dart';
import '../../../history/domain/entities/scan_history_summary_entity.dart';

final dashboardSummaryProvider = StreamProvider<ScanHistorySummaryEntity>((
  ref,
) {
  return ref.watch(watchScanHistorySummaryUseCaseProvider)();
});

final dashboardRecentHistoryProvider =
    StreamProvider<List<ScanHistoryRecordEntity>>((ref) {
      return ref.watch(watchRecentScanHistoryUseCaseProvider)(limit: 5);
    });
